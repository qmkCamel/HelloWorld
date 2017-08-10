//
//  CamTouchEventViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/4/6.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CamTouchEventViewController.h"

@interface CamTouchEventViewController ()

@end

@implementation CamTouchEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self depthFirstSearch:self.view];
    [self breadthFirstSearch:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupSubviews {
    
    UIView *viewA = [[UIView alloc] initWithFrame:self.view.bounds];
    viewA.tag = 1;
    [self.view addSubview:viewA];
    
    UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
    viewB.tag = 2;
    [viewA addSubview:viewB];
    
    UIView *viewD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH / 2, 200)];
    viewD.tag = 4;
    [viewB addSubview:viewD];
    
    
    UIView *viewC = [[UIView alloc] initWithFrame:CGRectMake(0, 300, UI_SCREEN_WIDTH, 200)];
    viewC.tag = 3;
    [viewA addSubview:viewC];
    
    UIView *viewE = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH / 3, 200)];
    viewE.tag = 5;
    [viewC addSubview:viewE];
    
    UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2, 0, UI_SCREEN_WIDTH / 3, 200)];
    viewF.tag = 6;
    [viewC addSubview:viewF];
}

- (void)depthFirstSearch:(UIView *)view {
    for (UIView *subview in view.subviews) {
        debugLog(@"%@ %ld",subview,subview.tag);
        [self depthFirstSearch:subview];
    }
}

- (void)breadthFirstSearch:(UIView *)view {
    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:view.subviews.count];
    for (UIView *subview in view.subviews) {
        [subviews addObject:subview];
        debugLog(@"%@ %ld",subview,subview.tag);
    }
    
    for (UIView *subview in subviews) {
        [self breadthFirstSearch:subview];
    }
}

@end
