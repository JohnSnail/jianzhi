//
//  MessageVC.m
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "MessageVC.h"
#import "UmengMessageVC.h"
#import "LoginVC.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"MessageBack"]];
    self.navigationItem.titleView = [CommUtils navTittle:@"消息"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self textLogin];
}

#pragma mark- 
#pragma mark- 判断是否登录

-(void)textLogin{
    
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }
}


-(IBAction)umengFaceBack:(id)sender
{
    [UMFeedback feedbackViewController].hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:[UMFeedback feedbackViewController]
                                         animated:YES];
}
-(IBAction)umengMessage:(id)sender
{
    UmengMessageVC *vc=LM_CREATE_OBJECT(UmengMessageVC);
    vc.hidesBottomBarWhenPushed=YES;
    LM_PUSH;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
