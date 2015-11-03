//
//  JFUser.m
//  microblog-oc
//
//  Created by jianfeng on 15/11/2.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFUser.h"

@implementation JFUser

- (void)setProfile_image_url:(NSString *)profile_image_url {
    _profile_image_url = profile_image_url;
    
    // 调用者可以直接获取URL，而不需要每次都去初始化
    self.profileImageUrl = [NSURL URLWithString:profile_image_url];
}

- (void)setVerified_type:(int)verified_type {
    _verified_type = verified_type;
    
    // 根据认证类型设置不同图标
    switch (verified_type) {
        case 0:
            self.verifiedTypeImage = [UIImage imageNamed:@"avatar_vip"];
            break;
        case 2:
        case 3:
        case 5:
            self.verifiedTypeImage = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case 220:
            self.verifiedTypeImage = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedTypeImage = nil;
            break;
    }
}

- (void)setMbrank:(int)mbrank {
    _mbrank = mbrank;
    
    // 根据会员等级设置不同图标
    if (mbrank > 0 && mbrank <= 6) {
        self.mbrankImage = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",mbrank]];
    } else {
        self.mbrankImage = nil;
    }
    
}

@end
