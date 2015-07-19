//
//  PhoneVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/6/2.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PhoneVC.h"

@interface PhoneVC ()

@end

@implementation PhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [CommUtils navTittle:@"绑定手机"];
    
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    self.phoneField.delegate = self;
    self.doneField.delegate = self;
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    [self.sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setPhoneVCFrame];
}

-(void)setPhoneVCFrame
{
    self.bgImageView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    self.doneBtn.frame = CGRectMake(210 * VIEWWITH, 39 * VIEWWITH, 102 * VIEWWITH, 55 * VIEWWITH);
    self.phongBgImageView.frame = CGRectMake(8 * VIEWWITH, 39 * VIEWWITH, 194 * VIEWWITH, 55 * VIEWWITH);
    self.doneImageView.frame = CGRectMake(8 * VIEWWITH, 115 * VIEWWITH, 304 * VIEWWITH, 55 * VIEWWITH);
    self.doneLabel.frame = CGRectMake(14 * VIEWWITH, 115 * VIEWWITH, 65 * VIEWWITH, 55 * VIEWWITH);
    self.phoneLabel.frame = CGRectMake(14 * VIEWWITH, 39 * VIEWWITH, 43 * VIEWWITH, 55 * VIEWWITH);
    self.phoneField.frame = CGRectMake(65 * VIEWWITH, 52 * VIEWWITH, 137 * VIEWWITH, 30 * VIEWWITH);
    self.doneField.frame = CGRectMake(87 * VIEWWITH, 128 * VIEWWITH, 225 * VIEWWITH, 30 * VIEWWITH);
    self.sendBtn.frame = CGRectMake(210 * VIEWWITH, 39 * VIEWWITH, 102 * VIEWWITH, 55 * VIEWWITH);
}

-(void)sendAction
{
    ;
}

-(void)backMethod
{
    LM_POP;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneField resignFirstResponder];
    [self.doneField resignFirstResponder];
    return NO;
}

@end
