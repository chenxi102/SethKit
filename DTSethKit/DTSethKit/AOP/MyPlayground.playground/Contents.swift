//: Playground - noun: a place where people can play



// 1.最终的结论就是，除非开发者能保证访问锁的线程全部都处于同一优先级，否则 iOS 系统中所有类型的自旋锁都不能再使用了。

//NSMethodSignature *sig = [delegate_ methodSignatureForSelector:sel];
//NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
//[invocation setSelector:sel];
//[invocation setTarget:delegate_];
//[invocation setArgument:&self atIndex:2];
//[invocation setArgument:&auth atIndex:3];
//[invocation setArgument:&error atIndex:4];
//[invocation invoke];
