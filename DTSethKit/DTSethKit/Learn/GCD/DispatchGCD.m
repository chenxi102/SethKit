//
//  DispatchGCD.m
//  DTSethKit
//
//  Created by Seth on 2017/5/22.
//  Copyright © 2017年 detu. All rights reserved.
//

#import "DispatchGCD.h"

@interface DispatchGCD ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation DispatchGCD

- (dispatch_source_t)timer {
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    }
    return _timer;
}

- (void)dispatch_RepeatTimer:(NSTimeInterval)time Res:(dispatch_block_t)block
{
    // timer 不能用局部的变量，必须用全局的
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, time * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, block);
    dispatch_resume(self.timer);
    
//    关闭心跳定时器
//    dispatch_source_cancel(timer);
//    timer = nil;
//    暂停定时器
//    dispatch_suspend(self.timer);
//    dispatch_resume(self.timer);
}

- (void)invalidate
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
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

@end
