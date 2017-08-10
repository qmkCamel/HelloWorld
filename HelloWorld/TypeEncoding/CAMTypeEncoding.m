//
//  CAMTypeEncoding.m
//  HelloWorld
//
//  Created by Camel on 2017/4/20.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMTypeEncoding.h"

@implementation CAMTypeEncoding


/**
 查看OC的类型编码
 @discussion 
 @encode是编译器指令，返回一个给定类型编码为一中内部表示的字符串。类似于 C typeof操作。
 苹果的Objective-C运行时库内部利用类型编码来加快消息分发。
 */
+ (void)inspectTypeEncoding {
    debugLog(@"int          :%s",@encode(int));
    debugLog(@"float        :%s",@encode(float));
    debugLog(@"flaot *      :%s",@encode(float *));
    debugLog(@"char         :%s",@encode(char));
    debugLog(@"char *       :%s",@encode(char *));
    debugLog(@"BOOL         :%s",@encode(BOOL));
    debugLog(@"void         :%s",@encode(void));
    debugLog(@"void *       :%s",@encode(void *));
    
    debugLog(@"NSObject     :%s",@encode(NSObject));
    debugLog(@"NSObject *   :%s",@encode(NSObject *));
    debugLog(@"[NSObject class]:%s",@encode(typeof([NSObject class])));
    debugLog(@"NSError **   :%s",@encode(typeof(NSError **)));
    
    int intArray[5] = {1,2,3,4,5};
    debugLog(@"int[]        :%s",@encode(typeof(intArray)));
    
    float floatArray[3] = {0.1,0.2,0.3};
    debugLog(@"flaot[]       :%s",@encode(typeof(floatArray)));
    
    typedef struct _struct {
        short a;
        long long b;
        unsigned long long c;
    } Struct;
    debugLog(@"struct        :%s",@encode(typeof(Struct)));
}

@end
