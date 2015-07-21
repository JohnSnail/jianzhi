//
//  PersonVC.m
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PersonVC.h"
#import "ProfileCell.h"
#import <UIAlertView+Blocks.h>
#import "LoginVC.h"
#import "ProfileVC.h"
#import "PersonCell.h"
#import "PersonKongCell.h"
#import "PersonQuitCell.h"
#import "ResumeVC.h"

@interface PersonVC ()

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setPersonFrame];
    self.navigationItem.titleView = [CommUtils navTittle:@"我"];
    [self initHeadView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(setUserData) name: @"loginAction" object: nil];
}
-(void)setPersonFrame
{
    self.personTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    self.headView.frame = CGRectMake(0, 0, 320 * VIEWWITH, 226 * VIEWWITH);
    self.picImageView.frame = CGRectMake(110 * VIEWWITH, 17 * VIEWWITH, 100 * VIEWWITH, 100 * VIEWWITH);
    self.nameLabel.frame = CGRectMake(110 * VIEWWITH, 127 * VIEWWITH, 98 * VIEWWITH, 21 * VIEWWITH);
    self.sexImageView.frame = CGRectMake(193 * VIEWWITH, 131 * VIEWWITH, 8 * VIEWWITH, 13 * VIEWWITH);
    self.ageLabel.frame = CGRectMake(125 * VIEWWITH, 156 * VIEWWITH, 71 * VIEWWITH, 21 * VIEWWITH);
    self.schLabel.frame = CGRectMake(8 * VIEWWITH, 185 * VIEWWITH, 304 * VIEWWITH, 21 * VIEWWITH);
    self.modImageView.frame = CGRectMake(183 * VIEWWITH, 92 * VIEWWITH, 25 * VIEWWITH, 25 * VIEWWITH);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self textLogin];
}

#pragma mark - 
#pragma mark - 设置头像

-(void)initHeadView
{
    self.personTbView.separatorStyle = NO;
    
    self.personTbView.tableHeaderView = self.headView;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*VIEWWITH, 226*VIEWWITH)];
    view.backgroundColor = [UIColor clearColor];
    self.personTbView.tableFooterView = view;
    
    self.picImageView.layer.masksToBounds = YES;
    self.picImageView.layer.cornerRadius = 100 * VIEWWITH/2;
    CALayer *layer = [self.picImageView layer];
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0f;
    
    self.picImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction)];
    [self.picImageView addGestureRecognizer:singleTap];//点击图片事件

}

-(void)setUserData
{
    if ([CommUtils readUser].sex == 2) {
        self.sexImageView.image = [UIImage imageNamed:@"boy"];
    }else if ([CommUtils readUser].sex == 1){
        self.sexImageView.image = [UIImage imageNamed:@"girl"];
    }
    
    NSString *birStr = [CommUtils stringFromDate:[CommUtils readUser].birth_date];
    NSString *nowStr = [CommUtils stringFromDate:[NSDate date]];
    
    if([birStr isEqualToString:nowStr] || !birStr){
        self.ageLabel.text = @"0岁";
    }else{
        self.ageLabel.text = [NSString stringWithFormat:@"%@岁",@([CommUtils getAgeAction:[NSDate date]] - [CommUtils getAgeAction:[CommUtils readUser].birth_date])];
    }
    TLog(@"figure_url = %@", [CommUtils readUser].figure_url);
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[CommUtils readUser].figure_url] placeholderImage:[UIImage imageNamed:@"180"]];

    self.nameLabel.text = [CommUtils readUser].nick_name;
    
    TLog(@"college_enroll_time = %@",[CommUtils readUser].college_enroll_time);
    
    [self schColEnrollTime];
    
}


-(void)schColEnrollTime
{
    TLog(@"[CommUtils readUser].college_enroll_time == %@",[CommUtils readUser].college_enroll_time);

    NSMutableString *collegeStr ;
    if ([CommUtils readUser].college) {
        collegeStr = [NSMutableString stringWithString:[CommUtils readUser].college];
    }
    NSMutableString *instituteStr ;
    if ([CommUtils readUser].institute) {
        instituteStr = [NSMutableString stringWithString:[CommUtils readUser].institute];

    }
    
    NSMutableString * enrollTime ;
    if ([CommUtils readUser].college_enroll_time) {
       enrollTime  =  [NSMutableString stringWithString:[CommUtils readUser].college_enroll_time];
    }
    
    TLog(@"enrollTime == %@",enrollTime);
    
    if (collegeStr.length == 0 && instituteStr.length == 0 && enrollTime.length == 0) {
        self.schLabel.text = @"未填写";
    }else if(collegeStr.length != 0){
        if (instituteStr.length == 0 && enrollTime.length == 0) {
            self.schLabel.text = collegeStr;
        }else if(instituteStr.length != 0 && enrollTime.length == 0){
            self.schLabel.text = [NSString stringWithFormat:@"%@,%@",collegeStr,instituteStr];
        }else if (instituteStr.length != 0 && enrollTime.length != 0){
            self.schLabel.text = [NSString stringWithFormat:@"%@,%@(%@)",collegeStr,instituteStr,enrollTime];
        }
    }
}

-(void)tappedAction
{
    ProfileVC *proVC = [[ProfileVC alloc]init];
    [self pushToViewController:proVC];
}

#pragma mark-
#pragma mark- 判断是否登录

-(void)textLogin{
    
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }else{
        [self setUserData];
    }
}

#pragma mark -
#pragma mark - UITableView delegate

- (NSInteger)numberOfSections{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[CommUtils getAllowQQLogin] integerValue] == 0) {
        return 7;
    }else{
        return 8;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==3) {
        return 41 * VIEWWITH;
    }else if(indexPath.row==7)
    {
        return  177 * VIEWWITH;
    }else
    {
        return 55 * VIEWWITH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==3) {
        
        static NSString *notice=@"PersonKongCell";
        PersonKongCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"PersonKongCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
        
    }else if(indexPath.row == 7){
        
        static NSString *reuseIdetify = @"PersonQuitCell";
        PersonQuitCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"PersonQuitCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell.QuitBtn addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{

        static NSString *notice=@"PersonCell";
        PersonCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            switch (indexPath.row) {
                case 0:
                    cell.headLabel.text = @"我的收藏";
                    
                    break;
                case 1:
                    cell.headLabel.text = @"我的兼职";
                    
                    break;
                case 2:
                    cell.headLabel.text = @"我的简历";
                    
                    break;
                case 4:
                    cell.headLabel.text = @"意见反馈";
                    
                    break;
                case 5:
                    cell.headLabel.text = @"评价我们";
                    
                    break;
                case 6:
                    cell.headLabel.text = @"关于我们";
                    
                    break;
                default:
                    break;
            }
    
        return cell;
    }
}

-(void)quitAction
{
    [UIAlertView showWithTitle:@"温馨提示" message:@"确定要退出吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"确定"]) {
            NSLog(@"退出");
            [CommUtils quitLoginAction];
            [CommUtils saveUserModel:nil];
            [self textLogin];
        }
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //some functions
    switch (indexPath.row) {
        case 2:{
            ResumeVC *resVC = [[ResumeVC alloc]init];
            [self pushToViewController:resVC];
            break;
        }
            
        case 0:{
            CollectVC *colVC = [[CollectVC alloc]init];
            [self pushToViewController:colVC];
            break;
        }
            
        case 1:{
            ParttimeVC *parVC = [[ParttimeVC alloc]init];
            [self pushToViewController:parVC];
            break;
        }
            
        case 4:{
            FeedbackVC *fedVC = [[FeedbackVC alloc]init];
            fedVC.navigationItem.titleView = [CommUtils navTittle:@"意见反馈"];
            [self pushToViewController:fedVC];
            break;
        }
            
        case 5:{
            //UIAlert 警告
            [UIAlertView showWithTitle:@"温馨提示" message:@"跪求AppStore五星评价" cancelButtonTitle:@"下次吧" otherButtonTitles:@[@"前往"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"前往"]) {
                    [self pushAppStore];
                    NSLog(@"前往");
                }
                    }];
            break;
        }
        case 6:{
            AboutUsVC *aboVC = [[AboutUsVC alloc]init];
            [self pushToViewController:aboVC];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - 跳转Appstore

-(void)pushAppStore
{
    NSString * url;
    if (IS_IOS_7) {
        url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", AppStoreAppId];
    }
    else{
        url=[NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AppStoreAppId];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)pushToViewController:(UIViewController *)viewController
{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
