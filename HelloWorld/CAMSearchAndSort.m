//
//  CAMSearchAndSort.m
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMSearchAndSort.h"

@interface CAMSearchAndSort ()

@end

@implementation CAMSearchAndSort

- (NSInteger)binarySearchWithArray:(NSArray *)array target:(NSInteger)target {
    NSInteger targetIndex = -1;
    if (array.count == 0) {
        return targetIndex;
    }
    
    NSInteger front = 0;
    NSInteger end = array.count - 1;
    
    
    
    NSNumber *frontNumber;
    NSNumber *endNumber;
    NSNumber *midNumber;
    
    //这边要注意看下end和front的距离
    while (front < end && end - front > 1) {
        //两个整数相除还是整数
        NSInteger mid = (front + end) / 2;
        
        frontNumber = array[front];
        endNumber = array[end];
        midNumber = array[mid];
        
        if (midNumber.integerValue == target) {
            return mid;
        }
        
        if (midNumber.integerValue < target) {
            if (frontNumber.integerValue < endNumber.integerValue ) { //递增数组
                front = mid;
            } else if (frontNumber.integerValue > endNumber.integerValue) { //递减数组
                end = mid;
            }
        }
        
        if (midNumber.integerValue > target) {
            if (frontNumber.integerValue < endNumber.integerValue ) { //递增数组
                end = mid;
            } else if (frontNumber.integerValue > endNumber.integerValue) { //递减数组
                front = mid;
            }
        }
    }
    
    frontNumber = array[front];
    endNumber = array[end];
    if (frontNumber.integerValue == target) {
        return front;
    }
    if (endNumber.integerValue == target) {
        return end;
    }
    
    return targetIndex;
}

- (NSArray *)bubblingSort:(NSArray *)array {
    if (array.count == 0) {
        return nil;
    }
    if (array.count == 1) {
        return array;
    }

    NSMutableArray *result = [array mutableCopy];
    
    for (NSInteger i = 0; i < result.count; i ++) {
        for (NSInteger j = 0; j < result.count - i - 1; j ++) {
            if (((NSNumber *)result[j]).integerValue < ((NSNumber *)result[j + 1]).integerValue) {
                
                NSNumber *tmp = result[j];
                [result replaceObjectAtIndex:j withObject:result[j+1]];
                [result replaceObjectAtIndex:j+1 withObject:tmp];
                
                debugLog(@"resut = %@",result);
            }
        }
    }
    
    return result;
}

- (NSMutableArray *)totalSubSet:(NSMutableArray *)setArray end:(NSInteger)end {
    
    if (end == -1) {
        NSMutableArray *resutl = [NSMutableArray new];
        [resutl addObject:@[]];
        return resutl;
    }
    
    NSMutableArray *tmpArray = [self totalSubSet:setArray end:end -1];
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (NSArray *array in tmpArray) {
        
        [result addObject:array];
        
        NSMutableArray *elementArray = [array mutableCopy];
        [elementArray addObject:setArray[end]];
        [result addObject:[elementArray copy]];
    }
    return result;
}

- (NSMutableArray *)totolSubsetWithForCirculation {
    
    NSArray *inputArray = @[@1,@2,@3];
    
    NSMutableArray *result = [NSMutableArray new];
    
    [result addObject:@[]];
    
    for (int i = 0; i < inputArray.count; i ++) {
    
        NSArray *tmpResult = [[NSMutableArray alloc] initWithArray:[result copy] copyItems:YES];
        
        for (NSArray *array in tmpResult) {
            
            NSMutableArray *tmpElementArray = [array mutableCopy];
            [tmpElementArray addObject:inputArray[i]];
            [result addObject:[tmpElementArray copy]];
        }
        
    }

    return result;
    
}

- (void)totolSort {
    NSArray *inputArray = @[@1,@2,@3];
    
    [self permutationWithArray:[inputArray mutableCopy] index:0];
    
    int array[3] = {1,2,3};
    permutation(array, 3, 0);
}

- (void)permutationWithArray:(NSMutableArray *)array index:(NSInteger)index {

    if (index == [array count]) {
        debugLog(@"sort = %@",array);
    } else {
        for (NSInteger i = index; i < [array count]; ++i) {
            
            NSLog(@"i= %d",i);
            
            [array replaceObjectAtIndex:index withObject:array[i]];
            [self permutationWithArray:array index:index + 1];
            [array replaceObjectAtIndex:index withObject:array[i]];
        }
    }
}

int sum=0; //全排列个数

//打印数组内容
void print(int array[],int len){
    printf("{");
    for(int i=0; i<len;++i)
        printf("%d", array[i]);
    printf("}\n");
}

//实现两数交换
void swap(int* o,int i,int j){
    int tmp = o[i];
    o[i] = o[j];
    o[j] = tmp;
}

//递归实现数组全排列并打印
void permutation(int array[],int len,int index){
    if(index==len){//全排列结束
        ++sum;
        print(array,len);
    }
    else
        for(int i=index;i<len;++i){
            //将第i个元素交换至当前index下标处
            swap(array,index,i);
            
            //以递归的方式对剩下元素进行全排列
            permutation(array,len,index+1);
            
            //将第i个元素交换回原处
            swap(array,index,i);
        }
}

@end
