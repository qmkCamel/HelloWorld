//
//  Father.m
//  HelloWorld
//
//  Created by Camel on 2016/11/30.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "Father.h"

#import "FatherPrivate.h"

@interface Father ()

@end

@implementation Father

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"";
    }
    return self;
}

- (void)privateMethod {
    debugLog(@"father private method");
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    debugLog(@"father setter");
}

@end
