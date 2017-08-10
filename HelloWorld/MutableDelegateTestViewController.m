//
//  MutableDelegateTestViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/1/9.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "MutableDelegateTestViewController.h"

#import "MKGeneralService.h"

@interface MutableDelegateTestViewController ()

@property (nonatomic, strong) MKGeneralService *service;
@property (nonatomic, strong) MKTestViewA *testViewA;
@property (nonatomic, strong) MKTestViewB *testViewB;

@end

@implementation MutableDelegateTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.service = [[MKGeneralService alloc] init];
    [self.service registerDelegate:self.testViewA];
    [self.service registerDelegate:self.testViewB];
    [self.service notifyDelegates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MKTestViewA *)testViewA {
    if (!_testViewA) {
        _testViewA = [[MKTestViewA alloc] init];
    }
    return _testViewA;
}

- (MKTestViewB *)testViewB {
    if (!_testViewB) {
        _testViewB = [[MKTestViewB alloc] init];
    }
    return _testViewB;
}

@end

@interface MKTestViewA ()

@end

@implementation MKTestViewA

- (void)generalService:(MKGeneralService *)service {
    debugLog(@"MKTestViewA");
}

@end


@interface MKTestViewB ()

@end

@implementation MKTestViewB

- (void)generalService:(MKGeneralService *)service {
    debugLog(@"MKTestViewB");
}

@end

