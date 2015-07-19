//
//  DeviceModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property (nonatomic, copy) NSString *uuid; //设备uuid
@property (nonatomic, copy) NSString *device_token; //设备唯一标识
@property (nonatomic, copy) NSString *user_token; //登录用户的token；
@property (nonatomic, copy) NSString *device_name; //设备名称
@property (nonatomic, copy) NSString *type;   //设备类型
@property (nonatomic, assign) long create_timestamp; //设备注册时间

@end
