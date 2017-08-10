//
//  CAMConversion.m
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMConversion.h"

@implementation CAMConversion

- (NSInteger)numberOf1:(NSInteger)n {
    NSInteger count = 0;
    NSInteger flag = 1;
    
    while (flag) {
        if (n & flag) {
            count ++;
        }
        flag = flag << 1;
        debugLog(@"flag = %@",@(flag));
    }
    return count;
}

- (NSInteger)numberOf1Best:(NSInteger)n {
    NSInteger count = 0;
    while (n) {
        count ++;
        n = (n - 1) & n;
    }
    return count;
}

@end
