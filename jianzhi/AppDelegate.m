//
//  AppDelegate.m
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "WelcomeViewController.h"

#import <UMSocialQQHandler.h>
#import <UMSocialSinaHandler.h>
#import <UMSocialWechatHandler.h>

#import <SMS_SDK/SMS_SDK.h>

@interface AppDelegate ()<appDelegate>
{
    BOOL canShow;
}
@end

@implementation AppDelegate


-(void)registDevice
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"mobile_key"]) {
        NSDictionary *parameters = @{@"uuid":[CommUtils imei],@"device_name":[CommUtils getMachine],@"device_type":@(1),@"version":[CommUtils getVersion]};
        NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kDeviveRegist];
        
        [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
            
            TLog(@"%@",results);
            
            TLog(@"%@",[results objectForKey:@"msg"]);
            
            if (results) {
                NSDictionary *dict=[results objectForKey:@"device"];
                if ((NSNull *)dict != [NSNull null])
                {
                    [CommUtils saveMobileKey:[dict objectForKey:@"device_token"]];
                }
            }else
            {
                TLog(@"ERROR: %@", error);
            }
        }];
    }
}

-(void)requestSetting
{
    NSDictionary *parameters = @{@"version":[CommUtils getVersion]};
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kSetting];
    
    NSLog(@"stringurl == %@", stringurl);
    
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        
        TLog(@"%@",results);
        
        TLog(@"%@",[results objectForKey:@"msg"]);
        
        if ([[results objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dict=[results objectForKey:@"app"];
            if ((NSNull *)dict != [NSNull null])
            {
                [CommUtils saveAllowQQLogin:[dict objectForKey:@"allow_qq_login"]];
            }
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}

-(void)enterHome
{
    TLog(@"回到主页");
    HomeManager *home=[[HomeManager alloc] init];
    [home configureDependencies:self.window];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
}

//友盟
-(void)UmengSocailAction
{
    //友盟统计
    [MobClick startWithAppkey:umAppKey];
    
    //友盟反馈
    [UMFeedback setAppkey:umAppKey];
    
    //友盟社会化组件
    [UMSocialData setAppKey:umAppKey];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    [UMSocialQQHandler setQQWithAppId:tAppid appKey:tAppKay url:nil];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:kRedirectURI];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [SMS_SDK registerApp:sKey withSecret:sSecret];
    [self UmengSocailAction];
    
    [self registDevice];
    [self requestSetting];
    
    [GlobalClass getUserData];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        WelcomeViewController *welVC = [[WelcomeViewController alloc]init];
        welVC.delegate = self;
        self.window.rootViewController = welVC;
        
    }else{
        [self enterHome];
    }
    
    [self.window makeKeyAndVisible];
    
    //集成Crashlytics
    [Fabric with:@[CrashlyticsKit]];
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

@end
