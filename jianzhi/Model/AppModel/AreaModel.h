//
//  AreaModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject

@property (nonatomic, assign) int area_id; //唯一id
@property (nonatomic, assign) int city_id; //城市唯一id
@property (nonatomic, copy) NSString *name; //区域

@end
