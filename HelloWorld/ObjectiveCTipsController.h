//
//  ObjectiveCTipsController.h
//  HelloWorld
//
//  Created by Camel on 2016/12/22.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectiveCTipsController : UIViewController

@end


@interface FooClass : NSObject

@property (nonatomic, copy) NSString *name;

+ (FooClass *)sharedInstance;

- (instancetype)initWithName:(NSString *)name;

@end
