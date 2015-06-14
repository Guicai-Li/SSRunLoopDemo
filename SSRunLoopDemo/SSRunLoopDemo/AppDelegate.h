//
//  AppDelegate.h
//  SSRunLoopDemo
//
//  Created by LiGuicai on 15/6/14.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSRunLoopContext;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@interface AppDelegate (RunLoop)

- (void)registerSource:(SSRunLoopContext *)sourceContext;

- (void)removeSource:(SSRunLoopContext *)sourceContext;

@end

