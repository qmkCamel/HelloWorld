//
//  CAMStackUseQueue.m
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMStackUseQueue.h"

@interface CAMStackUseQueue ()

@property (nonatomic, strong) NSMutableArray *queueA;

@property (nonatomic, strong) NSMutableArray *queueB;

@end

@implementation CAMStackUseQueue

- (instancetype)init {
    if (self = [super init]) {
        _queueA = [NSMutableArray new];
        _queueB = [NSMutableArray new];
    }
    return self;
}


- (void)push:(id)element {
    if (self.queueA.count == 0 && self.queueB.count == 0) {
        [self.queueA addObject:element];
    } else if (self.queueA.count > 0 && self.queueB.count == 0) {
        [self.queueA addObject:element];
    } else if (self.queueB.count > 0 && self.queueA.count == 0) {
        [self.queueB addObject:element];
    } else {
        NSAssert(0, @"internal error");
    }
}

- (void)pop:(id)element {
    if (self.queueA.count == 0 && self.queueB.count == 0) {
        debugLog(@"the stack is empty");
        return;
    }
    
    if (self.queueA.count == 0 && self.queueB.count > 0) {
        while (self.queueB.count > 1) {
        
            id first = self.queueB.firstObject;
            
            [self.queueA addObject:first];
            
            [self.queueB removeObjectAtIndex:0];
            
        }
        //queueB最后一个元素出来
        [self.queueB removeLastObject];
        
        return;
    }
    
    if (self.queueA.count > 0 && self.queueB.count == 0) {
        while (self.queueA.count > 1) {
            
            id first = self.queueA.firstObject;
            
            [self.queueB addObject:first];
            
            [self.queueA removeObjectAtIndex:0];
        }
        // queueA最后一个元素出来
        [self.queueA removeLastObject];
        return;
    }
    
    if (self.queueA.count > 0 && self.queueB.count > 0) {
        NSAssert(0, @"internal error");
    }
}

- (NSArray *)listAllElemtents {
    NSMutableArray *allElements = [NSMutableArray new];
    
    if (self.queueA.count == 0 && self.queueB.count == 0) {
        return allElements;
    }
    
    if (self.queueA.count > 0 && self.queueB.count > 0) {
        NSAssert(0, @"internal error");
        return nil;
    }
    
    if (self.queueA.count > 0) {
        allElements = [self.queueA mutableCopy];
    }
    if (self.queueB.count > 0) {
        allElements = [self.queueB mutableCopy];
    }
    
    return [allElements copy];
}

@end
