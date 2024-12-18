//
//  RuntimeViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/2/23.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "RuntimeViewController.h"
#import "Father.h"
#import "Son.h"

@interface Plane : NSObject

@end

@implementation Plane

- (void)fly {
    NSLog(@"%@ %s", self,sel_getName( _cmd));
}

@end

@interface Car : NSObject

@end

@implementation Car

- (void)park {
    NSLog(@"car park");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(fly)) {
        // 每一个方法会默认隐藏两个参数，self和_cmd。self代表方法调用者，_cmd代表这个方法的的SEL。
        // 签名类型就是为了描述一个方法的返回值，参数的。v代表返回值为void,@代表self,:代表_cmd
        return [NSMethodSignature signatureWithObjCTypes:"v%@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
    Plane *car = [Plane new];
    if ([car respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:car];
    }
}

@end


@interface Person : NSObject

@end

@implementation Person

void run (id self,SEL _cmd) {
    NSLog(@"%@ %s",self,sel_getName(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(run)) {
        // class_addMethod 可以覆盖父类的同名方法，但是不能再本类中添加同名方法
        // 在本类中替换同名方法需要用 method_setImplementation
       return class_addMethod(self, sel, (IMP)run, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [Car new];
}

@end

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testIsKindOfClassAndIsMemberOfClass];
    //下面这段注释掉的代码在真机上有问题，在模拟器上没有问题
//    Person *person = [[Person alloc] init];
//    [person performSelector:@selector(run)];
//    
//    Person *personTwo = [Person new];
//    [personTwo performSelector:@selector(park)];
//    
//    Car *car = [Car new];
//    [car performSelector:@selector(fly)];
    
//    objc_msgSend(self,@selector(testObjc_msgSend));
    
    NSObject *object = [NSObject new];
    //在ARC模式下，通过__bridge 转换id类型为（void *）类型
    debugLog(@"isa: %p ", *(void **)(__bridge void *)object);
    
    static char key;
    
    objc_setAssociatedObject(object,&key,@"helloworld",OBJC_ASSOCIATION_RETAIN);
    
    debugLog(@"isa: %p ", *(void **)(__bridge void *)object);
    
    NSNumber *one = [NSNumber numberWithInt:1];
    debugLog(@"number %@",one);
}

- (void)testIsKindOfClassAndIsMemberOfClass {
    BOOL resultOne = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL resultTwo = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    
    BOOL resultThree = [(id)[Father class] isKindOfClass:[Father class]];
    BOOL resultFour = [(id)[Father class] isMemberOfClass:[Father class]];
    
    BOOL resutlFive = [(id)[Father class] isKindOfClass:[NSObject class]];
    BOOL resultSix = [(id)[Father class] isMemberOfClass:[NSObject class]];
    
    debugLog(@"%d\t %d\t %d\t %d\t %d\t %d\t",resultOne,resultTwo,resultThree,resultFour,resutlFive,resultSix);
    
}

- (void)testObjc_msgSend {
    debugLog(@"objc_msgSend");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
