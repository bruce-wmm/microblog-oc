//
//  JFUserAccount.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFUserAccount.h"

@implementation JFUserAccount

#pragma mark - 创建单例对象
/**
 *  创建用户单例对象
 */
+ (instancetype)shareUserAccount {
    static JFUserAccount *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        // 从沙盒获取用户数据，如果获取成功则赋值给单例对象
        id userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserInfoPath];
        if (userInfo) {
            instance = userInfo;
        }
    });
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [super allocWithZone:zone];
}

#pragma mark - 保存信息
/**
 *  保存用户信息
 */
- (void)saveUserInfoWithDictionary:(NSDictionary *)dict {
    // kvc为对象赋值属性
    [self setValuesForKeysWithDictionary:dict];
    
    // 将对象进行归档
    if ([NSKeyedArchiver archiveRootObject:self toFile:kUserInfoPath]) {
        NSLog(@"归档成功");
    } else {
        NSLog(@"归档失败");
    }
}
// 重新这个方法，防止kvc赋值时key与对象属性不能匹配问题
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

#pragma mark - 归档解档
/**
 *  归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avatar_large forKey:@"avatar_large"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeDouble:self.expires_in forKey:@"expires_in"];
}
/**
 *  解档
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeDoubleForKey:@"expires_in"];
    }
    return self;
}

#pragma mark - setters and getters
/**
 *  重写expires_in的set方法为expiresDate日期属性赋值
 */
- (void)setExpires_in:(NSTimeInterval)expires_in {
    _expires_in = expires_in;
    
    // 给expiresDate设置值
    self.expiresDate = [NSDate dateWithTimeIntervalSinceNow:expires_in];
}

/**
 *  重写授权判断的get方法，根据access_token是否有值来确定是否已授权
 */
- (BOOL)isAuth {
    if (_access_token) {
        return YES;
    } else {
        return NO;
    }
}

@end
