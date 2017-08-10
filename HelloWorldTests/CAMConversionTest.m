//
//  CAMConversionTest.m
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CAMConversion.h"

@interface CAMConversionTest : XCTestCase

@property (nonatomic, strong) CAMConversion *conversion;

@end

@implementation CAMConversionTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.conversion = [CAMConversion new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSInteger count = [self.conversion numberOf1:10];
    NSAssert(count == 2, @"pass");
    
    NSInteger anotherCount = [self.conversion numberOf1Best:10];
    NSAssert(anotherCount == 2, @"pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
