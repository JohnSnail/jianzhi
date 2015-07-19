//
//  UserComplaintModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserComplaintModel : NSObject

@property (nonatomic, assign) int user_id; //评论人id
@property (nonatomic, assign) int job_id; //职位id
@property (nonatomic, assign) int company_id; //公司id
@property (nonatomic, copy) NSString *content; //投诉内容
@property (nonatomic, copy) NSString *contact; //投诉人联系方式
@property (nonatomic, assign) long create_timestamp; //投诉时间

@end
