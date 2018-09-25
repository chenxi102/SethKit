//
//  DispatchGCD.h
//  DTSethKit
//
//  Created by Seth on 2017/5/22.
//  Copyright © 2017年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, TimerType) {
    DTSethTimerGCD      = 1 ,
    DTSethTimerCAD      = 2 ,
    DTSethTimerNSTimer  = 3
};

@interface DispatchGCD : NSObject
- (void)schechRepeatTimer:(NSTimeInterval)time andType:(TimerType)type  Res:(dispatch_block_t)block ;
- (void) invalidate ;
- (void) barriesAndGroups ;
@end
