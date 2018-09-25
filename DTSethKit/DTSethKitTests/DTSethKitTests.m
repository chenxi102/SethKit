//
//  DTSethKitTests.m
//  DTSethKitTests
//
//  Created by Seth on 2018/9/6.
//  Copyright © 2018年 detu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface DTSethKitTests : XCTestCase

@end

@implementation DTSethKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSLog(@"异步执行");
    XCTestExpectation *expectation = [self expectationWithDescription:@"异步测试"];
    
    
    NSLog(@"执行顺序：1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"执行顺序：3");
        [expectation fulfill];
    });
    
    
//    asynBlockTest();
    NSLog(@"执行顺序：2");
    
    
    // 这个线程最多等待30秒，
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"执行顺序：4");
    }];
}


- (void)testPerformanceExample {
    NSLog(@"性能测试：时间");
    [self measureBlock:^{
        ViewController * vc = [ViewController new];
        for ( int i = 0; i < 99; i ++) {
            [vc measureTest];
        }
    }];
}

@end
