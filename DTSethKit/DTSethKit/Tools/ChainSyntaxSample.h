//
//  ChainSyntaxSample.h
//  DTSethKit
//
//  Created by Seth on 17/3/21.
//  Copyright © 2017年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

@class ChainSyntaxSample;

typedef ChainSyntaxSample*(^fuckOffVoid)();
typedef ChainSyntaxSample*(^fuckOffNsstring)(NSString * fuck);


typedef ChainSyntaxSample*(^fuckOffid)(id);

@interface ChainSyntaxSample : NSObject

- (fuckOffVoid)one;
- (fuckOffNsstring)two;
- (void)test;

@end
