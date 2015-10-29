//
//  JFTabBarController.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFTabBarController.h"
#import "JFHomeTableViewController.h"
#import "JFMessageTableViewController.h"
#import "JFDiscoverTableViewController.h"
#import "JFProfileTableViewController.h"
#import "JFNavigationController.h"
#import "JFCenterViewController.h"

@interface JFTabBarController ()

@end

@implementation JFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加子控制器
    [self addAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 背景图片
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    // 添加中间按钮
    [self addCenterButton];
}

/**
 *  添加中间加号按钮
 */
- (void)addCenterButton {
    
    UIButton *button = [[UIButton alloc] init];
    [button sizeToFit];
    [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    // 添加约束
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tabBar);
    }];
    
    // 按钮点击事件
    button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self presentViewController:[[JFCenterViewController alloc] init] animated:YES completion:nil];
        return [RACSignal empty];
    }];
}

/**
 *  添加所有子控制器
 */
- (void)addAllChildViewControllers {
    
    [self setupOneChildViewController:[[JFHomeTableViewController alloc] init] title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected" badgeValue:@"8"];
    [self setupOneChildViewController:[[JFMessageTableViewController alloc] init] title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected" badgeValue:nil];
    [self addChildViewController:[[UIViewController alloc] init]];
    [self setupOneChildViewController:[[JFDiscoverTableViewController alloc] init] title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected" badgeValue:nil];
    [self setupOneChildViewController:[[JFProfileTableViewController alloc] init] title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected" badgeValue:@""];
    
}

/**
 *  设置单个子控制器
 *
 *  @param viewController    需要添加的子控制器
 *  @param title             标题
 *  @param imageName         tabBarItem默认图片名称
 *  @param selectedImageName tabBarItem选中后图片名称
 *  @param badgeValue        tabBarItem上数字
 */
- (void)setupOneChildViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName badgeValue:(NSString *)badgeValue {
    viewController.title = title;
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.badgeValue = badgeValue;
    JFNavigationController *homeNav = [[JFNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:homeNav];
}

@end
