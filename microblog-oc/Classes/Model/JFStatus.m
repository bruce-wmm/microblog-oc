//
//  JFStatus.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFStatus.h"

@implementation JFStatus

/**
 *  加载微博数据
 *
 *  @param finished 回调block
 */
+ (void)loadStatus:(void (^)(NSArray *list, NSError *error))finished {
    [[JFHTTPTools shareHTTPTools] loadStatus:^(NSDictionary *result, NSError *error) {
        
        // 失败
        if (error || result == nil) {
            NSLog(@"加载失败");
            finished(nil, error);
            return;
        }
        
        // 创建微博模型数组
        NSMutableArray *statuses = [NSMutableArray array];
        
        // 取出微博数组
        NSArray *list = result[@"statuses"];
        
        for (NSDictionary *dict in list) {
            JFStatus *status = [JFStatus objectWithKeyValues:dict];
            [statuses addObject:status];
        }
        
        // 回调结果
        finished([statuses mutableCopy], nil);
        
    }];
    
}

/**
 *  根据是否是转发微博
 *
 *  @return 返回正确的URL数组
 */
- (NSArray *)getImage_urls {
    return self.retweeted_status ? self.retweeted_status.image_urls : self.image_urls;
}

#pragma mark - setters and getters or 懒加载
- (void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in pic_urls) {
        // 取出图片URL字符串
        NSString *urlString = dict[@"thumbnail_pic"];
        // 创建图片URL对象
        NSURL *url = [NSURL URLWithString:urlString];
        // 将图片URL对象添加到数组中
        [arrayM addObject:url];
    }
    
    // 赋值给image_urls
    self.image_urls = [arrayM copy];
}

@end
