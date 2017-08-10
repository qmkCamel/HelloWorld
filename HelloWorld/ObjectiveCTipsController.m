//
//  ObjectiveCTipsController.m
//  HelloWorld
//
//  Created by Camel on 2016/12/22.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import "ObjectiveCTipsController.h"
#import "Father.h"
#import "Son.h"

static NSString *CamClassAInternalString;
static NSString *CamClassBInternalString;

@interface CamClassA : NSObject

@end

@implementation CamClassA

+ (void)initialize {
    debugLog(@"%@ initialize",self);
    CamClassAInternalString = @"在CamClassA的Initialize中完成";
    debugLog(@" %@ ",CamClassAInternalString);
    debugLog(@" %@ ",CamClassBInternalString);
}

@end

@interface CamClassB : NSObject

@end

@implementation CamClassB

+ (void)initialize {
    debugLog(@"%@ initialize",self);
    CamClassBInternalString = @"在CamClassB的initialize中完成";
}

@end


@interface ObjectiveCTipsController ()

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy  ) NSString *copyedString;

@property (nonatomic, strong) CamClassA *classA;
@property (nonatomic, strong) CamClassB *classB;

@property (nonatomic, strong) UIView *testView;

@end

@implementation ObjectiveCTipsController

+ (void)load {
    NSLog(@"load");
}

+ (void)initialize {
    NSLog(@"initialize");
}

- (void)viewDidLoad {
    FooClass *sharedFooClass = [FooClass sharedInstance];
    
    FooClass *normal = [[FooClass alloc] init];
    
    FooClass *convenienceInit = [[FooClass alloc] initWithName:@"convenience"];
    
    debugLog(@"%@%@5%@",sharedFooClass,normal,convenienceInit);
    
    //用copy来保证其封装性
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"hello world"];
    self.strongString = mutableString;
    self.copyedString = mutableString;
    
    [self shouldnotUseSelfPropertyInInit];
    [self testComplifixInitialize];
    
    [self testAutoLayoutAnimations];
}

- (void)testAutoLayoutAnimations {
    self.testView = [[UIView alloc] init];
    self.testView.backgroundColor = [UIColor purpleColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testViewTapped)];
    [self.testView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.testView];
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.equalTo(self.view.mas_left).offset(100);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
}

- (void)testViewTapped {
    [self.testView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(150);
    }];
    
    [UIView animateWithDuration:3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 在init方法中不应该使用self.property
 */
- (void)shouldnotUseSelfPropertyInInit {
    Son *son = [[Son alloc] init];
    debugLog(@"%@",son);
}

/**
 用来测试在 +(void)initialize 中比较复杂的代码
 */
- (void)testComplifixInitialize {
    self.classA = [[CamClassA alloc] init];
    self.classB = [[CamClassB alloc] init];
}

@end

@implementation FooClass

+ (FooClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    debugLog(@"before init");
    return [self initWithName:@"fromInit"];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
