//
//  CAMQueueUseStackTest.m
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CAMQueueUseStack.h"

@interface CAMQueueUseStackTest : XCTestCase

@property (nonatomic, strong) CAMQueueUseStack *queue;

@end

@implementation CAMQueueUseStackTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.queue = [CAMQueueUseStack new];
}

//空队列添加和删除元素
- (void)emptyQueueAddAndDelete {
    [self.queue push:@"1"];
    [self.queue push:@"2"];
    [self.queue push:@"3"];
    [self.queue deleteHead];
    BOOL pass = [[self.queue listAllElements] isEqualToArray:@[@"3",@"2"]];
    NSAssert(pass, @"emptyQueueAddAndDelete");

}
//非空队列添加和删除元素
- (void)nonEmptyQueueAddAndDelete {
    [self.queue push:@"4"];
    [self.queue push:@"5"];
    [self.queue deleteHead];
    BOOL pass = [[self.queue listAllElements] isEqualToArray:@[@"5",@"4",@"3"]];
    NSAssert(pass, @"nonEmptyQueueAddAndDelete");
}
//删除所有的元素
- (void)deleteAllElement {
    NSInteger count = [[self.queue listAllElements] count];
    for (int i = 0 ; i < count; i ++) {
        [self.queue deleteHead];
    }
    
    BOOL pass = [[self.queue listAllElements] count] == 0;
    NSAssert(pass, @"deleteAllElement");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self emptyQueueAddAndDelete];
    
    [self nonEmptyQueueAddAndDelete];
    
    [self deleteAllElement];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
