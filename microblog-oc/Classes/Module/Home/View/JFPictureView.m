//
//  JFPictureView.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFPictureView.h"
#import "JFPictureViewCell.h"
#import "JFStatus.h"

static NSString * const identifier = @"pictureCell";

@interface JFPictureView () <UICollectionViewDataSource>
/**
 *  布局属性
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation JFPictureView

/**
 *  重写init方法，在初始化的时候设置一个布局
 */
- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout]) {
        
        // 注册cell
        [self registerClass:[JFPictureViewCell class] forCellWithReuseIdentifier:identifier];
        
        // 指定数据源和代理
        self.dataSource = self;
    }
    return self;
}

/**
 *  更新数据
 */
- (void)setupData {
    
    // 重新布局，sizeToFit会调用sizeThatFits，返回新的视图尺寸
    [self sizeToFit];
    
    // 刷新数据
    [self reloadData];
}

/**
 *  返回sizeToFit重新计算好的尺寸
 */
- (CGSize)sizeThatFits:(CGSize)size {
    return [self calculateSize];
}

/**
 *  计算配图视图的自身尺寸
 */
- (CGSize)calculateSize {
    
    self.layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    
    // 获取图片的数量
    NSInteger count = [self.status getImage_urls].count;
    
    // 无图
    if (count == 0) {
        return CGSizeZero;
    }
    
    // 1张图
    if (count == 1) {
        CGSize size = CGSizeMake(150, 120);
        self.layout.itemSize = size;
        return size;
    }
    
    // 超过一张图就有间隔了
    CGFloat margin = 10;
    self.layout.minimumLineSpacing = margin;
    self.layout.minimumInteritemSpacing = margin;
    
    // 根据图片数量返回尺寸
    switch (count) {
        case 2: {
            return CGSizeMake(ITEM_WIDTH * 2 + margin, ITEM_WIDTH);
        }
        case 3: {
            return CGSizeMake(ITEM_WIDTH * 3 + 2 * margin, ITEM_WIDTH);
        }
        case 4: {
            return CGSizeMake(ITEM_WIDTH * 2 + margin, ITEM_WIDTH * 2 + margin);
        }
        case 5:
        case 6: {
            return CGSizeMake(ITEM_WIDTH * 3 + 2 * margin, ITEM_WIDTH * 2 + margin);
        }
        case 7:
        case 8:
        case 9: {
            return CGSizeMake(ITEM_WIDTH * 3 + 2 * margin, ITEM_WIDTH * 3 + 2 * margin);
        }
    }
    return CGSizeZero;
}

#pragma mark - UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%ld",[self.status getImage_urls].count);
    return [self.status getImage_urls].count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    JFPictureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 赋值URL
    cell.pictureUrl = [self.status getImage_urls][indexPath.item];
//    NSLog(@"%@",cell.pictureUrl);
    return cell;
}

#pragma mark - setters and getters or 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}

/**
 *  重写微博模型set方法，收到数据就更新
 */
- (void)setStatus:(JFStatus *)status {
    _status = status;
    
    // 更新数据
    [self setupData];
}

@end
