//
//  CAMBlock.m
//  HelloWorld
//
//  Created by Camel on 2017/4/20.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMBlock.h"

@implementation CAMBlock

@end


static Class _blockClass() {
    static dispatch_once_t onceToken;
    static Class blockClass;
    dispatch_once(&onceToken, ^{
        void (^testBlock)() = [^{} copy];
        blockClass = [testBlock class];
        while (class_getSuperclass(blockClass) && class_getSuperclass(blockClass) != [NSObject class] ) {
            blockClass = class_getSuperclass(blockClass);
        }
    });
    return blockClass;
}

