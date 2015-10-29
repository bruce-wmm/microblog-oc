//
//  UIApplication+Extension.h
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Extension)
/**
 *  切换主窗口上的根控制器
 *
 *  @param viewController 需要切换的控制器
 */
+ (void)switchViewController:(UIViewController *)viewController;
@end
