
// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html

@"Method,SEL,IMP概念"
/*
SEL ：Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL。
SEL也是@selector的类型，用来表示OC运行时的方法的名字。来看一下OC中的定义

本质上，SEL只是一个指向方法的指针（准确的说，只是一个根据方法名hash化了的KEY值，能唯一代表一个方法），它的存在只是为了加快方法的查询速度。这个查找过程我们将在下面说明。
我们可以在运行时添加新的selector，也可以在运行时获取已存在的selector。
*/

@"IMP"
/*
实际上是一个函数指针，指向方法实现的首地址，定义如下：

关于IMP的几点说明：

使用当前CPU架构实现的标准的C调用约定
第一个参数是指向self的指针（如果是实例方法，则是类实例的内存地址；如果是类方法，则是指向元类的指针）
第二个参数是方法选择器(selector)，
从第三个参数开始是方法的实际参数列表。
通过取得IMP，我们可以跳过Runtime的消息传递机制，直接执行IMP指向的函数实现，这样省去了Runtime消息传递过程中所做的一系列查找操作，会比直接向对象发送消息高效一些，当然必须说明的是，这种方式只适用于极特殊的优化场景，如效率敏感的场景下大量循环的调用某方法。
*/

@"Method"
/*
直接上定义：
Method = SEL + IMP + method_types，相当于在SEL和IMP之间建立了一个映射
*/

@"iOS方法调用流程"
/*
方法调用的核心是objc_msgSend方法：
objc_msgSend(receiver, selector, arg1,arg2,…)
具体的过程如下：

先找到selector 对应的方法实现(IMP)，因为同一个方法可能在不同的类中有不同的实现，所以需要receiver的类来找到确切的IMP
IMP class_getMethodImplementation(Class class, SEL selector)
如同其文档所说：The function pointer returned may be a function internal to the runtime instead of an actual method implementation. For example, if instances of the class do not respond to the selector, the function pointer returned will be part of the runtime's message forwarding machinery.
具体来说，当找不到IMP的时候，方法返回一个 _objc_msgForward 对象，用来标记需要转入消息转发流程，我们现在用的AOP框架也是利用了这个机制来人为的制造找不到IMP的假象来触发消息转发的流程

如果实在对_objc_msgFroward的内部实现感兴趣，只能看看源码了，只不过都是汇编实现的....感兴趣的同学可以想想为什么是用汇编来实现
这里有个源码的镜像https://github.com/opensource-apple ，如果翻墙费劲的话
根据查找结果
找到了IMP，调用找到的IMP，传入参数
没找到IMP，转入消息转发流程
将IMP的返回值作为自己的返回值
补充说明一下IMP的查找过程，消息传递的关键在于objc_class结构体中的以下几个东西：

Class *isa
Class *super_class
objc_method_list **methodLists
objc_cache *cache
当消息发送给一个对象时，objc_msgSend通过对象的isa获取到类的结构体，然后在cache和methodLists中查找，如果没找到就找其父类，以此类推知道找到NSObject类，如果还没找到，就走消息转发流程。
*/

@"iOS方法转发流程"
/*
从上文中我们看到当obj无法查找到 IMP时，会返回一个特定的IMP _objc_msgForward , 然后会进入消息转发流程，具体流程如下：

动态方法解析
resolveInstanceMethod:解析实例方法
resolveClassMethod:解析类方法
通过class_addMethod的方式将缺少的selector动态创建出来，前提是有提前实现好的IMP（method_types一致）
这种方案更多的是位@dynamic属性准备的
备用接受者（AOP中有使用）
如果上一步没有处理，runtime会调用以下方法
-(id)forwardingTargetForSelector:(SEL)aSelector
如果该方法返回非nil的对象，则使用该对象作为新的消息接收者
不能返回self，会出现无限循环
如果不知道该返回什么，应该使用[super forwardingTargetForSelector:aSelector]
这种方法属于单纯的转发，无法对消息的参数和返回值进行处理
完整转发（AOP中有使用）
- (void)forwardInvocation:(NSInvocation *)anInvocation
对象需要创建一个NSInvocation对象，把消息调用的全部细节封装进去，包括selector, target, arguments 等参数，还能够对返回结果进行处理
为了使用完整转发，需要重写以下方法
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector，如果2中return nil,执行methodSignatureForSelector：
因为消息转发机制为了创建NSInvocation需要使用这个方法吗获取信息，重写它为了提供合适的方法签名
*/
