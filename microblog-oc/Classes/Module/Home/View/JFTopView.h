//
//  JFTopView.h
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JFStatus;

@interface JFTopView : UIView

/**
 *  微博模型
 */
@property (nonatomic, strong) JFStatus *status;

@end
