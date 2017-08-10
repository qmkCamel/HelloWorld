//
//  KKConstants.h
//  HelloWorld
//
//  Created by Camel on 2016/11/25.
//  Copyright © 2016年 Camel. All rights reserved.
//

#ifndef KKConstants_h
#define KKConstants_h

#ifdef DEBUG
    #define debugLog(format, ...) NSLog((@"%s:%d \t" format), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,##__VA_ARGS__)
    #define debugMethod() NSLog(@"%s", __func__)
#else
    #define debugLog(...) //log nothing
    #define debugMethod() //log nothing
#endif


//UIContants
#define UI_TOOLBAR_HEIGHT           44
#define UI_TAB_BAR_HEIGHT           49
#define UI_STATUS_BAR_HEIGHT        20
#define UI_NAVIGATION_BAR_HEIGHT    44
#define UI_NAVIGATION_STATUS_HEIGHT 64
#define UI_SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)
#define UI_VISIBLE_HEIGHT           (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT - UI_NAVIGATION_BAR_HEIGHT - UI_TAB_BAR_HEIGHT)
#define UI_VISIBLE_HEIGHT_NO_TAB    (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)
#define UI_CONTENT_WIDTH_DEFAULT    (UI_SCREEN_WIDTH - (YXSidePadding * 2))

#import <objc/NSObject.h>
#import <objc/NSObjCRuntime.h>
#import <objc/runtime.h>
#import <objc/message.h>

#endif /* KKConstants_h */
