//
//  CityModel.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSNull class]]) {
                SEL se = NSSelectorFromString(key);
                if ([self respondsToSelector:se]) {
                    [self setValue:obj forKey:key];
                }
            }
        }];
    }
    return self;
}

@end
