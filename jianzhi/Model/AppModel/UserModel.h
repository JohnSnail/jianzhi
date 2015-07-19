//
//  UserModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, retain) NSDate *birth_date; //出生日期
@property (nonatomic, copy) NSString *city_id; //城市id
@property (nonatomic, copy) NSString *college; //学校
@property (nonatomic, copy) NSString *college_enroll_time; //入学时间
@property (nonatomic, copy) NSString *country; //城市
@property (nonatomic, copy) NSString *email; //邮箱
@property (nonatomic, copy) NSString *figure_url;//头像
@property (nonatomic, copy) NSString *institute; //学院
@property (nonatomic, copy) NSString *mobile; //电话
@property (nonatomic, copy) NSString *nick_name; //昵称
@property (nonatomic, copy) NSString *province_id; //省份id
@property (nonatomic, assign) int sex; //性别
@property (nonatomic, copy) NSString *user_name; //用户
@property (nonatomic, copy) NSString *user_token; //用户唯一标示
@property (nonatomic, assign) int user_type; //第三方登录类型

//兼职区域、兼职类型、空闲时间、自我介绍、工作经验
@property (nonatomic, copy) NSString *job_area_intention;
@property (nonatomic, copy) NSString *job_type_intention;
@property (nonatomic, copy) NSString *spare_time;

@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *work_experience;



- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
