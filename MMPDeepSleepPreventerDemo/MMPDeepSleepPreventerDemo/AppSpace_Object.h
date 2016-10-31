//
//  AppSpace_Object.h
//  IncentiveApp
//
//  Created by yhw on 16/10/24.
//  Copyright © 2016年 yhw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSpace_Object : NSObject

+ (instancetype)sharedInstance;
- (BOOL)isInstalled:(NSString *)bundleIdentifier;
- (void)open:(NSString *)bundleIdentifier;

@end
