//
//  AlgorithmSolutions.m
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMQueueUseStack.h"

@interface CAMQueueUseStack ()

@property (nonatomic, strong) NSMutableArray *stackA;
@property (nonatomic, strong) NSMutableArray *stackB;
@property (nonatomic, strong) NSMutableArray *allElements;

@end

@implementation CAMQueueUseStack

- (void)push:(id)element {
    [self.stackA addObject:element];
}

- (void)deleteHead {
    if ([self.stackB count] <= 0) {
        while ([self.stackA count] > 0) {
            id object = self.stackA.lastObject;
            [self.stackA removeLastObject];
            [self.stackB addObject:object];
        }
    }
    if ([self.stackB count] == 0) {
        NSAssert(0, @"queue is empty");
    }
    [self.stackB removeLastObject];
}

- (NSArray *)listAllElements {
    [self.allElements removeAllObjects];
    [self.allElements addObjectsFromArray:self.stackA];
    self.allElements = [[self.allElements reverseObjectEnumerator].allObjects mutableCopy];
    [self.allElements addObjectsFromArray:self.stackB];
    return self.allElements;
}

- (NSMutableArray *)stackA {
    if (!_stackA) {
        _stackA = [NSMutableArray new];
    }
    return _stackA;
}

- (NSMutableArray *)stackB {
    if (!_stackB) {
        _stackB = [NSMutableArray new];
    }
    return _stackB;
}

- (NSMutableArray *)allElements {
    if (!_allElements) {
        _allElements = [NSMutableArray new];
    }
    return _allElements;
}

@end
