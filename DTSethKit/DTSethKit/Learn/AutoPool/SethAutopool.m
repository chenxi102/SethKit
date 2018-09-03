//
//  SethAutopool.m
//  DTSethKit
//
//  Created by Seth on 2018/8/21.
//  Copyright © 2018年 detu. All rights reserved.
//

#import "SethAutopool.h"

@implementation SethAutopool
/*
 1.自动释放池(autorelease pool)是OC的一种内存自动回收机制. 具有延迟释放的特性，即当我们创建了一个对象，并把他加入到了自动释放池中时，他不会立即被释放，会等到一次runloop结束或者作用域超出{}或者超出[pool release]之后再被释放
 
 2.当你向一个对象发送一个autorelease消息的时候,Cocoa就会将对象的一个引用放入
 到最新的自动释放池中(当前线程栈顶位置),它仍然是一个对象,因此自动释放池定义的作用域内的其他对象都可以向他发送消息.一个自动释放池存储的对象当自己被销毁的时会向其中的对象发送 release 消息。
*/

// mrc
- (void)autopool_exp1 {
//    NSAutoreleasePool * autoPool = [NSAutoreleasePool new];
//    NSDictionary * dic = [NSDictionary new];
//    [dic autorelease];
//    [autoPool release];
}

// arc
- (void)autoPool_exp2 {
    //1.
    @autoreleasepool {
        NSDictionary * dic = [NSDictionary new];
    }
    //2.
    NSDictionary * __autoreleasing dic2 = [NSDictionary new];
    
    //3.
    @autoreleasepool {
        // 最近的释放
        NSDictionary * dic2 = [NSDictionary new];
        @autoreleasepool {
            // 最近的释放
            NSDictionary * dic3 = [NSDictionary new];
        }
        
    }
    
}

@end
