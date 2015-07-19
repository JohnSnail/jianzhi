//
//  UserModel.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _birth_date = [aDecoder decodeObjectForKey:@"birth_date"];
        _city_id = [aDecoder decodeObjectForKey:@"city_id"];
        _college = [aDecoder decodeObjectForKey:@"college"];
        _country = [aDecoder decodeObjectForKey:@"country"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _figure_url = [aDecoder decodeObjectForKey:@"figure_url"];
        _institute = [aDecoder decodeObjectForKey:@"institute"];
        _mobile = [aDecoder decodeObjectForKey:@"mobile"];
        _nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        _province_id = [aDecoder decodeObjectForKey:@"province_id"];
        _user_name = [aDecoder decodeObjectForKey:@"user_name"];
        _user_token = [aDecoder decodeObjectForKey:@"user_token"];
        _sex = [aDecoder decodeIntForKey:@"sex"];
        _college_enroll_time = [aDecoder decodeObjectForKey:@"college_enroll_time"];
        
        _job_area_intention = [aDecoder decodeObjectForKey:@"job_area_intention"];
        _job_type_intention = [aDecoder decodeObjectForKey:@"job_type_intention"];
        _spare_time = [aDecoder decodeObjectForKey:@"spare_time"];
        _intro = [aDecoder decodeObjectForKey:@"intro"];
        _work_experience = [aDecoder decodeObjectForKey:@"work_experience"];

        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.birth_date forKey:@"birth_date"];
    [aCoder encodeObject:self.city_id forKey:@"city_id"];
    [aCoder encodeObject:self.college forKey:@"college"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.figure_url forKey:@"figure_url"];
    [aCoder encodeObject:self.institute forKey:@"institute"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.province_id forKey:@"province_id"];
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.user_token forKey:@"user_token"];
    [aCoder encodeInteger:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.college_enroll_time forKey:@"college_enroll_time"];
    
    [aCoder encodeObject:self.job_area_intention forKey:@"job_area_intention"];
    [aCoder encodeObject:self.job_type_intention forKey:@"job_type_intention"];
    [aCoder encodeObject:self.spare_time forKey:@"spare_time"];
    [aCoder encodeObject:self.intro forKey:@"intro"];
    [aCoder encodeObject:self.work_experience forKey:@"work_experience"];


}

@end
