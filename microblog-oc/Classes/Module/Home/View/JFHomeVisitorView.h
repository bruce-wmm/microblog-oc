//
//  JFHomeVisitorView.h
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFHomeVisitorView : UIView

/**
 *  信号
 */
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
