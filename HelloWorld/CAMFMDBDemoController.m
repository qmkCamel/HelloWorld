//
//  CAMFMDBDemoController.m
//  HelloWorld
//
//  Created by Camel on 2017/5/4.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMFMDBDemoController.h"
#import <FMDB/FMDB.h>


@interface CAMFMDBDemoController ()

@end

@implementation CAMFMDBDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docsDir stringByAppendingPathComponent:@"test.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sql = @"";
    [database executeQuery:@""];
    [database close];
    
    [self addObject:@1,@2,@3,@4,@5,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addObject:(id)first,...{
    va_list list;
    va_start(list, first);
    
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:first];
    
    id arg;
    while ((arg = va_arg(list,id))) {
        [array addObject:arg];
    }
    va_end(list);
}


@end
