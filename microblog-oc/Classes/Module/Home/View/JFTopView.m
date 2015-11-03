//
//  JFTopView.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFTopView.h"
#import "JFStatus.h"

@interface JFTopView ()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 *  认证图标
 */
@property (nonatomic, strong) UIImageView *verifiedView;

/**
 *  微博昵称
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 *  等级图标
 */
@property (nonatomic, strong) UIImageView *mbrankView;

/**
 *  发布时间
 */
@property (nonatomic, strong) UILabel *timeLabel;

/**
 *  微博来源
 */
@property (nonatomic, strong) UILabel *sourceLabel;
@end

@implementation JFTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 准备UI
        [self prepareUI];
    }
    return self;
}

/**
 *  准备UI
 */
- (void)prepareUI {
    
    // 添加子控件
    [self addSubview:self.iconView];
    [self addSubview:self.verifiedView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.mbrankView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sourceLabel];
    
    // 添加约束
    // 头像
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    // 认证图标
    [self.verifiedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).mas_offset(-5);
        make.top.equalTo(self.iconView.mas_bottom).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    // 微博昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).mas_equalTo(kStatusCellMargin);
        make.top.equalTo(self.iconView.mas_top);
    }];
    
    // 会员等级
    [self.mbrankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).mas_offset(kStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    // 发布时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.iconView.mas_bottom);
    }];
    
    // 微博来源
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).mas_offset(kStatusCellMargin);
        make.bottom.equalTo(self.timeLabel.mas_bottom);
    }];
    
}

/**
 *  重写微博模型set方法，在接收到数据就更新
 */
- (void)setStatus:(JFStatus *)status {
    _status = status;
    
    // 更新数据
    // 头像
    [self.iconView sd_setImageWithURL:self.status.user.profileImageUrl];
    
    // 认证图标
    self.verifiedView.image = self.status.user.verifiedTypeImage;
    
    // 昵称
    self.nameLabel.text = self.status.user.name;
    
    // 等级图标
    self.mbrankView.image = self.status.user.mbrankImage;
    
    // 发布时间
    self.timeLabel.text = self.status.created_at;
    
    // 微博来源
    self.sourceLabel.text = @"来自 六阿哥";
}

#pragma mark - setters and getters or 懒加载
/**
 *  头像
 */
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 17.5;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}
/**
 *  认证图标
 */
- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        _verifiedView = [[UIImageView alloc] init];
    }
    return _verifiedView;
}
/**
 *  昵称
 */
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}
/**
 *  等级图标
 */
- (UIImageView *)mbrankView {
    if (!_mbrankView) {
        _mbrankView = [[UIImageView alloc] init];
    }
    return _mbrankView;
}
/**
 *  发布时间
 */
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    }
    return _timeLabel;
}
/**
 *  微博来源
 */
- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        _sourceLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    }
    return _sourceLabel;
}



@end
