//: Playground - noun: a place where people can play

import UIKit

//数据定义
var str = "Hello, playground"

let students = ["Nora", "Fern", "Ryan", "Rainer"]

let nameToCheck = "Ryan"
if students.contains(nameToCheck) {
    print("\(nameToCheck) is signed up!")
} else {
    print("No record of \(nameToCheck).")
}

let y = Int8(exactly: 1_10)
print(y as Any)

// 类的定义
class UIPracticeViewController: UIViewController {
    var constString:NSString! = "abc"
    var constString1 = "abc"
    var constarrs = ["abc"]
    
    var firstView:UIView!{
        didSet{
            NSLog("已经改变")
        }
    }
    
    print("\(constString)")
}

