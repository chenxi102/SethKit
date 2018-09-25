//
//  ChainSyntaxSample.m
//  DTSethKit
//
//  Created by Seth on 17/3/21.
//  Copyright © 2017年 detu. All rights reserved.
//

#import "ChainSyntaxSample.h"

#define semaphore_outTime  500

@interface ChainSyntaxSample()

@property (nonatomic) dispatch_queue_t dispatch_queue_serail;
@property (nonatomic) dispatch_semaphore_t dispatch_semaphore_sigal;

@end


@implementation ChainSyntaxSample

- (void)waitForRes
{
   long timeOut =  dispatch_semaphore_wait(self.dispatch_semaphore_sigal, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(semaphore_outTime * NSEC_PER_SEC)));
    if (timeOut > 0 ) {
        NSLog(@"等待超时");
    }
}

- (void)noWaitjustContinue {
    dispatch_semaphore_signal(self.dispatch_semaphore_sigal);
}

- (dispatch_queue_t)dispatch_queue_serail {

    if (!_dispatch_queue_serail) {
        _dispatch_queue_serail = dispatch_queue_create("dispatch_queue_serail", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(_dispatch_queue_serail, dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH));
    }
    return _dispatch_queue_serail;
}

- (ChainSyntaxSample *)start {
    self.dispatch_semaphore_sigal = dispatch_semaphore_create(0);
    return self;
};



// TODO: method ...

- (fuckOffVoid)one{
    @weak(self)
    return ^(NSString *param1, NSString *param2){
        @strong(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@\n%@", param1, param2);
            [self noWaitjustContinue];
        });
        [self waitForRes];
        return self;
    };
}

- (fuckOffNsstring)two
{
    @weak(self)
    return ^(NSString * fuck){
        @strong(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", fuck);
            [self noWaitjustContinue];
        });
        [self waitForRes];
        return self;
    };
}


- (void)test {
    
    dispatch_async(self.dispatch_queue_serail, ^{
        self.start.one(@"log 1", @"log 2").two(@"log 3");
    });
}



- (fuckOffid)then {
    
    @weak(self)
    return ^(id block) {
        @strong(self)
        
        return self;
    };
}

- (void)dealloc {

}

@end
