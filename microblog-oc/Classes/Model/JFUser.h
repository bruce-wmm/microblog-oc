//
//  JFUser.h
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFUser : NSObject

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像URL字符串 50 * 50
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  用户头像URL - 计算型
 */
@property (nonatomic, strong) NSURL *profileImageUrl;

/**
 *  是否是认证用户
 */
@property (nonatomic, assign, getter=isVerified) BOOL verified;

/**
 *  认证类型 -1:没有认证  0:认证用户  2,3,5:企业认证  220:达人
 */
@property (nonatomic, assign) int verified_type;

/**
 *  认证图标 - 计算型
 */
@property (nonatomic, strong) UIImage *verifiedTypeImage;

/**
 *  会员等级 1-6
 */
@property (nonatomic, assign) int mbrank;

/**
 *  会员图标 - 计算型
 */
@property (nonatomic, strong) UIImage *mbrankImage;

@end
