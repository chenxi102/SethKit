//
//  DispatchGCD.m
//  DTSethKit
//
//  Created by Seth on 2017/5/22.
//  Copyright © 2017年 detu. All rights reserved.
//

#import "DispatchGCD.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <libkern/OSAtomic.h>

@interface DispatchGCD ()

@property (atomic, strong) id timer;

@end

@implementation DispatchGCD


- (void)schechRepeatTimer:(NSTimeInterval)time andType:(TimerType)type  Res:(dispatch_block_t)block
{
    seth_performLocked(^{
        
        if (type == DTSethTimerGCD) {
            // timer 不能用局部的变量，必须用全局的
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, time * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(timer, block);
            dispatch_resume(timer);
            self.timer = timer;
        }
        else
        {
            if (type == DTSethTimerNSTimer) {
                NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timerVocation:) userInfo:block repeats:YES];
                self.timer = timer;
            }else{
                IMP impA = imp_implementationWithBlock(block);
                Method method = (__bridge Method)(imp_getBlock(impA));
                SEL method_sel = method_getName(method);
                CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:method_sel];
                [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
                self.timer = timer;
            }
        }
        
    });
}

- (void)cancel {
    if (self.timer) {
        dispatch_suspend(self.timer);
    }
}

- (void)resume {
    if (self.timer) {
        dispatch_resume(self.timer);
    }
}

- (void)invalidate {
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)timerVocation:(NSTimer *)sender {
    if (sender.userInfo) {
        dispatch_block_t timerBlcok = sender.userInfo;
        timerBlcok();
    }
}

- (void)barriesAndGroups {

    dispatch_queue_t queue = dispatch_queue_create("dispatch.global", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"barries queue 1");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
           NSLog(@"barries queue 2");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"barries queue 3");
    });

    dispatch_async(queue, ^{
        NSLog(@"barries queue 4");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"barries queue 5");
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"barries queue 6");
    });
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"group queue 1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"group queue 2");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"group queue 3");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"group queue 4");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"group全部执行完毕");
    });
    
    
}


// http://upload-images.jianshu.io/upload_images/1492490-3d0f076d66775e93.png?imageMogr2/auto-orient/strip

// 锁：临界区保护
// 自旋锁：调用者不会睡眠，循环检测标志位，一直检测解锁，适用于短时间的加锁，长时间消耗会有线性增长
// 互斥锁：调用者会睡眠，等待解锁，适用于长时间的加锁，有切换上下文的CPU消耗
// 信号量：多线程使用
// 条件锁：符合条件的时候加锁解锁
//
static void seth_performLocked(dispatch_block_t block) {
    static OSSpinLock seth_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&seth_lock);
    block();
    OSSpinLockUnlock(&seth_lock);
}

@end


