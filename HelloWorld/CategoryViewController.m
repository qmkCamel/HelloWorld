//
//  CategoryViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/3/13.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doSomething];
    
    NSArray *array = [self.class instanceMethods];
    debugLog(@"%@",array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)doSomething {
    debugLog(@"do something");
    NSAssert(0, @"crash here");
}

@end
