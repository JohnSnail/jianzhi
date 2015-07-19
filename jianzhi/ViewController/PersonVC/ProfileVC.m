//
//  ProfileVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ProfileVC.h"
#import "ExpDetailCell.h"
#import "ZHPickView.h"
#import "ProfileCell.h"
#import "ProfileDetailCell.h"
#import "SchoolVC.h"
#import "CollegeVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [CommUtils navTittle:@"修改资料"];
    self.proTbView.backgroundColor = [UIColor clearColor];
    self.proTbView.backgroundView = nil;
    self.proTbView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 543"]];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    [_pickview setPickViewColer:[UIColor whiteColor]];
    [_pickview setTintColor:RGB(250, 109, 111)];
    _pickview.delegate=self;
    
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:100];
    for (int i = 2001; i <= [CommUtils getAgeAction:[NSDate date]]; i++) {
        [muArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _pickview2=[[ZHPickView alloc] initPickviewWithArray:[NSArray arrayWithArray:muArr] isHaveNavControler:NO];
    [_pickview2 setPickViewColer:[UIColor whiteColor]];
    [_pickview2 setTintColor:RGB(250, 109, 111)];
    _pickview2.delegate=self;
    
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    [self setProfileVCFrame];
    
     self.navigationItem.rightBarButtonItem = [LMButton setNavright:@"提交" andcolor:RGB(255, 241, 241) andSelector:@selector(rightAction) andTarget:self];
}

-(void)rightAction
{
    TLog(@"提交个人简历");
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"city_id":[ClassModel LMAppModel].city_id,@"user_name":[CommUtils readUser].nick_name,@"birth_date":[CommUtils readUser].birth_date,@"college":[CommUtils readUser].college,@"institute":[CommUtils readUser].institute,@"sex":@([CommUtils readUser].sex),@"college_enroll_time":[CommUtils readUser].college_enroll_time,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kUserSetting];
    TLog(@"输出请求内容%@",stringurl);
    
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"results: %@", results);
            
        }else{
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
        
    }];
}

-(void)setProfileVCFrame
{
    self.proTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
}

-(void)backMethod
{
    LM_POP;
}

#pragma mark -
#pragma mark - UITableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 6) {
        return 10 * VIEWWITH;
    }else if(indexPath.row == 1){
        return 70 * VIEWWITH;
    }else{
        return 55 * VIEWWITH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        static NSString *notice=@"ProfileCell";
        ProfileCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell.headIamgeView sd_setImageWithURL:[NSURL URLWithString:[CommUtils readUser].figure_url] placeholderImage:[UIImage imageNamed:@"180"]];
        
        return cell;
    }else if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 6){
        static NSString *reuseIdetify = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.backgroundColor = [UIColor clearColor];
            cell.backgroundView = nil;
        }
        return cell;
    }else{
        static NSString *notice=@"ProfileDetailCell";
        ProfileDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"ProfileDetailCell" owner:self options:nil] lastObject];
            TLog(@"shuchu%@",indexPath);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.boyBtn.tag = 201;
            [cell.boyBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
            cell.boyBtn.selected = YES;
            
            cell.girlBtn.tag = 202;
            [cell.girlBtn addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
            cell.girlBtn.selected = NO;
        }
        switch (indexPath.row) {
            case 3:
                cell.headLabel.text = @"姓名";
                cell.detTextField.hidden = NO;
//                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiNei"]];
                [cell hideSexView:YES];
                cell.contentsLabel.hidden = YES;
                cell.detTextField.text = [CommUtils readUser].nick_name;
                break;
            case 4:
                cell.headLabel.text = @"性别";
                cell.detTextField.hidden = YES;
                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiNei"]];
                [cell hideSexView:NO];
                cell.contentsLabel.hidden = YES;
                TLog(@"sex ===== %d",[CommUtils readUser].sex);
                
                if ([CommUtils readUser].sex == 2) {
                    cell.boyBtn.selected = YES;
                    cell.girlBtn.selected = NO;
                }else if ([CommUtils readUser].sex == 1){
                    cell.boyBtn.selected = NO;
                    cell.girlBtn.selected = YES;
                }
                break;
            case 5:{
                cell.headLabel.text = @"年龄";
                cell.detTextField.hidden = YES;
                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiJian"]];
                [cell hideSexView:YES];
                cell.contentsLabel.hidden = NO;
                
                NSString *birStr = [CommUtils stringFromDate:[CommUtils readUser].birth_date];
                NSString *nowStr = [CommUtils stringFromDate:[NSDate date]];
                
                if([birStr isEqualToString:nowStr] || !birStr){
                    cell.contentsLabel.text = @"0岁";
                }else{
                    cell.contentsLabel.text = [NSString stringWithFormat:@"%@岁",@([CommUtils getAgeAction:[NSDate date]] - [CommUtils getAgeAction:[CommUtils readUser].birth_date])];
                }
                break;
            }
            case 7:{
                cell.headLabel.text = @"学校";
                cell.detTextField.hidden = YES;
                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiJian"]];
                [cell hideSexView:YES];
                cell.contentsLabel.hidden = NO;
                
                NSMutableString *muStr;
                if ([CommUtils readUser].college) {
                    muStr = [NSMutableString stringWithString:[CommUtils readUser].college];
                }
                if (muStr.length != 0) {
                    cell.contentsLabel.text = [CommUtils readUser].college;
                }else{
                    cell.contentsLabel.text = @"未填写";
                }
                
                break;
            }
            case 8:{
                cell.headLabel.text = @"院系";
                cell.detTextField.hidden = YES;
                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiJian"]];
                [cell hideSexView:YES];
                cell.contentsLabel.hidden = NO;
                
                NSMutableString *muStr2 ;
                
                if ([CommUtils readUser].institute) {
                    muStr2 = [NSMutableString stringWithString:[CommUtils readUser].institute];
                }
                
                if (muStr2.length != 0){
                    cell.contentsLabel.text = [CommUtils readUser].institute;
                }else{
                    cell.contentsLabel.text = @"未填写";
                }
                break;
            }
            case 9:{
                cell.headLabel.text = @"入学";
                cell.detTextField.hidden = YES;
                [cell.backImageView setImage:[UIImage imageNamed:@"kongbaiJian"]];
                [cell hideSexView:YES];
                cell.contentsLabel.hidden = NO;
               
                NSMutableString *str ;
                
                if ([CommUtils readUser].college_enroll_time) {
                    str = [NSMutableString stringWithString:[CommUtils readUser].college_enroll_time];
                }
                
                if (str.length != 0) {
                    cell.contentsLabel.text = [NSString stringWithFormat:@"%@年",[CommUtils readUser].college_enroll_time];
                }else{
                    cell.contentsLabel.text = @"未填写";
                }
                
                break;
            }
            default:
                break;
        }
        
        return cell;
    }
}

-(void)btnAction1:(id)sender
{
    ProfileDetailCell *cell=(ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    TLog(@"cell%@",cell);
    cell.boyBtn.selected=YES;
    cell.girlBtn.selected=NO;
    
    UserModel *user = [CommUtils readUser];
    user.sex = 2;
    [CommUtils saveUserModel:user];
}

-(void)btnAction2:(id)sender
{
    ProfileDetailCell *cell=(ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.boyBtn.selected=NO;
    cell.girlBtn.selected=YES;
    
    UserModel *user = [CommUtils readUser];
    user.sex = 1;
    [CommUtils saveUserModel:user];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            [self ChangeBigImage];
            break;
        case 5:
            [_pickview show];
            break;
        case 7:{
            SchoolVC *schVC = [[SchoolVC alloc]init];
            schVC.hidesBottomBarWhenPushed = YES;
            schVC.delegate = self;
            [self.navigationController pushViewController:schVC animated:YES];
        }
            break;
        case 8:{
            
            NSMutableString *muStr;
            if ([CommUtils readUser].college) {
                [NSMutableString stringWithString:[CommUtils readUser].college];
            }
            if (muStr.length == 0) {
                [UIAlertView showWithTitle:@"温馨提示" message:@"请选择您的学校" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    return;
                }];
            }else{
                CollegeVC *colVC = [[CollegeVC alloc]init];
                colVC.hidesBottomBarWhenPushed = YES;
                colVC.delegate = self;
                [self.navigationController pushViewController:colVC animated:YES];

            }
        }
            break;
        case 9:{
            NSMutableString *muStr;
            if ([CommUtils readUser].college) {
                [NSMutableString stringWithString:[CommUtils readUser].college];
            }
            if (muStr.length == 0) {
                [UIAlertView showWithTitle:@"温馨提示" message:@"请选择您的学校" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    return;
                }];
            }else{
                [_pickview2 show];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    TLog(@"输出选择哪个zhpickview%@",pickView);
    TLog(@"输出选择哪个zhpickview%ld",(long)pickView.tag);
    
    if (pickView == _pickview) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        ProfileDetailCell * cell = (ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:indexPath];
        
        
        TLog(@"age === %ld", (long)[CommUtils getAgeAction:[CommUtils dateFromString:resultString]]);
        
        cell.contentsLabel.text = [NSString stringWithFormat:@"%@岁",@([CommUtils getAgeAction:[NSDate date]] - [CommUtils getAgeAction:[CommUtils dateFromString:resultString]])];
        
        UserModel * user = [CommUtils readUser];
        user.birth_date = [CommUtils dateFromString:resultString];
        [CommUtils saveUserModel:user];
    }else if (pickView == _pickview2){
        
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:9 inSection:0];
        ProfileDetailCell * cell2 = (ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:indexPath2];
        
        cell2.contentsLabel.text = [NSString stringWithFormat:@"%@年",resultString];
    
        UserModel *user = [CommUtils readUser];
        user.college_enroll_time = resultString;
        [CommUtils saveUserModel:user];
    }
}

#pragma mark - 
#pragma mark - UploadDelegate

-(void)ChangeBigImage
{
    TLog(@"换图像");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"相册",nil];
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=2) {
        UploadSingleImageViewController* upView=[[UploadSingleImageViewController alloc]init];
        upView.flag=buttonIndex;
        upView.delegate=self;
        [self.navigationController pushViewController:upView animated:YES];
    }
    
}
-(void)ReloadImageMessage:(UIImage*)aImage
{
    //__block PersonViewController *bself=self;
    TLog(@"%@",aImage);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    ProfileCell *newCell = (ProfileCell *)[self.proTbView cellForRowAtIndexPath:indexPath];
    newCell.headIamgeView.image = aImage;
    
    [self upLoadImage:aImage];
    
}

-(void)upLoadImage:(UIImage *)image
{
    AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc]init];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSData *iconData = UIImageJPEGRepresentation(image, 0.9);
    
    NSString *post_url = [NSString stringWithFormat:@"%@%@",PartyAPI,kPhoto];
    
    [httpManager POST:post_url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:[[CommUtils readUser].user_token dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"user_token"];
        [formData appendPartWithFileData:iconData name:@"userfile"
                                fileName:@"img.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TLog(@"open = %@, respon = %@", operation, responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
            UserModel *user = [CommUtils readUser];
            user.figure_url = [responseObject objectForKey:@"file_url"];
            [CommUtils saveUserModel:user];
            [SDWebImageManager.sharedManager.imageCache removeImageForKey:user.figure_url];
            TLog(@"figure_url = %@", user.figure_url);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TLog(@"open = %@, error = %@", operation, error);
    }];
}

-(void)schoolDetail:(NSString *)name
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
    ProfileDetailCell * cell = (ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:indexPath];
    cell.contentsLabel.text = name;
    
    [self.proTbView reloadData];
}

-(void)collegeDetail:(NSString *)name
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
    ProfileDetailCell * cell = (ProfileDetailCell *)[self.proTbView cellForRowAtIndexPath:indexPath];
    cell.contentsLabel.text = name;
}

@end
