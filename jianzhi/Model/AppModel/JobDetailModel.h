//
//  JobDetailModel.h
//  jianzhi
//
//  Created by li on 15/6/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobDetailModel : NSObject
@property (nonatomic,copy) NSString *apply_count;//申请兼职人数
@property (nonatomic,copy) NSString *area_title;//区域名
@property (nonatomic,copy) NSString *browse_times;//浏览次数
@property (nonatomic,copy) NSString *city_title;//城市名
@property (nonatomic,copy) NSString *comment;//描述
@property (nonatomic,copy) NSString *company_title;
@property (nonatomic,copy) NSString *complaint_times;//投诉次数
@property (nonatomic,copy) NSString *contact_person;//联系人
@property (nonatomic,copy) NSString *create_timestamp;//发布时间
@property (nonatomic,copy) NSString *email;//联系邮箱
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *is_user_apply;
@property (nonatomic,copy) NSString *is_user_save;
@property (nonatomic,copy) NSString *job_type_title;//类别
@property (nonatomic,copy) NSString *lat;//纬度
@property (nonatomic,copy) NSString *lng;//经度
@property (nonatomic,copy) NSString *mobile;//联系电话
@property (nonatomic,copy) NSString *need_count;//这个兼职需要人数
@property (nonatomic,copy) NSString *salary;//薪资
@property (nonatomic,copy) NSString *title;//兼职名称
@property (nonatomic,copy) NSString *valid_time_end;//兼职有效时间-结束时间
@property (nonatomic,copy) NSString *valid_time_start;//兼职有效时间-开始时间
@property (nonatomic,copy) NSString *work_address;//工作地点
@property (nonatomic,copy) NSString *work_time;//兼职要求的工作时间
//评论model
@end
@interface CommentModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *create_timestamp;
@property (nonatomic,copy) NSString *figure_url;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_token;
@end
//申请职位model
@interface ApplyUserModel : NSObject
@property (nonatomic,copy) NSString *college;
@property (nonatomic,copy) NSString *figure_url;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_token;

@end
