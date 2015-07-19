//
//  ClassModel.h
//  jianzhi
//
//  Created by li on 15/5/31.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject
@property (nonatomic,strong) NSDictionary *customTime;
@property (nonatomic,strong) NSDictionary *customType;
@property (nonatomic,strong) NSMutableDictionary *muCustomTime;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *city_id;
@property float lat,lng;
@property (nonatomic,strong) NSArray *cityArea;
+ (ClassModel *)LMAppModel;

@end
