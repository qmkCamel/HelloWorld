//
//  ViewController.m
//  HelloWorld
//
//  Created by Camel on 15/11/8.
//  Copyright © 2015年 Camel. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "YYDispatchQueuePool.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ReactiveCocoaViewController.h"
#import "MutableDelegateTestViewController.h"
#import "KKTableItem.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@class RuntimeViewController;
@class ObjectiveCTipsController;
@class ReactiveCocoaViewController;
@class NotificationViewController;
@class DesignPatternViewController;
@class MutableDelegateTestViewController;
@class MKMultithreadingViewController;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImage"]];
    
    
    UIToolbar *bgView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    bgView.barStyle = UIBarStyleBlack;
    [self.view addSubview:bgView];
    
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 40, 200);
    CGPathAddLineToPoint(path, NULL, 60, 200);
    CGPathAddLineToPoint(path, NULL, 50, 220);
    CGPathAddLineToPoint(path, NULL, 40, 200);
    arrowLayer.path = path;
    arrowLayer.fillColor = [UIColor colorWithWhite:0.11 alpha:0.73].CGColor;
    [self.view.layer addSublayer:arrowLayer];
    CGPathRelease(path);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 100, 100)];
    view.backgroundColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark private

- (void)setupData {
    NSArray *titleArray = @[@"ObjectiveCTips",
                            @"ReactiveObjcPratice",
                            @"Notification",
                            @"DesignPattern",
                            @"MutableDelegate",
                            @"Multithreading",
                            @"Rumtime",
                            @"Category",
                            @"CopyAndMutableCopy",
                            @"RunLoop",
                            @"ToucheEvent",
                            @"FMDBDemo",
                            @"Aspects"];
    NSArray *desControllerArray = @[@"ObjectiveCTipsController",
                                    @"ReactiveCocoaViewController",
                                    @"NotificationViewController",
                                    @"DesignPatternViewController",
                                    @"MutableDelegateTestViewController",
                                    @"MKMultithreadingViewController",
                                    @"RuntimeViewController",
                                    @"CategoryViewController",
                                    @"CopyAndMutableCopyController",
                                    @"CamRunLoopViewController",
                                    @"CamTouchEventViewController",
                                    @"CAMFMDBDemoController",
                                    @"CAMAspectsViewController"];
    
    for (int i = 0 ; i < [titleArray count]; i ++) {
        KKTableItem *item = [[KKTableItem alloc] init];
        item.title = titleArray[i];
        item.desController = desControllerArray[i];
        [self.dataSource addObject:item];
    }
}

#pragma mark tableview protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    KKTableItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKTableItem *item = self.dataSource[indexPath.row];
    Class class = NSClassFromString(item.desController);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark getter

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end


