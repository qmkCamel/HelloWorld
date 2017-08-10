//
//  DesignPatternViewController.m
//  HelloWorld
//
//  Created by Camel on 2016/12/30.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "DesignPatternViewController.h"

@interface DesignPatternViewController ()

@end

@implementation DesignPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    
    NSArray *array = [NSArray array];
    array = @[@"hello",@"world"];
    
    [self abstractFactory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 抽象工厂
 */
- (void)abstractFactory {
    NSNumber *boolNumber = [NSNumber numberWithBool:YES];
    NSNumber *charNumber = [NSNumber numberWithChar:'A'];
    NSNumber *integerNumber = [NSNumber numberWithInteger:1];
    NSNumber *floatNumber = [NSNumber numberWithFloat:1.1];
    
    debugLog(@"boolNumber = %@",[[boolNumber class] description]);
    debugLog(@"charNumber = %@",[[charNumber class] description]);
    debugLog(@"integerNumber = %@",[[integerNumber class] description]);
    debugLog(@"floatNumber = %@",[[floatNumber class] description]);
    
    NSString *string = @"string";
    
    NSString *stringAgain = [NSString stringWithFormat:@"hello"];
    
    debugLog(@"string = %@",[[string class] description]);
    debugLog(@"stringAgain = %@",[[stringAgain class] description]);
    
    NSArray *array = @[@1,@2,@3];
    
    debugLog(@"array = %@",[[array class] description]);
    
    NSDictionary *dic = @{@"key":@"value"};
    
    debugLog(@"dic = %@",[[dic class] description]);
    
}

@end
