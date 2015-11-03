//
//  JFStatus.h
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFUser.h"
#import "MJExtension.h"

@interface JFStatus : NSObject

/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  转发微博
 */
@property (nonatomic, strong) JFStatus *retweeted_status;

/**
 *  字符串型微博id
 */
@property (nonatomic, assign) int id;

/**
 *  微博发布用户
 */
@property (nonatomic, strong) JFUser *user;

/**
 *  微博发布时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  微博文本内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博配图数组，数组里都是装的key为thumbnail_pic的字典
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  微博配图数组，数组里装的都是配图的URL
 */
@property (nonatomic, strong) NSArray *image_urls;

/**
 *  根据是否是转发微博
 *
 *  @return 返回正确的URL数组
 */
- (NSArray *)getImage_urls;

/**
 *  加载微博数据
 *
 *  @param finished 回调block
 */
+ (void)loadStatus:(void (^)(NSArray *list, NSError *error))finished;

@end
