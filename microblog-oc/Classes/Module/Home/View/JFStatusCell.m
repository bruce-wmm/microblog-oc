//
//  JFStatusCell.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFStatusCell.h"

@implementation JFStatusCell

/**
 *  使用代码创建cell都会来这个方法，重写这个方法添加UI
 */
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
    
    // 添加控件
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.pictureView];
    [self.contentView addSubview:self.bottomView];
    
    // 约束控件都放到子类里
}

/**
 *  根据cell内部子控件约束计算cell高度
 *
 *  @param status 微博模型
 *
 *  @return 返回cell高度
 */
- (CGFloat)rowHeight:(JFStatus *)status {
    
    // 赋值status，会重新布局cell内部子控件
    self.status = status;
    
    // 返回最底部控件的最大y值，就是cell高度
    return CGRectGetMaxY(self.bottomView.frame);
}

/**
 *  更新数据
 */
- (void)setupData {
    // 在这里进行各种数据传递、更新
    // 微博文本
    self.contentLabel.text = self.status.text;
    
    // 传递微博模型给顶部视图
    self.topView.status = self.status;
    
    // 传递微博模型给配图视图
    self.pictureView.status = self.status;
    
    // 传递微博模型给底部视图
    self.bottomView.status = self.status;
    
    // 获取配图视图的尺寸
    self.size = self.pictureView.bounds.size;
}

#pragma mark - setters and getters or 懒加载

/**
 *  顶部视图
 */
- (JFTopView *)topView {
    if (!_topView) {
        _topView = [[JFTopView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

/**
 *  微博内容文字
 */
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

/**
 *  微博配图视图
 */
- (JFPictureView *)pictureView {
    if (!_pictureView) {
        _pictureView = [[JFPictureView alloc] init];
        _pictureView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:0.4];
    }
    return _pictureView;
}

/**
 *  微博底部视图
 */
- (JFBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JFBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

/**
 *  重写微博模型set方法，为cell内部子控件赋值数据
 */
- (void)setStatus:(JFStatus *)status {
    _status = status;
    
    // 更新cell内部子控件数据
    [self setupData];
}

@end
