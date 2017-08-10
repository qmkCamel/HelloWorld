//
//  MKGeneralService.h
//  HelloWorld
//
//  Created by Camel on 2017/1/9.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKGeneralService;

@protocol MKServiceDelegate <NSObject>

@optional

- (void)generalService:(MKGeneralService *)service;

@end

@interface MKGeneralService : NSObject

- (void)registerDelegate:(id<MKServiceDelegate>)delegate;
- (void)deregisterDelegate:(id<MKServiceDelegate>)delegate;
- (void)notifyDelegates;

@end

@interface MKWeakObject : NSObject

@property (nonatomic, readonly, weak) id object;

+ (instancetype)weakObjectWithObject:(id)object;

- (instancetype)initWithObject:(id)object;

@end


