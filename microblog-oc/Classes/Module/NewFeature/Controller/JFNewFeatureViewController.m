//
//  JFNewFeatureViewController.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFNewFeatureViewController.h"
#import "JFNewFeatureCell.h"
#import "JFTabBarController.h"
#import "UIApplication+Extension.h"

#define itemCount 4

@interface JFNewFeatureViewController ()

/**
 *  布局属性
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

/**
 *  进入按钮
 */
@property (nonatomic, strong) UIButton *enterButton;

@end

@implementation JFNewFeatureViewController

static NSString * const reuseIdentifier = @"newFeatureCell";

// 重写init方法，添加布局
- (instancetype)init {
    if (self = [super initWithCollectionViewLayout:self.layout]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.collectionView registerClass:[JFNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 开启分页效果
    self.collectionView.pagingEnabled = YES;
    
    // 关闭弹簧效果
    self.collectionView.bounces = NO;
    
    // 添加按钮
    [self.view addSubview:self.enterButton];
    
    // 约束按钮
    __weak typeof(self) weakSelf = self;
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-(SCREEN_WIDTH - 100) * 0.5);
        make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-200);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    // 按钮点击事件
    self.enterButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 进入主页
        [UIApplication switchViewController:[[JFTabBarController alloc] init]];
        return [RACSignal empty];
    }];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JFNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 设置数据
    cell.imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    
    return cell;
}

// 根据偏移量设置按钮出现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= SCREEN_WIDTH * 3) {
        [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
            self.enterButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
            self.enterButton.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    } else if (scrollView.contentOffset.x > SCREEN_WIDTH * 2) {
        [self.enterButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-(scrollView.contentOffset.x - SCREEN_WIDTH * 2 - (SCREEN_WIDTH + 100) * 0.5));
        }];
    } else if (scrollView.contentOffset.x <= SCREEN_WIDTH * 2) {
        [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
            self.enterButton.transform = CGAffineTransformIdentity;
            self.enterButton.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - setters and getters or 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

- (UIButton *)enterButton {
    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setBackgroundImage:[UIImage imageNamed:@"new_feature_button"] forState:UIControlStateNormal];
        [_enterButton setBackgroundImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateHighlighted];
        _enterButton.alpha = 0;
    }
    return _enterButton;
}

@end
