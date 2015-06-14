//
//  SSRunLoopThread.m
//  SSRunLoopDemo
//
//  Created by LiGuicai on 15/6/14.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "SSRunLoopThread.h"

@implementation SSRunLoopThread

/* 
 重写main方法
 */
- (void)main{
    // The application uses garbage collection, so no autorelease pool is needed.
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];

    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    if (observer)
    {
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    // Create and schedule the timer.
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                   selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    
    NSInteger loopCount = 10;
    do
    {
        // Run the run loop 10 times to let the timer fire.
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        loopCount--;
    }
    while (loopCount);
}

#pragma mark - Observer

void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"Current thread Run Loop activity: %@", printActivity(activity));
}

static inline NSString* printActivity(CFRunLoopActivity activity)
{
    NSString *activityDescription;
    switch (activity) {
        case kCFRunLoopEntry:
            activityDescription = @"kCFRunLoopEntry";
            break;
        case kCFRunLoopBeforeTimers:
            activityDescription = @"kCFRunLoopBeforeTimers";
            break;
        case kCFRunLoopBeforeSources:
            activityDescription = @"kCFRunLoopBeforeSources";
            break;
        case kCFRunLoopBeforeWaiting:
            activityDescription = @"kCFRunLoopBeforeWaiting";
            break;
        case kCFRunLoopAfterWaiting:
            activityDescription = @"kCFRunLoopAfterWaiting";
            break;
        case kCFRunLoopExit:
            activityDescription = @"kCFRunLoopExit";
            break;
        default:
            break;
    }
    return activityDescription;
}

#pragma mark - Timer
- (void)doFireTimer:(id)sender {
    NSLog(@"doFireTimer");
}

@end
