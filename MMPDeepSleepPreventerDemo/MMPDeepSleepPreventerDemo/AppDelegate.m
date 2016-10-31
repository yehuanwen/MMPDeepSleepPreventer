//
//  AppDelegate.m
//  MMPDeepSleepPreventerDemo
//
//  Created by yhw on 16/10/31.
//  Copyright © 2016年 yhw. All rights reserved.
//

#import "AppDelegate.h"
#import "MMPDeepSleepPreventer.h"
#import "AppSpace_Object.h"

static NSInteger count = 0;

static NSInteger runCount = 0;

@interface AppDelegate ()

@end

@implementation AppDelegate {
    MMPDeepSleepPreventer *_deepSleepPreventer;
    NSTimer *_timer;
}

- (void)fire {
    NSLog(@"fire");
    if (++count == 3) {
        [[AppSpace_Object sharedInstance] open:@"com.apple.mobilesafari"];
    }
}

static void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    CFStringRef nameCFString = (CFStringRef)name;
    NSString *lockState = (__bridge NSString*)nameCFString;
    
    if([lockState isEqualToString:@"com.apple.springboard.lockcomplete"])
    {
        runCount ++;
    }
    else
    {
        runCount ++;
        if (runCount % 3 == 2)
        {
           NSLog(@"lock"); 
        }
        else
        {
            NSLog(@"resume");
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _deepSleepPreventer = [[MMPDeepSleepPreventer alloc] init];
    [_deepSleepPreventer startPreventSleep];
    
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(fire) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    //Screen lock notifications
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                    NULL, // observer
                                    displayStatusChanged, // callback
                                    CFSTR("com.apple.springboard.lockcomplete"), // event name
                                    NULL, // object
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                    NULL, // observer
                                    displayStatusChanged, // callback
                                    CFSTR("com.apple.springboard.lockstate"), // event name
                                    NULL, // object
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
