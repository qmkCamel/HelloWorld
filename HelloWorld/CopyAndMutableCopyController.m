//
//  CopyAndMutableCopyControllerViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/3/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CopyAndMutableCopyController.h"

@interface CopyAndMutableCopyController ()

@end

@implementation CopyAndMutableCopyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nonCollectionObjectCopy];
    [self collectionObjectCopy];
    [self collectionObjectCompletelyCopy];
}

/**
 非集合对象的copy和mutableCopy
 */
- (void)nonCollectionObjectCopy {
//    (lldb) p string
//    (__NSCFConstantString *) $1 = 0x000000010aeeade0 @"string"
//    (lldb) p mutableString
//    (__NSCFString *) $2 = 0x0000608000266380 @"mutableString"
//    (lldb) p stringCopy
//    (__NSCFConstantString *) $3 = 0x000000010aeeade0 @"string"
//    (lldb) p stringMutableCopy
//    (__NSCFString *) $4 = 0x00006080002673c0 @"string"
//    (lldb) p mutableStringCopy
//    (__NSCFString *) $5 = 0x000060800023c8a0 @"mutableString"
//    (lldb) p mutableStringMutableCopy
//    (__NSCFString *) $6 = 0x0000608000266300 @"mutableString"
    NSString *string = @"string";
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"mutableString"];
    
    NSString *stringCopy = [string copy];
    NSMutableString *stringMutableCopy = [string mutableCopy];
    
    NSString *mutableStringCopy = [mutableString copy];
    NSMutableString *mutableStringMutableCopy = [mutableString mutableCopy];
}

/**
 集合对象的copy和mutableCopy
 */
- (void)collectionObjectCopy {
    
//    (lldb) p array
//    (__NSArrayI *) $7 = 0x000060800023c340 @"2 elements"
//    (lldb) p mutableArray
//    (__NSArrayM *) $8 = 0x000060800005d460 @"2 elements"
//    (lldb) p arrayCopy
//    (__NSArrayI *) $9 = 0x000060800023c340 @"2 elements"
//    (lldb) p arrayMutableCopy
//    (__NSArrayM *) $10 = 0x000060800005fce0 @"2 elements"
//    (lldb) p mutableArrayCopy
//    (__NSArrayI *) $11 = 0x000060800023c120 @"2 elements"
//    (lldb) p mutableArrayMutableCopy
//    (__NSArrayM *) $12 = 0x000060800005da30 @"2 elements"
    NSArray *array = @[@"A",@"B"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:@[@"A",@"B"]];
    
    NSArray *arrayCopy = [array copy];
    NSArray *arrayMutableCopy = [array mutableCopy];
    
    NSArray *mutableArrayCopy = [mutableArray copy];
    NSArray *mutableArrayMutableCopy = [mutableArray mutableCopy];
    
}

/**
 集合对象的完全深复制
 */
- (void)collectionObjectCompletelyCopy {
    NSArray *array = @[@"A",@"B"];
    NSMutableArray *arrayCompletelyCopy = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    
    NSDictionary *dic = @{@"key":@"value"};
    NSMutableDictionary *dicCompeletelyMutableCopy = [[NSMutableDictionary alloc] initWithDictionary:dic copyItems:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
