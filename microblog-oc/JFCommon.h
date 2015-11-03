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

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  微博cell子控件各种统一边距
 */
#define STATUS_CELL_MARGIN 12

/**
 *  配图每个cell的默认宽、高
 */
#define ITEM_WIDTH (SCREEN_WIDTH - 44) / 3