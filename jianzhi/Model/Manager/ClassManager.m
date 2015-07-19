//
//  ClassManager.m
//  jianzhi
//
//  Created by li on 15/6/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ClassManager.h"

@implementation ClassManager
//获取城市
#pragma mark - 获取城市
+(void)getClassCity:(NSString *)city Success:(void (^)(id))block;
{
    //city/area
    if(![CommUtils getMobileKey]){
        return;
    }
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"city_name":city,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@cityId",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出区域%@",results);
        if (results) {
            if ((NSNull *)results != [NSNull null])
            {
                TLog(@"输出区域%@",results);
                NSArray *array=[results objectForKey:@"city"];
                NSArray *modelArray=[Manager dataAnalysisArray:@"CityModel" andArray:array];
                CityModel *model=[modelArray objectAtIndex:0];
                [ClassModel LMAppModel].city_id=model.city_id;
                TLog(@"输出区域%@",[ClassModel LMAppModel].city_id);
                [GlobalClass storeUserData];
                [LM_USER_DEFAULT synchronize];
                if (block) {
                    block(@"success");
                }
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
            if (block) {
                block(@"error");
            }
        }
    }];
}
#pragma mark - 获取城市区域//待用
+(void)getCityArearesponse:(void (^)(id))block
{
    //city/area
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@city/area",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出区域%@",results);
        if (results) {
            if ((NSNull *)results != [NSNull null])
            {
                if ([[results objectForKey:@"code"] intValue]==0) {
                    NSArray *array=[results objectForKey:@"area"];
                    NSMutableArray *mutable=[[NSMutableArray alloc] init];
                    [mutable addObject:@"全部区域"];
                    for (NSDictionary *dict in array) {
                        NSString *area=[dict objectForKey:@"name"];
                        [mutable addObject:area];
                    }
                    [ClassModel LMAppModel].cityArea=mutable;
                    if (block) {
                        block(mutable);
                    }
                }else
                {
                    [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
                }
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}
#pragma mark - 兼职类型
-(void)getJobType
{
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@job/type",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出区域%@",results);
        if (results) {
            if ((NSNull *)results != [NSNull null])
            {
                if ([[results objectForKey:@"code"] intValue]==0) {
                    
                }else
                {
                    [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
                }
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}

@end
