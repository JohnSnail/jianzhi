//
//  CompanyModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic, assign) int company_id; //唯一标识
@property (nonatomic, copy) NSString *title; //公司名称
@property (nonatomic, assign) long establish_time; //公司成立时间
@property (nonatomic, copy) NSString *intro;  //公司介绍
@property (nonatomic, assign) long lat; //纬度
@property (nonatomic, assign) long lng; //经度
@property (nonatomic, copy) NSString *address; //公司地址
@property (nonatomic, copy) NSString *contact_email; //邮箱
@property (nonatomic, copy) NSString *contact_tel; //公司电话
@property (nonatomic, copy) NSString *contact_person; //联系人
@property (nonatomic, assign) BOOL is_email_check; //邮箱验证
@property (nonatomic, assign) BOOL is_tel_check; //手机验证
@property (nonatomic, assign) long create_timestamp; //z注册时间

@end
