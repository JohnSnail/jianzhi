//
//  VerifyViewController.m
//  SMS_SDKDemo
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "VerifyViewController.h"

#import "SMS_MBProgressHUD+Add.h"
#import <AddressBook/AddressBook.h>
#import "YJViewController.h"

#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/SMS_UserInfo.h>
#import <SMS_SDK/SMS_AddressBook.h>

@interface VerifyViewController ()
{
    NSString* _phone;
    NSString* _areaCode;
    int _state;
    NSMutableData* _data;
    NSString* _localVerifyCode;
    
    NSString* _appKey;
    NSString* _appSecret;
    NSString* _duid;
    NSString* _token;
    NSString* _localPhoneNumber;
    
    NSString* _localZoneNumber;
    NSMutableArray* _addressBookTemp;
    NSString* _contactkey;
    SMS_UserInfo* _localUser;
    
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;
    
    UIAlertView* _alert1;
    UIAlertView* _alert2;
    UIAlertView* _alert3;
    
    UIAlertView *_tryVoiceCallAlertView;

}

@end

static int count = 0;

//最近新好友信息
static NSMutableArray* _userData2;

@implementation VerifyViewController

-(void)clickLeftButton
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                  message:NSLocalizedString(@"codedelaymsg", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"back", nil)
                                        otherButtonTitles:NSLocalizedString(@"wait", nil), nil];
    _alert2=alert;
    [alert show];    
}

-(void)setPhone:(NSString*)phone AndAreaCode:(NSString*)areaCode
{
    _phone=phone;
    _areaCode=areaCode;
}

-(void)submit
{
    //验证号码
    //验证成功后 获取通讯录 上传通讯录
    [self.view endEditing:YES];
    
    if(self.verifyCodeField.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", nil)
                                                      message:NSLocalizedString(@"号码已绑定", nil)
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //[[SMS_SDK sharedInstance] commitVerifyCode:self.verifyCodeField.text];
        [SMS_SDK commitVerifyCode:self.verifyCodeField.text result:^(enum SMS_ResponseState state) {
            if (1==state)
            {
                NSLog(@"验证成功");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"号码已绑定", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
                _alert3=alert;
            }
            else if(0==state)
            {
                NSLog(@"验证失败");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"验证失败", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}


-(void)CannotGetSMS
{
    NSString* str=[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"是否重新发送", nil) ,_phone];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
    _alert1=alert;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_alert1)
    {
        if (1==buttonIndex)
        {
            NSLog(@"重发验证码");
            [SMS_SDK getVerifyCodeByPhoneNumber:_phone AndZone:_areaCode result:^(enum SMS_GetVerifyCodeResponseState state)
            {
                if (1==state)
                {
                    NSLog(@"block 获取验证码成功");
                }
                else if(0==state)
                {
                    NSLog(@"block 获取验证码失败");
                    NSString* str=[NSString stringWithFormat:NSLocalizedString(@"codesenderrormsg", nil)];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if (SMS_ResponseStateMaxVerifyCode==state)
                {
                    NSString* str=[NSString stringWithFormat:NSLocalizedString(@"maxcodemsg", nil)];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"maxcode", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
                {
                    NSString* str=[NSString stringWithFormat:NSLocalizedString(@"codetoooftenmsg", nil)];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
                    [alert show];
                }

            }];

        }
        
    }
    
    if (alertView==_alert2) {
        if (0==buttonIndex)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [_timer2 invalidate];
            [_timer1 invalidate];
        }
    }
    
    if (alertView==_alert3)
    {
        UserModel *user = [CommUtils readUser];
        user.mobile = _phone;
        [CommUtils saveUserModel:user];
        
        [self.navigationController popViewControllerAnimated:YES];
        [_timer2 invalidate];
        [_timer1 invalidate];
    }
    
    if (alertView == _tryVoiceCallAlertView)
    {
        if (0 ==buttonIndex)
        {
            [SMS_SDK getVerificationCodeByVoiceCallWithPhone:_phone
                                                        zone:_areaCode
                                                      result:^(SMS_SDKError *error)
             {
                 
                 if (error)
                 {
                     UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                                   message:[NSString stringWithFormat:@"状态码：%zi",error.errorCode]
                                                                  delegate:self
                                                         cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                         otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }];
        }
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat statusBarHeight=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight=20;
    }
    
    self.navigationItem.titleView = [CommUtils navTittle:@"绑定手机"];
//    //创建一个导航栏
//    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, self.view.frame.size.width, 44)];
//    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", nil)
//                                                                   style:UIBarButtonItemStyleBordered
//                                                                  target:self
//                                                                  action:@selector(clickLeftButton)];
//    
//    //设置导航栏内容
//    [navigationItem setTitle:NSLocalizedString(@"verifycode", nil)];
//    [navigationBar pushNavigationItem:navigationItem animated:NO];
//    [navigationItem setLeftBarButtonItem:leftButton];
//    [self.view addSubview:navigationBar];
    
//    UILabel* label=[[UILabel alloc] init];
//    label.frame=CGRectMake(15, 53+statusBarHeight, self.view.frame.size.width - 30, 21);
//    label.text=[NSString stringWithFormat:NSLocalizedString(@"verifylabel", nil)];
//    label.textAlignment = UITextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Helvetica" size:17];
//    [self.view addSubview:label];
    
    _telLabel=[[UILabel alloc] init];
    _telLabel.frame=CGRectMake(15, 12+statusBarHeight, self.view.frame.size.width - 30, 21);
    _telLabel.textAlignment = UITextAlignmentCenter;
    _telLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:_telLabel];
    self.telLabel.text= [NSString stringWithFormat:@"+%@ %@",_areaCode,_phone];
    
    _verifyCodeField=[[UITextField alloc] init];
    _verifyCodeField.frame=CGRectMake(15, 51+statusBarHeight, self.view.frame.size.width - 30, 46);
    _verifyCodeField.borderStyle=UITextBorderStyleBezel;
    _verifyCodeField.textAlignment=UITextAlignmentCenter;
    _verifyCodeField.placeholder=NSLocalizedString(@"请输入验证码", nil);
    _verifyCodeField.font=[UIFont fontWithName:@"Helvetica" size:18];
    _verifyCodeField.keyboardType=UIKeyboardTypePhonePad;
    _verifyCodeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:_verifyCodeField];
    
    _timeLabel=[[UILabel alloc] init];
    _timeLabel.frame=CGRectMake(15, 109+statusBarHeight, self.view.frame.size.width - 30, 40);
    _timeLabel.numberOfLines = 0;
    _timeLabel.textAlignment = UITextAlignmentCenter;
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _timeLabel.text=NSLocalizedString(@"重发", nil);
    [self.view addSubview:_timeLabel];
    
    _repeatSMSBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _repeatSMSBtn.frame=CGRectMake(15, 109+statusBarHeight, self.view.frame.size.width - 30, 30);
    [_repeatSMSBtn setTitle:NSLocalizedString(@"重发", nil) forState:UIControlStateNormal];
    [_repeatSMSBtn addTarget:self action:@selector(CannotGetSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_repeatSMSBtn];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button4.png"];
    [_submitBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    _submitBtn.frame=CGRectMake(15, 160+statusBarHeight, self.view.frame.size.width - 30, 42);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
//    _voiceCallMsgLabel=[[UILabel alloc] init];
//    _voiceCallMsgLabel.frame=CGRectMake(15, 268+statusBarHeight, self.view.frame.size.width - 30, 25);
//    _voiceCallMsgLabel.textAlignment = UITextAlignmentCenter;
//    _voiceCallMsgLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
//    [_voiceCallMsgLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
//    _voiceCallMsgLabel.text=NSLocalizedString(@"voiceCallMsgLabel", nil);
//    [self.view addSubview:_voiceCallMsgLabel];
//    _voiceCallMsgLabel.hidden = YES;
//    
//    _voiceCallButton=[UIButton buttonWithType:UIButtonTypeSystem];
//    [_voiceCallButton setTitle:NSLocalizedString(@"try voice call", nil) forState:UIControlStateNormal];
//    [_voiceCallButton setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    _voiceCallButton.frame=CGRectMake(15, 300+statusBarHeight, self.view.frame.size.width - 30, 42);
//    [_voiceCallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_voiceCallButton addTarget:self action:@selector(tryVoiceCall) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_voiceCallButton];
//    _voiceCallButton.hidden = YES;

    self.repeatSMSBtn.hidden=YES;
    
    [_timer2 invalidate];
    [_timer1 invalidate];
    
    count = 0;
    
    NSTimer* timer=[NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(showRepeatButton)
                                         userInfo:nil
                                          repeats:YES];
    
    NSTimer* timer2=[NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(updateTime)
                                                  userInfo:nil
                                                   repeats:YES];
    _timer1=timer;
    _timer2=timer2;
    
//    [SMS_MBProgressHUD showMessag:NSLocalizedString(@"发送中", nil) toView:self.view];
    
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}

-(void)backMethod
{
    LM_POP;
}

-(void)tryVoiceCall
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verificationByVoiceCallConfirm", nil)
                                                  message:[NSString stringWithFormat:@"%@: +%@ %@",NSLocalizedString(@"willsendthecodeto", nil),_areaCode, _phone]
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                        otherButtonTitles:NSLocalizedString(@"cancel", nil), nil];
    _tryVoiceCallAlertView = alert;
    [alert show];
}


-(void)updateTime
{
    count++;
    if (count>=60)
    {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    self.timeLabel.text=[NSString stringWithFormat:@"%@%i%@",NSLocalizedString(@"重发", nil),60-count,NSLocalizedString(@"s", nil)];
    
    if (count == 30)
    {
        if (_voiceCallMsgLabel.hidden)
        {
            _voiceCallMsgLabel.hidden = NO;
        }
        
        if (_voiceCallButton.hidden)
        {
            _voiceCallButton.hidden = NO;
        }
    }
}

-(void)showRepeatButton{
    self.timeLabel.hidden=YES;
    self.repeatSMSBtn.hidden=NO;
    
    [_timer1 invalidate];
    return;
}

@end
