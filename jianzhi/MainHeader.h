//
//  MainHeader.h
//  有礼网
//
//  Created by yuntu on 13-12-9.
//  Copyright (c) 2013年 yuntu. All rights reserved.
//

#ifndef ____MainHeader_h
#define ____MainHeader_h
#import <UIKit/UIKit.h>
#define mainscreen [UIScreen mainScreen].bounds
#define mainscreenhight [UIScreen mainScreen].bounds.size.height
#define mainscreenwidth [UIScreen mainScreen].bounds.size.width
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
//iphone5判断宏定义
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)

#define NavBarHeight ((IS_IOS_7)?65:0)
#define StateBarHeight ((IS_IOS_7)?20:0)
#define ButtonFrame ((IS_IOS_7)?45:65)
#define ViewHeight ((IS_IPHONE_5)?20:0)

//http://121.40.140.234:4500/
#define API @"http://121.40.140.234:8083/account-rest/service/"//service/"
//#define PartyAPI @"http://121.40.140.234:4500/"
//#define API @"http://app.ycombo.com/service/"//http://121.40.140.234:8083/account-rest/service/
//#define API @"http://192.168.1.120:8080/account-rest/service/"

#define PartyAPI @"http://tongxuejianzhi.com/"

//七牛存储图片
#define QiNiuUrl @"http://7xjzqm.com1.z0.glb.clouddn.com/"

//#define PartyAPI @"http://42.121.122.44:8080/"
#define globalURL(str) [NSString stringWithFormat:@"http://115.29.36.80/userapi.php?%@",str]
#define ChangeColor(str,index) [NSString stringWithFormat:@"%@%@",str,index]
#define LM_USER_DEFAULT         [NSUserDefaults standardUserDefaults]
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7
#define IoskeyHeight ((IS_IOS_7)?0:65)
//宏定义alloc
#define LM_CREATE_OBJECT(CLASSNAME)    [[CLASSNAME alloc] init]
#define LM_POP    [self.navigationController popViewControllerAnimated:YES]
#define LM_PUSH   [self.navigationController pushViewController:vc animated:YES];

//RGB颜色宏定义
#define RGB(red,gre,blu) [UIColor colorWithRed:red/255.0f green:gre/255.0f blue:blu/255.0f alpha:1.0]
#define RGBAlp(red,gre,blu) [UIColor colorWithRed:red/255.0f green:gre/255.0f blue:blu/255.0f alpha:0.5]
//粗体宏定义
#define boldFont(s) [UIFont boldSystemFontOfSize:(s)]
//将16进制颜色转换为uicolor
#define UIColorToRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define VIEWWITH (mainscreenwidth/320.0)
//设置导航栏字体颜色
#define NAVIGATIONTITLe [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, -1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:10.0],UITextAttributeFont,nil]];
//设置开始位置不是默认全屏
#define LMNOTMAINSCREEN if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){self.edgesForExtendedLayout = UIRectEdgeNone;self.extendedLayoutIncludesOpaqueBars = NO;self.modalPresentationCapturesStatusBarAppearance = NO;}
#define kYX_APP_DELEGATE             (AppDelegate *)[UIApplication sharedApplication].delegate
//友盟key
#define umAppKey  @"5548cf6767e58ee3e40048ec"
//微信key
#define WEIXINPAY @"wx2a47835534cde0a8"
//设置输出
#define TDebug 1
#if TDebug
#define TLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#else
#define TLog(format, ...)
#endif
//警告框----两个按钮
#define kYX_ALERT_VIEW(titles,messages,delegates,cancelTitles,otherTitles)              [[UIAlertView alloc] initWithTitle:titles message:messages delegate:delegates cancelButtonTitle:cancelTitles otherButtonTitles:otherTitles, nil];
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//====新浪微博
//com.sina.weibo.SNWeiboSDKDemo

#define kAppKey         @"3814555090"
#define kRedirectURI    @"http://sns.whalecloud.com/sina2/callback"

//====QQ互联

#define tAppid @"1104666394"
#define tAppKay @"vAJhVu8vzaeMZUeJ"
#define tRedirectURI @"www.qq.com"

//第三方获取用户详细信息
#define kSinaInfo                   @"https://api.weibo.com/2/users/show.json"
#define kTecentInfo                 @"https://graph.qq.com/user/get_user_info"

//短信验证
#define sKey @"857bbd0ec51f"
#define sSecret @"f05352dd509d500c6a3ed67f931e93ac"

//appID
#define AppStoreAppId @"994070056"

//==获取当前设备的宽度
#define kWidth [UIScreen mainScreen].bounds.size

#define SKU @"tongxuejianzhi"

//==单例
#define SINGLETON_CLASS(classname) \
\
+ (classname *)shared##classname \
{\
static dispatch_once_t pred = 0; \
__strong static id _shared##classname = nil; \
dispatch_once(&pred,^{ \
_shared##classname = [[self alloc] init]; \
});  \
return _shared##classname; \
}

//#import <AFHTTPRequestOperationManager.h>
#import <UIImageView+WebCache.h>
#import <JSONKit.h>
#import <MobClick.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <UINavigationController+SGProgress.h>
#import "Manager.h"
#import "GlobalClass.h"
#import "LocolData.h"
#import "LMViewHeader.h"
#import "MLNavigationController.h"
#import "AFService.h"
//#import "AppModelHeader.h"
//#import "APService.h"
#import <UMFeedback.h>
#import "LMViewHeader.h"
#import <SFHFKeychainUtils.h>
#import "CommUtils.h"
#import "ApiHeader.h"
#import <UMengSocial/UMSocial.h>
#import <MobClick.h>
#import "AppManager.h"
#import "ClassModel.h"
#import <UIActionSheet+Blocks.h>
#import <UIAlertView+Blocks.h>
#import "LMAppModelHeader.h"
#endif
