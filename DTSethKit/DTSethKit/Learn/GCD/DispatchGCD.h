//
//  DispatchGCD.h
//  DTSethKit
//
//  Created by Seth on 2017/5/22.
//  Copyright © 2017年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchGCD : NSObject
#warning 没效果 待检测
- (void) dispatch_RepeatTimer:(NSTimeInterval)time Res:(dispatch_block_t)block ;
- (void) invalidate ;
- (void) GCDtimer ;
- (void) barriesAndGroups ;
@end
