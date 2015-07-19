//
//  GlobalClass.m
//  AiMianDan
//
//  Created by li on 14-9-22.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "GlobalClass.h"

@implementation GlobalClass
+ (void)getUserData
{
    
    [ClassModel LMAppModel].city_id=[LM_USER_DEFAULT objectForKey:@"city_id"];
//    [UserModel LMUser].mobile=[LM_USER_DEFAULT objectForKey:@"mobile"];//
//    [UserModel LMUser].accountInfoId=[LM_USER_DEFAULT objectForKey:@"accountInfoId"];
//    [UserModel LMUser].nickName=[LM_USER_DEFAULT objectForKey:@"nickName"];
//    [UserModel LMUser].email=[LM_USER_DEFAULT objectForKey:@"email"];
//    [UserModel LMUser].gender=[LM_USER_DEFAULT objectForKey:@"gender"];
//    [UserModel LMUser].birthDate=[LM_USER_DEFAULT objectForKey:@"birthDate"];
//    [UserModel LMUser].introduce=[LM_USER_DEFAULT objectForKey:@"introduce"];//iconUrl
//    [UserModel LMUser].iconUrl=[LM_USER_DEFAULT objectForKey:@"iconUrl"];
//    [UserModel LMUser].name=[LM_USER_DEFAULT objectForKey:@"name"];
//    [User LMUser].tiName=[LM_USER_DEFAULT objectForKey:@"tiName"];
//    [User LMUser].name= [LM_USER_DEFAULT objectForKey:@"name"];
//    [User LMUser].password=[LM_USER_DEFAULT objectForKey:@"password"];
//    [User LMUser].gold=[LM_USER_DEFAULT objectForKey:@"gold"];
//    [User LMUser].silverCoin=[LM_USER_DEFAULT objectForKey:@"silverCoin"];
//    [User LMUser].aggree=[LM_USER_DEFAULT objectForKey:@"aggree"];
//    [User LMUser].isVoice=[LM_USER_DEFAULT boolForKey:@"isVoice"];
//
//    [Business LMBusiness].BuName=[LM_USER_DEFAULT objectForKey:@"BuName"];
//    [Business LMBusiness].BuUserID=[LM_USER_DEFAULT objectForKey:@"BuUserID"];
//    [Business LMBusiness].BuPassword=[LM_USER_DEFAULT objectForKey:@"BuPassword"];
    
}
//存储用户信息isAgreeProtol
+ (void)storeUserData
{
    [LM_USER_DEFAULT setObject:[ClassModel LMAppModel].city_id forKey:@"city_id"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].mobile forKey:@"mobile"];//accountInfoId
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].mobile forKey:@"accountInfoId"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].nickName forKey:@"nickName"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].email forKey:@"email"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].gender forKey:@"gender"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].birthDate forKey:@"birthDate"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].introduce forKey:@"introduce"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].iconUrl forKey:@"iconUrl"];
//    [LM_USER_DEFAULT setObject:[UserModel LMUser].name forKey:@"name"];
//    [LM_USER_DEFAULT setObject:[User LMUser].city forKey:@"city"];
//    [LM_USER_DEFAULT setObject:[User LMUser].tiName forKey:@"tiName"];
//    [LM_USER_DEFAULT setObject:[User LMUser].name forKey:@"name"];
//    [LM_USER_DEFAULT setObject:[User LMUser].password forKey:@"password"];
//    [LM_USER_DEFAULT setObject:[User LMUser].gold forKey:@"gold"];
//    [LM_USER_DEFAULT setObject:[User LMUser].silverCoin forKey:@"silverCoin"];
//    [LM_USER_DEFAULT setBool:[User LMUser].isVoice forKey:@"isVoice"];
//    [LM_USER_DEFAULT setObject:[Business LMBusiness].BuName forKey:@"BuName"];
//    [LM_USER_DEFAULT setObject:[Business LMBusiness].BuUserID forKey:@"BuUserID"];
//    [LM_USER_DEFAULT setObject:[Business LMBusiness].BuPassword forKey:@"BuPassword"];
    

}
@end
