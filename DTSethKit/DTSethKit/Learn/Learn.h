

1.  哈希表和字典的差异， 哈希表是一种数据结构，简单来说是（key，value）。oc中，字典是对哈希表的封装而成的容器。

2.  APPDelegate 设置应用的旋转事件 VC具体设置个体的旋转事件

3.  一个NSMutableString,现在用他给一个retain修饰 NSString赋值,那么只是将NSString指向了NSMutableString所指向的位置,并对NSMUtbaleString计数器加一,此时,如果对NSMutableString进行修改,也会导致NSString的值修改,原则上这是不允许的.  如果是copy修饰的NSString对象,在用NSMutableString给他赋值时,会进行深拷贝,及把内容也给拷贝了一份,两者指向不同的位置,即使改变了NSMutableString的值,NSString的值也不会改变.

4.  Other Linker Flags里面加入-ObjC标志。之所以使用该标志，和Objective-C的一个重要特性：类别（category)有关。根据这里的解释，Unix的标准静态库实现和Objective-C的动态特性之间有一些冲突：Objective-C没有为每个函数（或者方法）定义链接符号，它只为每个类创建链接符号。这样当在一个静态库中使用类别来扩展已有类的时候，链接器不知道如何把类原有的方法和类别中的方法整合起来，就会导致你调用类别中的方法时，出现"selector not recognized"，也就是找不到方法定义的错误。为了解决这个问题，引入了-ObjC标志，它的作用就是将静态库中所有的和对象相关的文件都加载进来。
    本来这样就可以解决问题了，不过在64位的Mac系统或者iOS系统下，链接器有一个bug，会导致只包含有类别的静态库无法使用-ObjC标志来加载文件。变通
    是使用-all_load 或者-force_load标志，它们的作用都是加载静态库中所有文件，不过all_load作用于所有的库，而-force_load后面必须要指定具
    的文件。
    在Xcode4.2之后，这个链接器bug已经被修复，因此-all_load 和 -force_load标志都不再需要了。在必要时添加-ObjC即可。

5.  lipo -info 查看库的指令集
    nm 查看所有方法

cocoapod：
    rm -rf /Users/loginnanme/Library/Caches/CocoaPods/     清除缓存


    往repos添加私有 reops
    4.pod repo add pravite_repo git@git.detu.com:cx/pravite_repo.git


    创建podspec
    5. pod spec create PanoPlayer git@git.detu.com:detu-opengl/panoplayer_ios.git

    往私有repo  push spec  命令
    1.pod repo push pravite_repo  spsdk.podspec --allow-warnings --use-libraries

    检验
    2. pod spec lint 检验
    3.pod spec lint --verbose --no-clean


