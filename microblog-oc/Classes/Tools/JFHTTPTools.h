//
//  JFHTTPTools.h
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  回调block
 *
 *  @param result 请求返回结果
 *  @param error  请求错误
 */
typedef void (^NetFinishedCallBack)(id result, NSError *error);

@interface JFHTTPTools : NSObject

/**
 *  网络请求类单例对象
 */
+ (instancetype)shareHTTPTools;

/**
 *  获取授权页面的URL
 *
 *  @return 返回授权页面URL
 */
- (NSURL *)getOAuthUrl;

/**
 *  加载access_token
 *
 *  @param code     code码
 *  @param finished 完成回调block
 */
- (void)loadAccessToken:(NSString *)code finished:(NetFinishedCallBack)finished;

/**
 *  加载用户数据
 *
 *  @param finished 完成回调block
 */
- (void)loadUserInfo:(NetFinishedCallBack)finished;

/**
 *  发送GET请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters finished:(NetFinishedCallBack)finished;

/**
 *  发送POST请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters finished:(NetFinishedCallBack)finished;

@end
