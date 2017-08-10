//
//  CAMStackUseQueue.h
//  HelloWorld
//
//  Created by Camel on 2017/4/14.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAMStackUseQueue : NSObject

- (void)push:(id)element;
- (void)pop:(id)element;

- (NSArray *)listAllElemtents;

@end
