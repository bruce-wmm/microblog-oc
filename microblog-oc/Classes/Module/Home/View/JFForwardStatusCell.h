//
//  JFForwardStatusCell.h
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFStatusCell.h"

@interface JFForwardStatusCell : JFStatusCell

/**
 *  转发微博背景
 */
@property (nonatomic, strong) UIButton *bgButton;

/**
 *  转发微博文字
 */
@property (nonatomic, strong) UILabel *forwardLabel;

@end
