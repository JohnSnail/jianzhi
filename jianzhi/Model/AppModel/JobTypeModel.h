//
//  JobTypeModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobTypeModel : NSObject

@property (nonatomic, assign) int job_id; //唯一id
@property (nonatomic, copy) NSString *name; //名字
@property (nonatomic, assign) long image_id; //图书id

@end
