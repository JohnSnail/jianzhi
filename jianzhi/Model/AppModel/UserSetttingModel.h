//
//  UserSetttingModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetttingModel : NSObject

@property (nonatomic, assign) int user_id; //用户id
@property (nonatomic, copy) NSString *intro; //个人简介
@property (nonatomic, copy) NSString *are_intentions; //兼职区域
@property (nonatomic, copy) NSString *job_intentions; //兼职类型
@property (nonatomic, copy) NSString *work_experience; //兼职经验
@property (nonatomic, copy) NSString *spare_time; //业余时间

@end
