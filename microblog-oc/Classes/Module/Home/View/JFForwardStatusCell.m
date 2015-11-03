//
//  JFForwardStatusCell.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFForwardStatusCell.h"

@implementation JFForwardStatusCell

/**
 *  重写父类准备UI方法，添加子类的控件
 */
- (void)prepareUI {
    [super prepareUI];
    
    // 添加控件
    [self.contentView insertSubview:self.bgButton belowSubview:self.pictureView];
    [self.contentView addSubview:self.forwardLabel];
    
    // 约束控件
    // 顶部视图
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(53);
    }];
    
    // 微博文本
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).mas_offset(STATUS_CELL_MARGIN);
        make.left.mas_equalTo(STATUS_CELL_MARGIN);
        make.width.mas_equalTo(SCREEN_WIDTH - STATUS_CELL_MARGIN * 2);
    }];
    
    // 转发微博背景
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(STATUS_CELL_MARGIN);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    // 转发微博文本
    [self.forwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgButton.mas_top).mas_offset(STATUS_CELL_MARGIN);
        make.left.equalTo(self.bgButton.mas_left).mas_offset(STATUS_CELL_MARGIN);
        make.right.equalTo(self.bgButton.mas_right).mas_offset(-STATUS_CELL_MARGIN);
        make.width.mas_offset(SCREEN_WIDTH - STATUS_CELL_MARGIN * 2);
    }];
    
    // 转发微博配图
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forwardLabel.mas_bottom).mas_offset(STATUS_CELL_MARGIN);
        make.left.equalTo(self.bgButton.mas_left).mas_offset(STATUS_CELL_MARGIN);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
    // 底部视图
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureView.mas_bottom).mas_offset(STATUS_CELL_MARGIN);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    // 底部固定
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
}

/**
 *  重写父类更新数据的方法，更新子类数据
 */
- (void)setupData {
    [super setupData];
    
    // 转发微博文本
    self.forwardLabel.text = [NSString stringWithFormat:@"%@:%@",self.status.retweeted_status.user.name,self.status.retweeted_status.text];
    
    // 更新约束
    [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.size);
    }];
    
    // 重新布局
    [self layoutIfNeeded];
    
}

#pragma mark - setters and getters or 懒加载
/**
 *  转发微博背景
 */
- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [[UIButton alloc] init];
        _bgButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
    }
    return _bgButton;
}

/**
 *  转发微博文字
 */
- (UILabel *)forwardLabel {
    if (!_forwardLabel) {
        _forwardLabel = [[UILabel alloc] init];
        _forwardLabel.textColor = [UIColor grayColor];
        _forwardLabel.font = [UIFont systemFontOfSize:14];
        _forwardLabel.numberOfLines = 0;
    }
    return _forwardLabel;
}

@end
