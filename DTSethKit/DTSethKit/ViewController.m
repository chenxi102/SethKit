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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     /*
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
     */
    
    /*
    //TODO: GCD
    _gcd = [DispatchGCD new];
    [_gcd dispatch_RepeatTimer:1 Res:^{
        NSLog(@"repeat???");
        [_gcd invalidate];
    }];
    //    [gcd GCDtimer];
    //    [gcd barriesAndGroups];
    */
    
    
    
    //TODO: GCD
    [[SethMethodManager shareInstance] hookClass:[UIViewController class] method:@selector(viewWillAppear:) withBlock:^{
        NSLog(@"viewController will appear ...");
    }];
    
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"viewController will appear ...");
    } error:nil];
    
    
}

- (IBAction)test:(UIButton *)sender
{
    UIViewController * vc = [UIViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
