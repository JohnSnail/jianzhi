//
//  FeedbackVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "FeedbackVC.h"
#import <UIAlertView+Blocks.h>

@interface FeedbackVC ()

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    LMNOTMAINSCREEN;
//    self.navigationItem.titleView = [CommUtils navTittle:@"意见反馈"];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    self.navigationItem.rightBarButtonItem = [LMButton setNavright:@"提交" andcolor:RGB(255, 241, 241) andSelector:@selector(rightAction) andTarget:self];
    
    self.detailTextView.delegate = self;
    self.phoneField.delegate = self;
}

-(void)rightAction
{
    NSMutableString * testStr = [NSMutableString stringWithString:self.detailTextView.text];

    if (testStr.length == 0) {
        [UIAlertView showWithTitle:@"友情提示" message:@"请输入您的反馈内容" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            ;
        }];
        
        return;
    }
    
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"contacts":self.phoneField.text,@"content":testStr,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kFeedBack];
    TLog(@"输出请求内容%@",stringurl);
    
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            ;
        }else
        {
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

-(void)backMethod
{
    LM_POP;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    TLog(@"%@",textView.text);
    
    NSMutableString * testStr = [NSMutableString stringWithString:textView.text];
    self.numLabel.text = [NSString stringWithFormat:@"%lu", 200 - testStr.length];
    if (200 - testStr.length <= 0) {
        self.detailTextView.userInteractionEnabled = NO;
    }else{
        self.detailTextView.userInteractionEnabled = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
        self.detField.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        self.detField.hidden = NO;
    }else if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
        [self.phoneField becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneField resignFirstResponder];
    return YES;
}


@end
