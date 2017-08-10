//
//  CAMSearchAndSort.h
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAMSearchAndSort : NSObject

/**
 二分法查找目标数字

 @param array 有序数组，递增递减无所谓
 @param target 目标数字
 @return 目标数字所在的index
 @discussion 如果目标数字有多个，则随机返回来一个，如果没有，返回-1
 要注意的条件：frond < end && end - front > 1 , 如果两者步长为1的话，两个整数相除还是会得带一个整数，会进入死循环
 */
- (NSInteger)binarySearchWithArray:(NSArray *)array target:(NSInteger)target;


/**
 冒泡排序

 @return 从大到小的结果
 @discussion 边界情况：1.只有一个数 2.参数为空
 */
- (NSArray *)bubblingSort:(NSArray *)array;


/**
 求一个集合的全子集，递归

 @param array 目标集合
 @return <#return value description#>
 */
- (NSMutableArray *)totalSubSet:(NSMutableArray *)setArray end:(NSInteger)end;

/**
 求一个集合的全子集，非递归

 @return <#return value description#>
 */
- (NSMutableArray *)totolSubsetWithForCirculation;

/**
 求一个数组的全排列

 @return <#return value description#>
 */
- (void)totolSort;

@end
