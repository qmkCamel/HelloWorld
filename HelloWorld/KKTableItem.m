//
//  KKTableItem.m
//  HelloWorld
//
//  Created by Camel on 2016/11/30.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "KKTableItem.h"

@implementation KKTableItem

- (id)copyWithZone:(NSZone *)zone {
    KKTableItem *copy = [[[self class] allocWithZone:zone] init];
    return copy;
}

- (void)saySomething {}

- (void)doSomething {}

@end

