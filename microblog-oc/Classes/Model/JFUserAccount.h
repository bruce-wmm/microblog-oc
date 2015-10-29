//
//  JFUserAccount.h
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFUserAccount : NSObject <NSCoding>

/**
 *  用户名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址
 */
@property (nonatomic, copy) NSString *avatar_large;

/**
 *  用户access_token
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  过期了
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户uid
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  过期日期
 */
@property (nonatomic, strong) NSDate *expiresDate;

/**
 *  过期时间，单位秒
 */
@property (nonatomic, assign) NSTimeInterval expires_in;

/**
 *  是否已经授权
 */
@property (nonatomic, assign, getter=isAuth) BOOL auth;

/**
 *  创建单例对象
 */
+ (instancetype)shareUserAccount;


@end
