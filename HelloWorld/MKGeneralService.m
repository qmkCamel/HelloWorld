//
//  MKGeneralService.m
//  HelloWorld
//
//  Created by Camel on 2017/1/9.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "MKGeneralService.h"

@interface MKGeneralService ()

@property (nonatomic, strong) NSMutableSet *delegates;

@end

@implementation MKGeneralService

- (void)registerDelegate:(id<MKServiceDelegate>)delegate {
    if ([delegate conformsToProtocol:@protocol(MKServiceDelegate)]) {
        [self.delegates addObject:[[MKWeakObject alloc] initWithObject:delegate]];
    }
}

- (void)deregisterDelegate:(id<MKServiceDelegate>)delegate {
    if ([delegate conformsToProtocol:@protocol(MKServiceDelegate)]) {
        [self.delegates removeObject:[[MKWeakObject alloc] initWithObject:delegate]];
    }
}

- (void)notifyDelegates {
    for (MKWeakObject *weakObject in self.delegates) {
        if (weakObject.object) {
            if ([weakObject.object respondsToSelector:@selector(generalService:)]) {
                [weakObject.object generalService:self];
            }
        }
    }
}

- (NSMutableSet *)delegates {
    if (!_delegates) {
        _delegates = [[NSMutableSet alloc] init];
    }
    return _delegates;
}

@end

@interface MKWeakObject ()

@property (nonatomic, weak) id object;

@end

@implementation MKWeakObject

+ (instancetype)weakObjectWithObject:(id)object {
    return [[self alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        _object = object;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[object class]]) {
        return NO;
    }
    return [self isEqualToWeakObject:object];
}

- (BOOL)isEqualToWeakObject:(MKWeakObject *)object {
    if (!object) {
        return NO;
    }
    BOOL objectsMatch = [self.object isEqual:object.object];
    return objectsMatch;
}

- (NSUInteger)hash {
    return [self.object hash];
}

@end

