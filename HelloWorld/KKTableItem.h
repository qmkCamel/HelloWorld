//
//  KKTableItem.h
//  HelloWorld
//
//  Created by Camel on 2016/11/30.
//  Copyright © 2016年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKTableItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desController;

- (void)saySomething;

@end


#warning 类扩展
@interface KKTableItem ()

//和.m里面的其实是一样的 就是为了做功能分组

@property (nonatomic, copy) NSString *extension;

- (void)doSomething;

@end

