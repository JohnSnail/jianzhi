//
//  AppManager.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

/**
 *  单例
 */
+ (instancetype)sharedAppManager;

/**
 *  获取QQ详细信息
 *
 *  @param openid
 *  @param token
 */
- (void)requestTecentInfoWithOpenid:(NSString *)openid token:(NSString *)token response:(void (^) (id))block;

/**
 *  获取weibo详细信息
 *
 *  @param openid
 *  @param token
 *  @param block
 */
- (void)requestWeiboInfoWithOpenid:(NSString *)openid token:(NSString *)token response:(void (^) (id))block;

/**
 *  用户注册接口（第三方登录）
 *
 *  @param uuid
 *  @param device_name
 *  @param device_type
 *  @param user_type
 *  @param info
 *  @param version
 */
- (void)requestUserRegist:(NSDictionary *)info andOpenid:(NSString *)openId andUserType:(NSNumber *)user_type response:(void (^) (id))block;

@end
