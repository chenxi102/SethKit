//
//  SethMethodManager.h
//  DTSethKit
//
//  Created by Seth on 2017/5/18.
//  Copyright © 2017年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SethMethodManager : NSObject

+ (instancetype)shareInstance;

- (void)swizzleAClass:(Class )aCls
              Amethod:(SEL)asel
               BClass:(Class )bCls
              Bmethod:(SEL)bsel;

- (void)hookClass:(Class )cls
           method:(SEL)sel
        withBlock:(void(^)())block;


- (void)methodInvacation;
@end
