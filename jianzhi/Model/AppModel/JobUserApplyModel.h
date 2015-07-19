//
//  JobUserApplyModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobUserApplyModel : NSObject

@property (nonatomic, assign) int user_id; //评论人id
@property (nonatomic, assign) int job_id; //职位id
@property (nonatomic, assign) int apply_type; //1：电话；2：邮箱；3：短信；
@property (nonatomic, assign) long create_timestamp; //申请时间


@end
