//
//  Fibonacci.h
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @discussion 
 相关题目：
 1. 青蛙跳台阶，每次只能跳一个或者两个台阶，问一共N级台阶有多少种跳法。
 很明显这个就是一个斐波那契数列，要考虑递归和非递归的方法，至于另外一个比较不常见的方法这里就不介绍了。
 2. 还是青蛙跳台阶，每次能条1,2,3,4***,N个台阶，问一共有多少种跳法。
 f(n)表示青蛙跳n阶台阶的跳法数。
 n=1时，只有1阶跳，f(1)=1,
 n=2时，可以第一次跳1阶，也可以第一次跳2阶，f(2)=2;
 n=3时，可以第一次跳1阶，2阶，3阶，f(3)= f(2)+f(1)+f(0)
 归纳法得到 f(n)=f(n-1)+f(n-2)+***+f(2)+f(1)+f(0)
 同理可得到 f(-1)=f(n-2)+f(n-3)+***+f(2)+f(1)+f(0)
 相减 f(n)-f(n-1)=f(n-1),所以f(n)=2*f(n-1)(n>2)
 3. 矩阵的覆盖，用八个2*1的小矩阵去覆盖一个2*8的大矩阵
 
 */
@interface Fibonacci : NSObject

/**
 斐波那契数列递归解法

 @param n 要求的第几位，从0位开始
 */
- (NSInteger)fibonacciRecursion:(NSInteger)n;

/**
 斐波那契数列，非递归解法

 @param n
 @discussion 非递归解法可以有效利用之前的值，避免了重复计算，同时避免递归调用栈溢出
 */
- (NSInteger)fibonacciNonRecursion:(NSInteger)n;

@end

