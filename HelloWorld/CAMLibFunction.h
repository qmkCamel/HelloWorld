//
//  CAMLibFunction.h
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 自己实现一些库函数
 */
@interface CAMLibFunction : NSObject

/**
 求base的exponent次方
 
 @param base 底数
 @param exponent 指数
 @return 
 @discussion 需要考虑多种情况
 */
+ (double)powerWithBase:(double)base exponent:(int)exponent;

/**
 按顺序打印出从1到最大的n位十进制数。

 @param n 位数
 @discussion 大数问题，用字符串或者数组来解决
 */
+ (void)print1ToMaxOfNDigits:(NSInteger)n;

+ (void)O1DeleteNode;

@end
