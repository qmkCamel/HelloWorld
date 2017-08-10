//
//  Son.m
//  HelloWorld
//
//  Created by Camel on 2016/11/30.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "Son.h"
#import "FatherPrivate.h"



@implementation Son

- (void)privateMethod {
    debugLog(@"继承自father pravite method");
}

- (void)setName:(NSString *)name {

    debugLog(@"son setter");
    
}

@end
