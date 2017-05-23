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

+ (instancetype)shareInstance
{
    static SethMethodManager * objc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!objc) {
            objc = [SethMethodManager new];
        }
    });
    return objc;
}

- (void)swizzleAClass:(Class )aCls
              Amethod:(SEL)asel
               BClass:(Class )bCls
              Bmethod:(SEL)bsel
{
    Method a = class_getInstanceMethod(aCls, asel);
    Method b = class_getInstanceMethod(bCls, bsel);
    method_exchangeImplementations(a, b);
}

- (void)hookClass:(Class )cls
           method:(SEL)sel
        withBlock:(void(^)())block
{
    Method methoda = class_getInstanceMethod(cls, sel);
    IMP impA = imp_implementationWithBlock(block);
    Method methodb = (__bridge Method)(imp_getBlock(impA));
    method_exchangeImplementations(methoda, methodb);
}

@end





static void SethSpect_performLocked(dispatch_block_t block) {
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}

