//
//  SuggestVC.m
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "SuggestVC.h"
#import "LoginVC.h"
#import <IQKeyboardManager.h>
@interface SuggestVC ()

@end

@implementation SuggestVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
//    self.navigationController.navigationBar.translucent=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    LMNOTMAINSCREEN;
    self.navigationItem.titleView=[CommUtils navTittle:@"投诉"];
    self.navigationItem.rightBarButtonItem=[LMButton setNavright:@"提交" andcolor:RGB(255, 255, 255) andSelector:@selector(sendSuggest) andTarget:self];
    [self showViewMethod];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}
#pragma mark- 返回
-(void)backMethod
{
    LM_POP;
}

-(void)showViewMethod
{
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle600"]];
    //self.contentView.frame=CGRectMake(0, -64, mainscreenwidth, mainscreenhight);
    self.scrollView.contentSize=CGSizeMake(mainscreenwidth, mainscreenhight+100);
    //[self.scrollView addSubview:self.contentView];
}
#pragma mark - 提交信息
-(void)sendSuggest
{
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    //__weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion],@"content":_textView.text};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@user/complaint",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                [Manager textNoSpace:@"提交反馈成功"];
                
            }else
            {
                [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.textFieldCom.placeholder=@"";
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (!textView.text.length>0) {
        self.textFieldCom.placeholder=@"请输入您的反馈，我们不断为您改进";
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
