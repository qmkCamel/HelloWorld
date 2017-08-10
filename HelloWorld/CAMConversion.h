//
//  CAMConversion.h
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 涉及到进制转换的相关问题
 */
@interface CAMConversion : NSObject


/**
 一个整数的二进制中1的个数，执行效率固定
 @discussion 
 使用一个辅助数flag = 1，与目标数与，从最低位开始，如果不为0，则这位为1，然后辅助数左移，直到flag为负。
 注意：这个方法的循环次数等于整数flag的位数，32位的整数需要循环32次
 */
- (NSInteger)numberOf1:(NSInteger)n;

/**
 一个整数的二进制中1的个数,最佳解法
 @discussion 
 我们注意到，一个二进制数如果减去1，都是最右边的1变为0，右边的取反，左边的不变
 执行次数：目标整数的二进制有多少位就执行多少次
 */
- (NSInteger)numberOf1Best:(NSInteger)n;


@end
