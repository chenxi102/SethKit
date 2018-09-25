//
//  Macros.h
//  DTSethKit
//
//  Created by Seth on 17/3/21.
//  Copyright © 2017年 detu. All rights reserved.
//


// TODO:TODO
// MARK:MARK
// FIXME:FIXME

#ifndef Macros_h
#define Macros_h



// MARK: Test code switch
#define SWITCH    1
// SWITCH 为 0 , debug release 模式下 DeveloperMode 中代码不执行，
// SWITCH 为 1 , debug 模式下  DeveloperMode 中代码执行

#if DEBUG
#define iS_DEBUG   1
#else
#define iS_DEBUG   0
#endif
#define DeveloperMode(Stuff)   if (!iS_DEBUG) { \
\
\
} else { \
if (SWITCH) { Stuff;} \
\
}   \




// MARK:强制横竖屏
#define CameraOrientationPortrait(portrait)\
SEL selector = NSSelectorFromString(@"setOrientation:");\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];\
[invocation setSelector:selector];\
[invocation setTarget:[UIDevice currentDevice]];\
int val = portrait;\
[invocation setArgument:&val atIndex:2];\
[invocation invoke];


// MARK: WeakSelf   StrongSelf
#define weak(...)   autoreleasepool {}__weak typeof(__VA_ARGS__) weakClass = __VA_ARGS__;
#define strong(...)  autoreleasepool {}__strong typeof(__VA_ARGS__)__VA_ARGS__ = weakClass;

// MARK: Log system
#if DEBUG
// Debug
#define DeBugLog(fmt, ...)    NSLog((@"DeBugLog: %s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
// Socket
#define SocketLog(fmt, ...)    NSLog((@"SocketLog: %s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define DeBugLog(...)
#define SocketLog(...)
#endif


#endif /* Macros_h */
