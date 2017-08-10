//
//  NotificationViewController.m
//  HelloWorld
//
//  Created by Camel on 2016/12/29.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstAddObserver) name:@"test" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondAddObserver) name:@"test" object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
        debugLog(@"后台线程继续执行postNotification下面的代码");
    });
    debugLog(@"主线程继续执行postNotification下面的代码");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)firstAddObserver {
    debugLog(@"先加载的收到通知");
}

- (void)secondAddObserver {
    debugLog(@"后加载的收到通知");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
