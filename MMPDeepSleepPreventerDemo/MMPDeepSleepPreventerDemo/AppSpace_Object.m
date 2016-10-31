//
//  AppSpace_Object.m
//  IncentiveApp
//
//  Created by yhw on 16/10/24.
//  Copyright © 2016年 yhw. All rights reserved.
//

#import "AppSpace_Object.h"

@implementation AppSpace_Object

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (BOOL)isInstalled:(NSString *)bundleIdentifier {
    id target = [NSClassFromString(@"LSApplicationWorkspace") performSelector:@selector(defaultWorkspace)];
    NSArray *appList = [target performSelector:@selector(allInstalledApplications)];
    for (id proxy in appList) {
        if ([[proxy description] containsString:bundleIdentifier]) {
            return YES;
        }
    }
    return NO;
}

- (void)open:(NSString *)bundleIdentifier {
    NSLog(@"open %@", bundleIdentifier);
    id target = [NSClassFromString(@"LSApplicationWorkspace") performSelector:@selector(defaultWorkspace)];
    [target performSelector:@selector(openApplicationWithBundleID:) withObject:bundleIdentifier];
}

@end
