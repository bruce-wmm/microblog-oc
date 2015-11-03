//
//  JFHomeVisitorView.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFHomeVisitorView.h"

@interface JFHomeVisitorView ()
@property (nonatomic, strong) UIImageView *rotateView;
@property (nonatomic, strong) UIImageView *shadowView;
@property (nonatomic, strong) UIImageView *houseView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation JFHomeVisitorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 准备UI
        [self prepareUI];
        
        // 背景颜色
        self.backgroundColor = [UIColor colorWithWhite:237/255.0 alpha:1];
    }
    return self;
}

#pragma mark - 准备UI
/**
 *  准备UI
 */
- (void)prepareUI {
    
    // 添加子控件
    [self addSubview:self.rotateView];
    [self addSubview:self.shadowView];
    [self addSubview:self.houseView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    
    // 约束子控件，参照轮子
    [self.rotateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).mas_offset(-50);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rotateView);
    }];
    
    [self.houseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rotateView);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rotateView.mas_centerX);
        make.width.mas_equalTo(240);
        make.top.equalTo(self.rotateView.mas_bottom).mas_offset(0);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabel.mas_left);
        make.top.equalTo(self.tipLabel.mas_bottom).mas_offset(16);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipLabel.mas_right);
        make.top.equalTo(self.tipLabel.mas_bottom).mas_offset(16);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    
    // 添加点击事件
    // 注册
    self.registerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:nil];
        }
        return [RACSignal empty];
    }];
    
    // 登录
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:nil];
        }
        return [RACSignal empty];
    }];

    // 开始旋转
    [self startRotation];
}

/**
 *  旋转动画
 */
- (void)startRotation {
    // 创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    // 设置动画执行时间
    animation.duration = 20;
    // 修改属性，执行动画
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    // 设置动画执行完毕后不删除动画
    animation.removedOnCompletion = NO;
    // 设置保存动画的最新状态
    animation.fillMode = kCAFillModeForwards;
    // 动画执行次数
    animation.repeatCount = MAXFLOAT;
    // 添加动画到layer
    [self.rotateView.layer addAnimation:animation forKey:nil];
}

#pragma mark - setters and getters or 懒加载
- (UIImageView *)rotateView {
    if (!_rotateView) {
        _rotateView = [[UIImageView alloc] init];
        [_rotateView sizeToFit];
        _rotateView.image = [UIImage imageNamed:@"visitordiscover_feed_image_smallicon"];
    }
    return _rotateView;
}

- (UIImageView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIImageView alloc] init];
        [_shadowView sizeToFit];
        _shadowView.image = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
        
    }
    return _shadowView;
}

- (UIImageView *)houseView {
    if (!_houseView) {
        _houseView = [[UIImageView alloc] init];
        [_houseView sizeToFit];
        _houseView.image = [UIImage imageNamed:@"visitordiscover_feed_image_house"];
        
    }
    return _houseView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        [_tipLabel sizeToFit];
        _tipLabel.text = @"关注一些人，回这里看看有什么惊喜";
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor grayColor];
    }
    return _tipLabel;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] init];
        [_registerButton sizeToFit];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton sizeToFit];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    }
    return _loginButton;
}

@end
