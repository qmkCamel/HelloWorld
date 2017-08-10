//
//  Fibonacci.m
//  HelloWorld
//
//  Created by Camel on 2017/4/17.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "Fibonacci.h"

@implementation Fibonacci

- (NSInteger)fibonacciRecursion:(NSInteger)n {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }
    return [self fibonacciRecursion:n-1] + [self fibonacciRecursion:n-2];
}

- (NSInteger)fibonacciNonRecursion:(NSInteger)n {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }
    
    NSInteger fibonacciN1 = 0;
    NSInteger fibonacciN2 = 1;
    NSInteger fibonacciN = 0;
    
    for (NSInteger i = 2; i <= n; i++) {
        fibonacciN = fibonacciN1 + fibonacciN2;
        fibonacciN1 = fibonacciN2;
        fibonacciN2 = fibonacciN;
    }
    return fibonacciN;
}

@end
