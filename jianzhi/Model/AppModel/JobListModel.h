//
//  JobListModel.h
//  jianzhi
//
//  Created by li on 15/6/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobListModel : NSObject
@property (nonatomic,copy) NSString *area_name;
@property (nonatomic,copy) NSString *browse_times;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *company_title;
@property (nonatomic,copy) NSString *create_timestamp;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *job_type_title;
@property (nonatomic,copy) NSString *salary;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *work_address;

@end
