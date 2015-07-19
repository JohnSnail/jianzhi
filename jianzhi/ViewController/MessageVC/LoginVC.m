//
//  LoginVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/12.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "LoginVC.h"
#import "MyTabBarController.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)backMethod:(UIButton *)sender {
    
    [[MyTabBarController sharedInstance] setSelectedIndex:[MyTabBarController sharedInstance].lastSelectedIndex];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)weiboLoginAction:(UIButton *)sender {
    
    [self ssoButtonPressed];
}

- (void)ssoButtonPressed
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"login response is %@",response);
        //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
            //sina登录后获取新浪数据
            [[AppManager sharedAppManager]  requestWeiboInfoWithOpenid:snsAccount.usid token:snsAccount.accessToken response:^(NSDictionary *resDic) {
                [[AppManager sharedAppManager]requestUserRegist:resDic andOpenid:snsAccount.usid andUserType:@(3) response:^(NSDictionary *resDic) {
                    TLog(@"resDic == %@", resDic);
                    TLog(@"%@",[resDic objectForKey:@"msg"]);
                    
                    UserModel *user = [[UserModel alloc] initWithDict:[resDic objectForKey:@"user"]];
                    [CommUtils saveUserModel:user];
                    
                    NSString *userKey = [[resDic objectForKey:@"user"] objectForKey:@"user_token"];
                    [self saveUserKey:userKey];
                }];
            }];
        }
        
    });
}


- (IBAction)weixinLoginAction:(UIButton *)sender {
    
}


- (IBAction)QQLoginAction:(UIButton *)sender {
    [self ssoQQAction];
}

-(void)ssoQQAction{
    
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"login response is %@",response);
        NSDictionary *tecentDic = [response.data objectForKey:@"qzone"];
        
        if(response.responseCode != UMSResponseCodeSuccess) {
            return;
        } else {
            NSString *openid = [tecentDic objectForKey:@"usid"];
            NSString *token =[tecentDic  objectForKey:@"accessToken"];
           
            [[AppManager sharedAppManager] requestTecentInfoWithOpenid:openid token:token response:^(NSDictionary *resDic) {
                
                [[AppManager sharedAppManager]requestUserRegist:resDic andOpenid:openid andUserType:@(2) response:^(NSDictionary *resDic) {
                    
                    if ([[resDic objectForKey:@"code"] integerValue] == 0) {
                        
                        UserModel *user = [[UserModel alloc] initWithDict:[resDic objectForKey:@"user"]];
                        [CommUtils saveUserModel:user];
                        
                        NSString *userKey = [[resDic objectForKey:@"user"] objectForKey:@"user_token"];
                        [self saveUserKey:userKey];
                    }
                    
                }];
            }];
        }
    });
}

//保存用户信息
-(void)saveUserKey:(NSString *)user_key
{
    [CommUtils saveUserKey:user_key];
    
    if ([CommUtils is_onLine]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAction" object:nil];
}

@end
