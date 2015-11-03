//
//  JFStatusCell.h
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFTopView.h"
#import "JFPictureView.h"
#import "JFBottomView.h"
#import "JFStatus.h"

@interface JFStatusCell : UITableViewCell

/**
 *  顶部视图
 */
@property (nonatomic, strong) JFTopView *topView;

/**
 *  微博文字内容
 */
@property (nonatomic, strong) UILabel *contentLabel;

/**
 *  微博配图视图
 */
@property (nonatomic, strong) JFPictureView *pictureView;

/**
 *  底部视图
 */
@property (nonatomic, strong) JFBottomView *bottomView;

/**
 *  微博模型
 */
@property (nonatomic, strong) JFStatus *status;

/**
 *  配图视图的尺寸
 */
@property (nonatomic, assign) CGSize size;

/**
 *  准备UI
 */
- (void)prepareUI;

/**
 *  更新数据
 */
- (void)setupData;

/**
 *  根据cell内部子控件约束计算cell高度
 *
 *  @param status 微博模型
 *
 *  @return 返回cell高度
 */
- (CGFloat)rowHeight:(JFStatus *)status;

@end
