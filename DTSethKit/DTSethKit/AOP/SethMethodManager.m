//
//  SethMethodManager.m
//  DTSethKit
//
//  Created by Seth on 2017/5/18.
//  Copyright © 2017年 detu. All rights reserved.
//



#import "SethMethodManager.h"
#import <objc/runtime.h>
#import <libkern/OSAtomic.h>

@interface NSPersonNameComponent : NSObject

@end

@implementation NSPersonNameComponent


@end

@implementation SethMethodManager

- (void)msgsend {

    
}



@end





static void sethAspect_performLocked(dispatch_block_t block) {
    static OSSpinLock sethAspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&sethAspect_lock);
    block();
    OSSpinLockUnlock(&sethAspect_lock);
}
