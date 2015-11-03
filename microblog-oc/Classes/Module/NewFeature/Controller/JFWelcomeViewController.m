//
//  JFWelcomeViewController.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFWelcomeViewController.h"
#import "UIApplication+Extension.h"
#import "JFTabBarController.h"

@interface JFWelcomeViewController ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation JFWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 添加子控件
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.nameLabel];
    
    // 约束子控件
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 头像
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(-160);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    // 欢迎提示
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView.mas_centerX);
        make.top.equalTo(self.iconView.mas_bottom).mas_offset(15);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 更新约束
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(kScreenH - 160));
    }];
    
    [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:5 options:0 animations:^{
        // 更新布局
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 渐变文字
        [UIView animateWithDuration:1.0 animations:^{
            self.nameLabel.alpha = 1;
        }];
        // 进入首页
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIApplication  switchViewController:[[JFTabBarController alloc] init]];
        });
    }];
}

#pragma mark - setters and getters or 懒加载
// 背景图片
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"ad_bgImage"];
    }
    return _bgImageView;
}

// 头像
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 45;
        _iconView.image = [UIImage imageNamed:@"tabbar_compose_book"];
    }
    return _iconView;
}

// 欢迎提示
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.alpha = 0;
        _nameLabel.text = @"欢迎归来";
    }
    return _nameLabel;
}


@end
