//
//  ViewController.m
//  DTSethKit
//
//  Created by Seth on 17/2/27.
//  Copyright © 2017年 detu. All rights reserved.
//
#import "Aspects.h"
#import "ViewController.h"
#import "ChainSyntaxSample.h"
#import "DispatchGCD.h"
#import "SethMethodManager.h"


@interface ViewController ()
@property(nonatomic, strong) DispatchGCD * gcd;
@property (weak, nonatomic) IBOutlet UIButton *autoCaptureBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoRecordBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
     //TODO: Chain Syntax Sample
     ChainSyntaxSample *  sample = [ChainSyntaxSample new];
     DeveloperMode(
     NSLog(@"测试模模式才会打开");
     NSLog(@"");
     NSLog(@"");
     NSLog(@"");
     NSLog(@"");
     NSLog(@"");
     NSLog(@"");
     
     );
     [sample test];
//     */
    
    
    //TODO: GCD
//    _gcd = [DispatchGCD new];
//    [_gcd schechRepeatTimer:1 andType:DTSethTimerCAD Res:^{
//        NSLog(@"repeat???");
//        [_gcd invalidate];
//    }];
//    [gcd GCDtimer];
//    [gcd barriesAndGroups];
    
    
    //TODO: GCD
//    [[SethMethodManager shareInstance] hookClass:[UIViewController class] method:@selector(viewWillAppear:) withBlock:^{
//        NSLog(@"viewController will appear ...");
//    }];
    
//    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^{
//        NSLog(@"viewController will appear ...");
//    } error:nil];
    
    
}

- (void)measureTest {
    
    NSMutableArray * mut = [NSMutableArray array];
    for (int i = 0; i < 99 ; i ++) {
        UIImage * image = [UIImage new];
        [mut addObject:image];
        usleep(10);
    }
}

+ (NSMutableArray *)groupWithObjs:(id)obj, ...
{

    NSMutableArray* objs = [NSMutableArray new];
    [objs addObject:obj];
    
    va_list args;
    va_start(args, obj);
    id parmObj;
    while ((parmObj = va_arg(args, id))) {
        [objs addObject:parmObj];
    }
    va_end(args);
    
    return objs;
}

- (void)printSomething:(void(^)(id obj, ...))rec {
    
    rec(@"1",@"2",@"3");
 
    [self printSomething:^(id obj, ...) {
        
        NSMutableArray* objs = [NSMutableArray new];
        [objs addObject:obj];
        va_list args;
        va_start(args, obj);
        id p_obj;
        while ((p_obj = va_arg(args, id))) {
            [objs addObject:p_obj];
        }
        va_end(args);
        
    }];
}

- (IBAction)autoRecord:(UIButton *)sender {
    [[self class] groupWithObjs:@[@"1",@"2"]];
}

- (IBAction)autoCapture:(UIButton *)sender
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
