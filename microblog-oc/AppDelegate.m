//
//  AppDelegate.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/26.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置全局外观
    [self setupGlobalStyle];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 设置主窗口
    [self chooseViewController];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

/**
 *  选择主窗口
 */
- (void)chooseViewController {
    
    
}

/**
 *  设置全局外观
 */
- (void)setupGlobalStyle {
    
}

@end
