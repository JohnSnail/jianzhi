//
//  ResumeVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ResumeVC.h"
#import "ResumeCell.h"
#import "PhoneVC.h"
#import "TimeCustom.h"
#import "KGModal.h"
#import "RegViewController.h"

@interface ResumeVC ()
@property (nonatomic,strong) TimeCustom *timeCustom;
@end

@implementation ResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resTbView.separatorStyle = NO;
    self.navigationItem.titleView = [CommUtils navTittle:@"我的简历"];
    
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    self.contentField.delegate = self;
    self.contentField.contentSize = self.contentField.frame.size;
    
    self.navigationItem.rightBarButtonItem = [LMButton setNavright:@"完成" andcolor:RGB(255, 241, 241) andSelector:@selector(rightAction) andTarget:self];
    
    [self setResumeVCFrame];
    
    [self timeMethod];
    
    _areaCustomArr = [NSMutableArray array];
    _typeCustomArr = [NSMutableArray array];
    _timeDic = [NSDictionary dictionary];
    
    [self getPersonCustom];
}

-(void)showPersonArea:(NSArray*)area andType:(NSArray *)type andTime:(NSDictionary *)time
{
    //========类型=======
    if (area.count>0) {
        //========区域==========
        NSMutableString* areaCustomStr=[NSMutableString string];
        for(NSDictionary * dict in area) {
            
            [areaCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"name"]]];
            [self.areaCustomArr addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
        }
        
        UserModel *user = [CommUtils readUser];
        user.job_area_intention = areaCustomStr;
        [CommUtils saveUserModel:user];
    }else{
        UserModel *user = [CommUtils readUser];
        user.job_area_intention = @"";
        [CommUtils saveUserModel:user];
    }
    if (type.count>0) {
        NSMutableString* typeCustomStr=[NSMutableString string];
        for(NSDictionary * dict in type) {
            
            [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"title"]]];
            [self.typeCustomArr addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
        }
        TLog(@"输出类型%@",typeCustomStr);
        
        UserModel *user = [CommUtils readUser];
        user.job_type_intention = typeCustomStr;
        [CommUtils saveUserModel:user];
        
    }else{
        UserModel *user = [CommUtils readUser];
        user.job_type_intention = @"";
        [CommUtils saveUserModel:user];

    }
    if (time.count>0) {
        //========时间==========
        NSMutableString* strTime=[NSMutableString string];
        NSString *str = nil;
        str = [time JSONString];
        _timeString = [NSString stringWithString:str];
        for(id key in time) {
            NSLog(@"key :%@  value :%@", key, [time objectForKey:key]);
            NSString *strNum=[NSString stringWithFormat:@"%@",key];
            switch ([strNum intValue]) {
                case 1:
                    [strTime appendString:@"周一 "];
                    break;
                case 2:
                    [strTime appendString:@"周二 "];
                    break;
                case 3:
                    [strTime appendString:@"周三 "];
                    break;
                case 4:
                    [strTime appendString:@"周四 "];
                    break;
                case 5:
                    [strTime appendString:@"周五 "];
                    break;
                case 6:
                    [strTime appendString:@"周六 "];
                    break;
                case 7:
                    [strTime appendString:@"周天 "];
                    break;
                default:
                    break;
            }
        }
        TLog(@"输出区域%@",strTime);
        self.timeString=strTime;
        
        UserModel *user = [CommUtils readUser];
        user.spare_time = strTime;
        [CommUtils saveUserModel:user];
        
    }else{
        UserModel *user = [CommUtils readUser];
        user.spare_time = @"";
        [CommUtils saveUserModel:user];
    }
}

#pragma mark - 获取个人定制数据
-(void)getPersonCustom
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@user/info/setting",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出个人定制内容%@",results);
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                NSArray *arrArea=[results objectForKey:@"job_area_intention"];
                NSArray *arrType=[results objectForKey:@"job_type_intention"];
                NSDictionary *dicTime=[results objectForKey:@"spare_time"];
                [weakSelf showPersonArea:arrArea andType:arrType andTime:dicTime];
                
            }else
            {
                [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
        
        [weakSelf.resTbView reloadData];
    }];
}

-(void)rightAction
{
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"city_id":[ClassModel LMAppModel].city_id,@"mobile":[CommUtils readUser].mobile,@"email":[CommUtils readUser].email,@"job_area_intention":[Manager jsonStringWithArray:self.areaCustomArr],@"job_type_intention":[Manager jsonStringWithArray:self.typeCustomArr],@"spare_time":_timeString,@"intro":[CommUtils readUser].intro,@"work_experience":[CommUtils readUser].work_experience};
    
    TLog(@"输出请求内容%@",parameters);
    
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kUserSetting];
    TLog(@"输出请求内容%@",stringurl);
    
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"results: %@", results);
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
        
    }];
}

-(void)backMethod
{
    LM_POP;
}

-(void)setResumeVCFrame
{
    self.resTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    self.chooseViewBg.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    self.contentBg.frame = CGRectMake(10 * VIEWWITH, 55* VIEWWITH, 300* VIEWWITH, 300* VIEWWITH);
    self.titleLabel.frame = CGRectMake(28* VIEWWITH, 71* VIEWWITH, 252* VIEWWITH, 21* VIEWWITH);
    self.contentField.frame = CGRectMake(28* VIEWWITH, 100* VIEWWITH, 265* VIEWWITH, 172* VIEWWITH);
    self.defLabel.frame = CGRectMake(34* VIEWWITH, 107* VIEWWITH, 125* VIEWWITH, 21* VIEWWITH);
    self.quitBtn.frame = CGRectMake(30* VIEWWITH, 298* VIEWWITH, 109* VIEWWITH, 38* VIEWWITH);
    self.doneBtn.frame = CGRectMake(171* VIEWWITH, 298* VIEWWITH, 109* VIEWWITH, 38* VIEWWITH);
    self.sepImageView.frame = CGRectMake(154* VIEWWITH, 290* VIEWWITH, 1* VIEWWITH, 54* VIEWWITH);
}

#pragma mark - 
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55 * VIEWWITH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"ResumeCell";
    ResumeCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"ResumeCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.headLabel.text = @"手机";
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            TLog(@"mobile = %@",[CommUtils readUser].mobile);
            NSMutableString *muStr;
            if ([CommUtils readUser].mobile) {
                muStr = [NSMutableString stringWithString:[CommUtils readUser].mobile];
            }
            if (muStr.length != 0) {
                cell.detailLabel.text = [CommUtils readUser].mobile;
                cell.cellBg.image = [UIImage imageNamed:@"resCellBg"];
            }else{
                cell.detailLabel.text = @"未验证";
                cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            }
        }else if (indexPath.row == 1){
            cell.headLabel.text = @"邮箱";
            cell.emailField.placeholder = @"输入您的常用邮箱";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBg"];
            cell.detailLabel.hidden = YES;
            cell.emailField.hidden = NO;
            
            NSMutableString *muStr;
            if ([CommUtils readUser].email) {
                muStr = [NSMutableString stringWithString:[CommUtils readUser].email];
            }
            if (muStr.length != 0) {
                cell.emailField.text = [CommUtils readUser].email;
            }
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.headLabel.text = @"求职意向";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            if ([CommUtils readUser].job_type_intention) {
                cell.detailLabel.text = [CommUtils readUser].job_type_intention;
            }

        }else if(indexPath.row == 1){
            cell.headLabel.text = @"兼职地点";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            if ([CommUtils readUser].job_area_intention) {
                cell.detailLabel.text = [CommUtils readUser].job_area_intention;
            }

        }else if (indexPath.row == 2){
            cell.headLabel.text = @"空闲时间";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            if ([CommUtils readUser].spare_time) {
                cell.detailLabel.text = [CommUtils readUser].spare_time;
            }

        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.headLabel.text = @"自我介绍";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            if ([CommUtils readUser].intro) {
                cell.detailLabel.text = [CommUtils readUser].intro;
            }

        }else if(indexPath.row == 1){
            cell.headLabel.text = @"工作经验";
            cell.cellBg.image = [UIImage imageNamed:@"resCellBgTo"];
            cell.detailLabel.hidden = NO;
            cell.emailField.hidden = YES;
            
            if ([CommUtils readUser].work_experience) {
                cell.detailLabel.text = [CommUtils readUser].work_experience;
            }
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            NSMutableString *muStr;
            if ([CommUtils readUser].mobile) {
                muStr = [NSMutableString stringWithString:[CommUtils readUser].mobile];
            }
            if (muStr.length != 0){
                return;
            }else{
                RegViewController *regVC = [[RegViewController alloc]init];
                regVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:regVC animated:YES];
            }
        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            [self typeMethod];
        }else if(indexPath.row == 1){
            [self placeMethod];
        }else if(indexPath.row == 2){
            [[KGModal sharedInstance] showWithContentView:_timeCustom andAnimated:YES];
        }
        
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            [self showViewTitle:@"自我介绍" andContent:@"请输入您的自我介绍"];
        }else if(indexPath.row == 1){
            [self showViewTitle:@"工作经验" andContent:@"请输入您的工作经验"];
        }
    }
}

#pragma mark - 定制时间
-(void)timeMethod
{
    if (_timeCustom==nil) {
        _timeCustom = [[[NSBundle mainBundle]loadNibNamed:@"TimeCustom" owner:self options:nil] objectAtIndex:0];
        [ClassModel LMAppModel].muCustomTime=[[NSMutableDictionary alloc] init];
    }
    __weak typeof(self) weakSelf = self;
    [_timeCustom setSelectTime:^(){
        [weakSelf sureAndCancle];
    }];
    [_timeCustom setCancleTime:^(){
        [weakSelf sureAndCancle];
    }];
}

-(void)sureAndCancle
{
    
    TLog(@"选择的时间%@",[ClassModel LMAppModel].muCustomTime);
    NSMutableDictionary *dictNumber=[[NSMutableDictionary alloc] init];
    dictNumber=[LocolData timeSendToserver:[ClassModel LMAppModel].muCustomTime];
    TLog(@"输出最终字典%@",dictNumber);
    
    self.timeDic = dictNumber;
    
    NSString *str = nil;
    str = [dictNumber JSONString];
    _timeString = [NSString stringWithString:str];
    NSMutableString* strTime=[NSMutableString string];
    for(id key in dictNumber) {
        NSLog(@"key :%@  value :%@", key, [dictNumber objectForKey:key]);
        NSString *strNum=[NSString stringWithFormat:@"%@",key];
        switch ([strNum intValue]) {
            case 1:
                [strTime appendString:@"周一 "];
                break;
            case 2:
                [strTime appendString:@"周二 "];
                break;
            case 3:
                [strTime appendString:@"周三 "];
                break;
            case 4:
                [strTime appendString:@"周四 "];
                break;
            case 5:
                [strTime appendString:@"周五 "];
                break;
            case 6:
                [strTime appendString:@"周六 "];
                break;
            case 7:
                [strTime appendString:@"周天 "];
                break;
            default:
                break;
        }
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:1];
    ResumeCell * newCell = (ResumeCell *)[self.resTbView cellForRowAtIndexPath:indexPath];
    newCell.detailLabel.text = strTime;
    
    [[KGModal sharedInstance] hide];
    
    UserModel *user = [CommUtils readUser];
    user.spare_time = strTime;
    [CommUtils saveUserModel:user];
}


-(void)showViewTitle:(NSString *)title andContent:(NSString *)content
{
    self.titleLabel.text = title;
    self.defLabel.text = content;
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentField becomeFirstResponder];
        [self.view addSubview:self.chooseView];
        
        if ([self.titleLabel.text isEqualToString:@"自我介绍"]) {
            self.contentField.text = [CommUtils readUser].intro;
        }else if([self.titleLabel.text isEqualToString:@"工作经验"]){
            self.contentField.text = [CommUtils readUser].work_experience;
        }
        
    }];
    
    self.chooseView.backgroundColor = [UIColor clearColor];
}



-(void)dissmissView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.chooseView removeFromSuperview];
        
        if ([self.titleLabel.text isEqualToString:@"自我介绍"]) {
            
            TLog(@"introStr == %@", self.contentField.text);
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
            ResumeCell *newCell = (ResumeCell *)[self.resTbView cellForRowAtIndexPath:indexPath];
            newCell.detailLabel.text = self.contentField.text;
            
            UserModel *user = [CommUtils readUser];
            user.intro = self.contentField.text;
            [CommUtils saveUserModel:user];
            
        }else if ([self.titleLabel.text isEqualToString:@"工作经验"]){
            
            TLog(@"expStr == %@", self.contentField.text);
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
            ResumeCell *newCell = (ResumeCell *)[self.resTbView cellForRowAtIndexPath:indexPath];
            newCell.detailLabel.text = self.contentField.text;
            
            UserModel *user = [CommUtils readUser];
            user.work_experience = self.contentField.text;
            [CommUtils saveUserModel:user];
        }
        
    }];
}

- (IBAction)quitAction:(UIButton *)sender {
    
    [self dissmissView];
}

- (IBAction)doneAction:(UIButton *)sender {
    [self dissmissView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![text isEqualToString:@""]){
        self.defLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        self.defLabel.hidden = NO;
    }else if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 兼职类型
-(void)typeMethod
{
    TypeCustomVC *vc=LM_CREATE_OBJECT(TypeCustomVC);
    vc.delegate=self;
    LM_PUSH;
}
-(void)selectTypeCustom:(NSMutableDictionary *)dict
{
    [self.typeCustomArr removeAllObjects];
    
    NSMutableArray* typeCustomArr=[NSMutableArray array];
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [self.typeCustomArr addObject:key];
    }
    
    TLog(@"typeDicStr = %@", [Manager jsonStringWithArray:typeCustomArr]);
    
    NSMutableString* typeCustomStr=[NSMutableString string];
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:key]]];
    }
    TLog(@"输出选择的兼职%@",typeCustomStr);

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    ResumeCell * newCell = (ResumeCell *)[self.resTbView cellForRowAtIndexPath:indexPath];
    newCell.detailLabel.text = typeCustomStr;
    
    UserModel *user = [CommUtils readUser];
    user.job_type_intention = typeCustomStr;
    [CommUtils saveUserModel:user];
}
#pragma mark - 兼职区域
-(void)placeMethod
{
    PlaceCustomVC *vc=LM_CREATE_OBJECT(PlaceCustomVC);
    vc.delegate=self;
    LM_PUSH;
}
-(void)selectAreaMetohd:(NSMutableDictionary *)dict
{
    [self.areaCustomArr removeAllObjects];
    
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [self.areaCustomArr addObject:key];
    }
    
    NSMutableString* typeCustomStr=[NSMutableString string];
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:key]]];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:1];
    ResumeCell * newCell = (ResumeCell *)[self.resTbView cellForRowAtIndexPath:indexPath];
    newCell.detailLabel.text = typeCustomStr;
    
    UserModel *user = [CommUtils readUser];
    user.job_area_intention = typeCustomStr;
    [CommUtils saveUserModel:user];
}

@end
