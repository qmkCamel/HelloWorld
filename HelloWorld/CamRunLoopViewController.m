//
//  CamRunLoopViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/3/23.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CamRunLoopViewController.h"

@interface CamRunLoopViewController ()

@end

@implementation CamRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    debugLog(@"main queue runloop = %@",runloop);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            debugLog(@"index = %d global queue runloop = %@",i,runloop);
            NSThread *thread = [NSThread currentThread];
            debugLog(@"index = %d global queue thread = %@",i,thread);
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    debugLog(@"CamRunLoopViewController was dealloc");
}

@end
