//
//  Macros.h
//  DTSethKit
//
//  Created by Seth on 17/3/21.
//  Copyright © 2017年 detu. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


// TODO: WeakSelf   StrongSelf

#define WeakSelf   __weak typeof(self)weakself = self;
#define StrongSelf   __strong typeof(weakself)self = weakself;

// TODO: Test code switch 

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


//强制横竖屏
#define CameraOrientationPortrait(portrait)\
SEL selector = NSSelectorFromString(@"setOrientation:");\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];\
[invocation setSelector:selector];\
[invocation setTarget:[UIDevice currentDevice]];\
int val = portrait;\
[invocation setArgument:&val atIndex:2];\
[invocation invoke];



#endif /* Macros_h */
