//
//  JFBottomView.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFBottomView.h"

/**
 *  底部按钮宽度
 */
#define BUTTON_WIDTH (SCREEN_WIDTH / 3)

/**
 *  底部按钮高度
 */
#define BUTTON_HEIGHT 35

@interface JFBottomView ()
/**
 *  转发按钮
 */
@property (nonatomic, strong) UIButton *forwardButton;
/**
 *  评论按钮
 */
@property (nonatomic, strong) UIButton *commentButton;
/**
 *  赞按钮
 */
@property (nonatomic, strong) UIButton *likeButton;
@end

@implementation JFBottomView

/**
 *  绘制底部各种线
 */
- (void)drawRect:(CGRect)rect {
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 顶部分割线
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, 0);
    
    // 第一条竖线
    CGContextMoveToPoint(ctx, BUTTON_WIDTH, 4);
    CGContextAddLineToPoint(ctx, BUTTON_WIDTH, BUTTON_HEIGHT - 8);
    
    // 第二条竖线
    CGContextMoveToPoint(ctx, BUTTON_WIDTH * 2, 4);
    CGContextAddLineToPoint(ctx, BUTTON_WIDTH * 2, BUTTON_HEIGHT - 8);
    
    // 底部分割线
    CGContextMoveToPoint(ctx, 0, BUTTON_WIDTH);
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, BUTTON_WIDTH);
    
    // 设置线的颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite:0.9 alpha:1].CGColor);
    
    // 绘制
    CGContextStrokePath(ctx);
    
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}

- (instancetype)init {
    if (self = [super init]) {
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
    [self addSubview:self.forwardButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.likeButton];
    
//    // 约束子控件，约束不了。只能放 - layoutSubviews 里。但是那个方法调用非常频繁，在那约束效率非常低下。求大神解决
//    self.forwardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    self.commentButton.translatesAutoresizingMaskIntoConstraints = NO;
//    self.likeButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    // 转发
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.forwardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.forwardButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.forwardButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:BUTTON_WIDTH]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.forwardButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:BUTTON_HEIGHT]];
//    
//    // 评论
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:BUTTON_WIDTH]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:BUTTON_WIDTH]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.commentButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:BUTTON_HEIGHT]];
//    
//    // 赞
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:BUTTON_WIDTH * 2]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:BUTTON_WIDTH]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:BUTTON_HEIGHT]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 转发
    [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
    
    // 评论
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BUTTON_WIDTH);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
    
    // 赞
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BUTTON_WIDTH * 2);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
}

#pragma mark - setters and getters or 懒加载

/**
 *  转发按钮
 */
- (UIButton *)forwardButton {
    if (!_forwardButton) {
        _forwardButton = [[UIButton alloc] init];
        [_forwardButton setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    }
    return _forwardButton;
}

/**
 *  评论按钮
 */
- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        [_commentButton setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    }
    return _commentButton;
}

/**
 *  喜欢按钮
 */
- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] init];
        [_likeButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"timeline_icon_like"] forState:UIControlStateSelected];
    }
    return _likeButton;
}

@end
