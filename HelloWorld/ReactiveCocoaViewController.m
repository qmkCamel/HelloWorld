//
//  ReactiveCocoaViewController.m
//  HelloWorld
//
//  Created by Camel on 16/8/2.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "ReactiveCocoaViewController.h"

#import "ViewController.h"
#import "KKTableItem.h"

#import <ReactiveObjC/ReactiveObjC.h>


@implementation ReactiveCocoaViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        debugLog(@"self class = %@",NSStringFromClass([self class]));
        debugLog(@"super class = %@",NSStringFromClass([super class]));
        //都输出 ReactiveCocoaViewController
#warning explain
        // objc中super是编译器标示符，并不像self一样是一个对象，遇到向super发的方法时会转译成objc_msgSendSuper(...)，而参数中的对象还是self，于是从父类开始沿继承链寻找- class这个方法，最后在NSObject中找到（若无override），此时，[self class]和[super class]已经等价了。
    }
    return self;
}

- (void)viewDidLoad {
    
    [self sequencing];
    [self merging];
    
    return;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    debugLog(@"self class = %@",NSStringFromClass([self class]));
    debugLog(@"super class = %@",NSStringFromClass([super class]));
    
    Class class = NSClassFromString(@"KKTableItem");
    id obj = [class performSelector:NSSelectorFromString(@"new")];
    
    KKTableItem *item = (KKTableItem *)obj;
    item.extension = @"extension";
    
    [obj saySomething];
    [obj doSomething];
    
    [self saySomething];
    
}

- (void)testIsa {
#warning explain
    
    KKTableItem *item = [KKTableItem new];
    BOOL b1 = [item respondsToSelector:@selector(respondsToSelector:)];
    BOOL b2 = [KKTableItem respondsToSelector:@selector(respondsToSelector:)];
    debugLog(@"%d, %d", b1, b2);
}

- (void)saySomething {
    debugLog(@"这个是类的原来的方法");
}

#pragma mark RAC_Practice

#pragma mark side_effects_with_signals

- (void)subcription {
    RACSignal *letters = [@"A B C D E F H I J K" componentsSeparatedByString:@" "].rac_sequence.signal;
    
    [letters subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        subscriptions ++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    [loggingSignal subscribeCompleted:^{
        NSLog(@"subscription %u",subscriptions);
    }];
    
    [loggingSignal subscribeCompleted:^{
        NSLog(@"subscription %u",subscriptions);
    }];
}

- (void)injectingEffects {
    __block unsigned subscription = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        subscription ++;
        [subscriber sendCompleted];
        return nil;
    }];
    // 这里的signal必须有返回值回来
    loggingSignal = [loggingSignal doCompleted:^{
        NSLog(@"about to complete subscription %u",subscription);
    }];
    [loggingSignal subscribeCompleted:^{
        NSLog(@"subscription %u",subscription);
    }];
}

#pragma mark transforming streams

- (void)mapping {
    RACSequence *letters = [@"A B" componentsSeparatedByString:@" "].rac_sequence;
    
    RACSequence *mapped = [letters map:^(NSString *value){
        return [value stringByAppendingString:@"0"];
    }];
}

- (void)filtering {
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    RACSequence *filtered = [numbers filter:^BOOL(NSString * _Nullable value) {
        return (value.intValue % 2) == 0;
    }];
}

#pragma mark combining streams 

- (void)concat {
    RACSequence *letters = [@"A B C D E F" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence;
    
    RACSequence *concatenated = [letters concat:numbers];
}


#pragma mark combining signals

/**
 -then 开始原先的signal,等他结束之后开始新的signal，只返回新的signal
 */
- (void)sequencing {
    RACSignal *letters = [@"A B C D E F G" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *sequenced = [[letters doNext:^(id  _Nullable x) {
        NSLog(@"first  %@",x);
    }]
    then:^RACSignal * _Nonnull{
        return [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence.signal;
    }];
    
    [sequenced subscribeNext:^(id  _Nullable x) {
        NSLog(@"second %@",x);
    }];
}

- (void)merging {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *merged = [RACSignal merge:@[letters, numbers]];
    
    [merged subscribeNext:^(id  _Nullable x) {
        debugLog(@"%@",x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [letters sendNext:@"X"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"10"];
    [numbers sendNext:@"2"];
}


- (void)combiningLatestValues {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *combined = [RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number) {
        return [letter stringByAppendingString:number];
    }];
    
    [combined subscribeNext:^(id  _Nullable x) {
        debugLog(@"%@",x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
}

- (void)swithing {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSignal *switched = [signalOfSignals switchToLatest];
    
    [switched subscribeNext:^(id  _Nullable x) {
        debugLog(@"%@",x);
    }];
    
    [signalOfSignals sendNext:letters];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    
    [signalOfSignals sendNext:numbers];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"2"];
    [letters sendNext:@"D"];
}


@end
