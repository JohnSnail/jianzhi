//
//  AppManager.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "AppManager.h"
#import "NSString+URL.h"

@implementation AppManager

SINGLETON_CLASS(AppManager)

- (void)requestWeiboInfoWithOpenid:(NSString *)openid token:(NSString *)token response:(void (^)(id))block
{
    NSDictionary *params = @{@"access_token": token,
                             @"uid": openid};
    
    [AFService getMethod:kSinaInfo andDict:params completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if (block) {
                block(results);
            }
        }else{
            if (block) {
                block(error);
            }
        }
    }];
}

- (void)requestTecentInfoWithOpenid:(NSString *)openid token:(NSString *)token response:(void (^)(id))block
{
    NSDictionary *params = @{@"access_token": token,
                             @"oauth_consumer_key": tAppid,
                             @"openid": openid};
    TLog(@"access_token%@",params);
    [AFService getMethod:kTecentInfo andDict:params completion:^(NSDictionary *results,NSError *error){
        TLog(@"results:%@",results);
        TLog(@"error%@",error);
        if (results) {
            if (block) {
                block(results);
            }
        }else{
            if (block) {
                block(error);
            }
        }
    }];
}

- (void)requestUserRegist:(NSDictionary *)info andOpenid:(NSString *)openId andUserType:(NSNumber *)user_type response:(void (^) (id))block
{
    
    TLog(@"info ====== %@",info);
    
    NSDictionary *dic = nil;
    
    if (user_type.integerValue == 3) {
        
        dic = @{@"openid":openId, @"nickname":[info objectForKey:@"name"], @"gender":[info
                                                                                          objectForKey:@"gender"], @"figureurl":[info objectForKey:@"profile_image_url"], @"country":@"", @"province":[info objectForKey:@"province"],@"city":[info objectForKey:@"city"]};
        
    }else if (user_type.integerValue == 2){
        
        NSString *figureurl = nil;
        if ([[info allKeys] containsObject:@"figureurl_qq_2"]){
            figureurl = [info objectForKey:@"figureurl_qq_2"];
        }else{
            figureurl = [info objectForKey:@"figureurl"];
        }
        
        dic = @{@"openid":openId, @"nickname":[info objectForKey:@"nickname"], @"gender":[info
                                                                                          objectForKey:@"gender"], @"figureurl":figureurl, @"country":@"", @"province":[info objectForKey:@"province"],@"city":[info objectForKey:@"city"]};
    }
        
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = @{@"uuid": [CommUtils imei],
                             @"device_name": [CommUtils getMachine],
                             @"device_type": @(1),@"user_type": user_type,@"info": jsonString,@"version": [CommUtils getVersion]};
    
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kUserRegist];

    TLog(@"stringurl = %@", stringurl);
    TLog(@"params = %@",params);
    
    [AFService postMethod:stringurl andDict:params completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if (block) {
                block(results);
            }
        }else{
            if (block) {
                block(error);
            }
        }
    }];
}
@end
