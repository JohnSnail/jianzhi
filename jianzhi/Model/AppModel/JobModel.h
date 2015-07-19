//
//  JobModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobModel : NSObject

@property (nonatomic, assign) int job_id; //唯一标识
@property (nonatomic, assign) int job_type_id; //职位类型id
@property (nonatomic, assign) int job_area_id; //区域id
@property (nonatomic, copy) NSString *title; //名字
@property (nonatomic, copy) NSString *desc; //职位描述
@property (nonatomic, copy) NSString *comment; //注意事项
@property (nonatomic, copy) NSString *lat; //纬度
@property (nonatomic, copy) NSString *lng; //经度
@property (nonatomic, assign) int time_zone; //1：平时兼职；2：周末兼职
@property (nonatomic, copy) NSString *salary; //薪资
@property (nonatomic, assign) int need_count; //需要人数
@property (nonatomic, assign) int apply_count; //申请人数
@property (nonatomic, copy) NSString *work_address; //工作地点
@property (nonatomic, copy) NSString *work_time; //兼职的起止时间
@property (nonatomic, assign) long valid_time_start; //有效时间开始时间
@property (nonatomic, assign) long valid_time_end; //有效时间结束时间
@property (nonatomic, copy) NSString *contact_person; //联系人
@property (nonatomic, copy) NSString *contact_tel; //联系电话
@property (nonatomic, copy) NSString *tontact_email; //联系邮箱
@property (nonatomic, assign) int is_vaild; //是否有效
@property (nonatomic, assign) int browse_times; //浏览的次数
@property (nonatomic, assign) long create_timestamp; //发布时间


@end
