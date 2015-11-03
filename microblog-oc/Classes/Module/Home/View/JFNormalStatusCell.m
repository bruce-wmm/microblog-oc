//
//  JFNormalStatusCell.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFNormalStatusCell.h"

@implementation JFNormalStatusCell

/**
 *  重写父类准备UI方法，添加子类的控件
 */
- (void)prepareUI {
    [super prepareUI];
    
    // 约束控件
    // 顶部视图
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(53);
    }];
    
    // 微博文本
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kStatusCellMargin);
        make.right.mas_equalTo(-kStatusCellMargin);
        make.top.equalTo(self.topView.mas_bottom).mas_offset(kStatusCellMargin);
        make.width.mas_equalTo(kScreenW - kStatusCellMargin * 2);
    }];
    
    // 微博配图
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(kStatusCellMargin);
        make.left.mas_equalTo(kStatusCellMargin);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
    // 底部视图
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.pictureView.mas_bottom).mas_offset(kStatusCellMargin);
        make.height.mas_equalTo(30);
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
    
    // 这里做子类数据操作
    [self prepareUI];
    
    // 更新约束
    [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.size);
    }];
    
    // 重新布局
    [self layoutIfNeeded];
}


@end
