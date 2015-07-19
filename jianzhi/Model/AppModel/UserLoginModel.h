//
//  UserLoginModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginModel : NSObject

@property (nonatomic, assign) int user_id; //用户id
@property (nonatomic, assign) long time; //用户登录时间
@property (nonatomic, assign) long lat; //用户登录维度
@property (nonatomic, assign) long lng; //用户登录经度

@end
