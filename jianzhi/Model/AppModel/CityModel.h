//
//  CityModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic, copy) NSString *city_id; //唯一城市id
@property (nonatomic, copy) NSString *province_id; //省份唯一id
@property (nonatomic, copy) NSString *city_name; //城市名字

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
