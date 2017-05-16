//
//  ViewController.m
//  DTSethKit
//
//  Created by Seth on 17/2/27.
//  Copyright © 2017年 detu. All rights reserved.
//

#import "ViewController.h"
#import "ChainSyntaxSample.h"

@interface ViewController ()

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
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
