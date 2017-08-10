//
//  CAMSearchAndSortTest.m
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CAMSearchAndSort.h"

@interface CAMSearchAndSortTest : XCTestCase

@property (nonatomic, strong) CAMSearchAndSort *searchAndSort;

@end

@implementation CAMSearchAndSortTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.searchAndSort = [CAMSearchAndSort new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)ascArraySearch {
    NSInteger index = [self.searchAndSort binarySearchWithArray:@[@2,@3,@8,@10,@15,@20,@30] target:15];
    NSAssert(index == 4, @"递增数组查找成功");
}

- (void)descArraySearch {
    NSInteger index = [self.searchAndSort binarySearchWithArray:@[@30,@20,@15,@10,@8,@3,@2] target:15];
    NSAssert(index == 2, @"递减数组超找成功");
}

- (void)emptyArraySerch {
    NSInteger index = [self.searchAndSort binarySearchWithArray:nil target:10];
    NSAssert(index == -1, @"空数组");
}

- (void)nonTarget {
    NSInteger index = [self.searchAndSort binarySearchWithArray:@[@2,@6,@7,@9,@17,@20] target:100];
    NSAssert(index == -1, @"non target");
}

- (void)bubblingSort {
    [self.searchAndSort bubblingSort:@[@2,@5,@3,@6,@4,@7]];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    [self ascArraySearch];
//    [self descArraySearch];
//    [self emptyArraySerch];
//    [self nonTarget];
//    [self bubblingSort];
    
    NSArray *array = @[@1,@2,@3];
    
    NSMutableArray *result = [self.searchAndSort totalSubSet:[array mutableCopy] end:array.count - 1];
    
    NSLog(@"resutl = %@",result);
    
}

- (void)testSubset {
    [self.searchAndSort totolSubsetWithForCirculation];
}

- (void)testSort {
    [self.searchAndSort totolSort];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
