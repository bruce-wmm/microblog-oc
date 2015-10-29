//
//  JFHTTPTools.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFHTTPTools.h"

#pragma mark - JFHTTPTools扩展
@interface JFHTTPTools ()

/**
 *  AFN会话管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *afnManager;

@end

@implementation JFHTTPTools

#pragma mark - 网络请求类单例对象
/**
 *  网络请求类单例对象
 */
+ (instancetype)shareHTTPTools {
    static JFHTTPTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [super allocWithZone:zone];
}
/**
 *  创建JFHTTPTools单例的同时初始化AFN会话管理者
 */
- (instancetype)init {
    if (self = [super init]) {
        self.afnManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com/"]];
        self.afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    }
    return self;
}

#pragma mark - 授权用户的url
/**
 *  获取授权页面的URL
 *
 *  @return 返回授权页面URL
 */
+ (NSURL *)getOAuthUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",kClient_id,kRedirect_uri]];
}

#pragma mark - 封装GET、POST请求
/**
 *  发送GET请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters finished:(NetFinishedCallBack)finished {
    
}

/**
 *  发送POST请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters finished:(NetFinishedCallBack)finished {
    
}

@end
