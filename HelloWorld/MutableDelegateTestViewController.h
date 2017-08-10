//
//  MutableDelegateTestViewController.h
//  HelloWorld
//
//  Created by Camel on 2017/1/9.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "ViewController.h"
#import "MKGeneralService.h"

@interface MutableDelegateTestViewController : UIViewController

@end


@interface MKTestViewA : UIView <MKServiceDelegate>

@end

@interface MKTestViewB : UIView <MKServiceDelegate>

@end
