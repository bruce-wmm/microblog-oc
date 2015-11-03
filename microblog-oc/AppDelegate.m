//
//  AppDelegate.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/26.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "AppDelegate.h"
#import "JFTabBarController.h"
#import "JFUserAccount.h"
#import "JFNewFeatureViewController.h"
#import "JFWelcomeViewController.h"

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
    
    if ([JFUserAccount shareUserAccount].isAuth) {
        // 已经授权就判断是否是新版本，是新版本就加载新特性，否则加载欢迎页
        self.window.rootViewController = [self isNewVersion] ? [[JFNewFeatureViewController alloc] init] : [[JFWelcomeViewController alloc] init];
        
    } else {
        // 未授权加载tabBarController
        self.window.rootViewController = [[JFTabBarController alloc] init];
    }
    
}

/**
 *  是否是新版本
 */
- (BOOL)isNewVersion {
    
    // key
    NSString *key = (__bridge NSString *)kCFBundleVersionKey;
    
    // 获取当前应用版本
    double currentVersion = [[NSBundle mainBundle].infoDictionary[key] doubleValue];
    
    // 获取偏好设置中保存版本
    double sandBoxVersion = [[NSUserDefaults standardUserDefaults] doubleForKey:key];
    
    // 存储当前版本覆盖偏好设置中的版本
    [[NSUserDefaults standardUserDefaults] setDouble:currentVersion forKey:key];
    
    // 比较版本
    return currentVersion > sandBoxVersion;
}

/**
 *  设置全局外观
 */
- (void)setupGlobalStyle {
    
}

@end
