//
//  JFNewFeatureCell.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/1.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFNewFeatureCell.h"

@interface JFNewFeatureCell ()
// 新特性图片
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation JFNewFeatureCell

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    // 加载图片
    self.iconView.image = [UIImage imageNamed:imageName];
    
    [self.contentView addSubview:self.iconView];
    
    // 约束控件
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.iconView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
}

#pragma mark - setters and getters or 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}
@end
