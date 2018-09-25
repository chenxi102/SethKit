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
 
 3. 一个线程对应一个runloop，系统会为每一个runloop隐式的创建一个自动释放池，所有的autoreleasePool构成一个栈式结构，在每个runloop结束时，当前栈顶的autoreleasePool会被销毁，而且会对其中的每一个对象做一次release（严格来说，是你对这个对象做了几次autorelease就会做几次release，不一定是一次)，特别指出，使用容器的block版本的枚举器的时候，系统会自动添加一个autoreleasePool
 [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
 // 这里被一个局部@autoreleasepool包围着
 }];
 
 ========使用场景 Autoreleasepool 应用场景 =======
 
 1).对象作为函数返回值 （MRC）
    当一个对象要作为函数返回值的时候，因为要遵循谁申请谁释放的思想，所以应该在返回之前释放，但要是返回之前释放了，就会造成野指针错误，但是要是不释放，那么就违背了谁申请谁释放的原则，所以就可以使用autorelease延迟释放的特性，将其在返回之前做一次autorelease，加入到自动释放池中，保证可以被返回，一次runloop之>>后系统会帮我们释放他
 2).自动释放池可以延长对象的声明周期，如果一个事件周期很长，比如有一个很长的循环逻辑，那么一个临时变量可能很长时间都不会被释放，一直在内存中保留，那么内存的峰值就会一直增加，但是其实这个临时变量是我们不再需要的。这个时候就通过创建新的自动释放池来缩短临时变量的生命周期来降低内存的峰值。
 3).临时生成大量对象,一定要将自动释放池放在for循环里面，要释放在外面，就会因为大量对象得不到及时释放，而造成内存紧张，最后程序意外退出
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
