//
//  FibonacciTest.m
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Fibonacci.h"

@interface FibonacciTest : XCTestCase

@property (nonatomic, strong) Fibonacci *fibonacci;

@end

@implementation FibonacciTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.fibonacci = [Fibonacci new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSInteger fibonacciNonRecursive = [self.fibonacci fibonacciNonRecursion:5];
    NSAssert(fibonacciNonRecursive == 5, @"pass");
    
    NSInteger fibonacciRecursive = [self.fibonacci fibonacciRecursion:3];
    
    NSAssert(fibonacciRecursive == 2, @"pass");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
    
}

@end
