//
//  CAMAspectsViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/5/10.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "CAMAspectsViewController.h"
#import <Aspects/Aspects.h>

@interface CAMAspectsViewController ()

@end

@implementation CAMAspectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self aspect_hookSelector:@selector(targetMethod:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>info, NSString *parameter){
        
        NSLog(@"%s \n hook method after parameter =  %@ ",__func__,parameter);
        
    } error:NULL];
    
    [self targetMethod:@"helloWold"];
}

- (void)targetMethod:(NSString *)parameter {
    NSLog(@"parameter = %@ \n%s",parameter,__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
