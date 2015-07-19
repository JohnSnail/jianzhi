//
//  UserSaveJobModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSaveJobModel : NSObject

@property (nonatomic, assign) int user_id; //评论人id
@property (nonatomic, assign) int job_id; //职位id
@property (nonatomic, assign) long create_timestamp; //收藏时间

@end
