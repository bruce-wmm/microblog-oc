//
//  JFPictureViewCell.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFPictureViewCell.h"
//#import "UIImageView+WebCache.h"

@interface JFPictureViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JFPictureViewCell

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
    [self.contentView addSubview:self.imageView];
    
    // 约束控件
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

/**
 *  更新cell数据
 */
- (void)setupData {
    // 更新数据
    [self.imageView sd_setImageWithURL:self.pictureUrl];
}

#pragma mark - setters and getters or 懒加载

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

/**
 *  重写set方法，更新cell内部数据
 */
- (void)setPictureUrl:(NSURL *)pictureUrl {
    _pictureUrl = pictureUrl;
    
    // 更新cell数据
    [self setupData];
}

@end
