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
 *  AFN
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

#pragma mark - 授权用户的url
/**
 *  获取授权页面的URL
 *
 *  @return 返回授权页面URL
 */
- (NSURL *)getOAuthUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",kClient_id,kRedirect_uri]];
}

#pragma mark - 加载access_token
/**
 *  加载access_token
 *
 *  @param code     code码
 *  @param finished 完成回调block
 */
- (void)loadAccessToken:(NSString *)code finished:(NetworkFinishedCallBack)finished {
    
    // 请求URL字符串
    NSString *requestString = @"oauth2/access_token";
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"client_id" : kClient_id,
                                 @"client_secret" : kApp_secret,
                                 @"grant_type" : kGrant_type,
                                 @"redirect_uri" : kRedirect_uri,
                                 @"code" : code
                                 };
    // 发送POST请求
    [self POST:requestString parameters:parameters finished:finished];
}

#pragma mark - 加载用户数据
/**
 *  加载用户数据
 *
 *  @param finished 完成回调block
 */
- (void)loadUserInfo:(NetworkFinishedCallBack)finished {
    
    // 请求URL字符串
    NSString *requestString = @"2/users/show.json";
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"access_token" : [JFUserAccount shareUserAccount].access_token,
                                 @"uid" : [JFUserAccount shareUserAccount].uid
                                 };
    // 发送GET请求
    [self GET:requestString parameters:parameters finished:finished];
    
}

#pragma mark - 加载微博数据
/**
 *  加载用户数据
 *
 *  @param finished 完成回调block
 */
- (void)loadStatus:(NetworkFinishedCallBack)finished {
    
    // 请求URL字符串
    NSString *requestString = @"2/statuses/home_timeline.json";
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"access_token" : [JFUserAccount shareUserAccount].access_token,
                                 };
    // 发送GET请求
    [self GET:requestString parameters:parameters finished:finished];
    
}

#pragma mark - 封装GET、POST请求
/**
 *  发送GET请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters finished:(NetworkFinishedCallBack)finished {
    [self.afnManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        finished(nil, error);
    }];
}

/**
 *  发送POST请求
 *
 *  @param URLString  请求API URL字符串
 *  @param parameters 请求参数
 *  @param finished   完成回调block
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters finished:(NetworkFinishedCallBack)finished {
    [self.afnManager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        finished(nil, error);
    }];
}

#pragma mark - setters and getters or 懒加载
- (AFHTTPSessionManager *)afnManager {
    if (!_afnManager) {
        // 初始化AFN
        _afnManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com/"]];
        _afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    }
    return _afnManager;
}

@end
