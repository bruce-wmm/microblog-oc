//
//  JFCommon.h
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <Foundation/Foundation.h>

// APP授权信息
#define kClient_id @"3574168239"
#define kApp_secret @"3f7cc901506fd3c1c3255a78398ed340"
#define kRedirect_uri @"https://api.weibo.com/oauth2/default.html"
#define kGrant_type @"authorization_code"

/**
 *  用户归档路径
 */
#define kUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]