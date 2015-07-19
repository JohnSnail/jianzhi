//
//  DetailVC.m
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "DetailVC.h"
#import "DetailCell.h"
#import "ConnectCell.h"
#import "CommentCell.h"
#import "DisscussVC.h"
#import "ComButtonCell.h"
#import "MapViewController.h"
#import "SuggestVC.h"
#import "LoginVC.h"
#import "JoinerVC.h"
#import "DetailFooter.h"
#import "FeedbackVC.h"
@interface DetailVC ()
{
}
@property (nonatomic,strong) DetailFooter *detailFooter;
@end

@implementation DetailVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nevBar"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
//    self.navigationController.navigationBar.translucent=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController cancelSGProgress];
}
-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray=[[NSMutableArray alloc] init];
    }
    return _mutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LMNOTMAINSCREEN;
    [self showViewMethod];
    [self.navigationController showSGProgress];
    self.commendTable.separatorStyle = NO;
    self.navigationItem.titleView = [CommUtils navTittle:@"兼职详情"];
    [self getNetworkData];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}

-(void)backMethod
{
    LM_POP;
}

#pragma mark - 加载数据
-(void)getNetworkData
{
    //@"user_token":[CommUtils getUserKey],
    NSDictionary *parameters=nil;
    if ([Manager isBlankString:[CommUtils getUserKey]]) {
        parameters = @{@"device_token":[CommUtils getMobileKey],@"job_id":_jobId,@"version":@"1.0"};
        TLog(@"输出请求内容%@",parameters);
    }else
    {
        parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion]};
        TLog(@"输出请求内容%@",parameters);
    }
    __weak typeof(self) weakSelf = self;
    
    NSString *stringurl=[NSString stringWithFormat:@"%@job/detail",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                [weakSelf.navigationController setSGProgressMaskWithPercentage:100];
                NSDictionary *dictJob=[results objectForKey:@"job"];
                weakSelf.model=[Manager dataAnalysisDictionary:@"JobDetailModel" andDictionry:dictJob];
                NSArray *uers=[results objectForKey:@"apply_users"];
                NSMutableArray *userMutable=[Manager dataAnalysisArray:@"ApplyUserModel" andArray:uers];
                weakSelf.UersArray=userMutable;
                NSArray *comments=[results objectForKey:@"comments"];
                NSMutableArray *commentMutable=[Manager dataAnalysisArray:@"CommentModel" andArray:comments];
                weakSelf.Comments=commentMutable;
                if([[NSString stringWithFormat:@"%@",_model.is_user_save] intValue]==1){
                    [_detailFooter.collectBt setTitle:@"已收藏" forState:UIControlStateNormal];
                }
                if([[NSString stringWithFormat:@"%@",_model.is_user_apply] intValue]==1){
                    [_detailFooter.applyBt setTitle:@"已报名" forState:UIControlStateNormal];
                }
                
            }else
            {
                [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
        [weakSelf.commendTable.footer endRefreshing];
        [weakSelf.commendTable.header endRefreshing];
        [weakSelf.commendTable reloadData];
        
    }];
}


#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *notice=@"DetailCell";
        DetailCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        __weak id bSelf = self;
        [cell setMapViewShow:^{
            [bSelf showMapVC];
        }];
//        JobDetailModel *model=[self.mutableArray objectAtIndex:indexPath.section];
        [cell showData:_model];
        return cell;
    }else if (indexPath.row==1){
        static NSString *notice=@"ConnectCell";
        ConnectCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"ConnectCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        __weak id bSelf = self;
        [cell setUsersShow:^{//显示小伙伴列表
            [bSelf showUersMethod];
        }];
        [cell showData:self.UersArray andModel:_model];
        return cell;
    }else if (indexPath.row==2){
        static NSString *notice=@"CommentCell";
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        __weak id bSelf = self;
        [cell setDisMoreShow:^{
            [bSelf disscussMethod];
        }];
        [cell showData:self.Comments andModel:_model];
        return cell;
    }
    else if (indexPath.row==3){
        static NSString *notice=@"ComButtonCell";
        ComButtonCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"ComButtonCell" owner:self options:nil] lastObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        __weak id bSelf = self;
        [cell setDiscussMethod:^{
            [bSelf disscussMethod];
        }];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 评论

-(void)disscussMethod
{
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    DisscussVC *vc=LM_CREATE_OBJECT(DisscussVC);
    vc.jobId=_jobId;
    LM_PUSH;
}

#pragma makr- 显示底部按钮
-(void)showViewMethod
{
    if (_detailFooter==nil) {
        _detailFooter = [[[NSBundle mainBundle]loadNibNamed:@"DetailFooter" owner:self options:nil] objectAtIndex:0];
    }
    __weak typeof(self) weakSelf = self;
    [_detailFooter setCollectMethod:^(){
        [weakSelf collectJob];
    }];
    [_detailFooter setSuggestMethod:^(){
        [weakSelf suggestMethod];
    }];
    [_detailFooter setApplyMethod:^(){
        [weakSelf joinMethod];
    }];
    _detailFooter.frame=CGRectMake(0, mainscreenhight-120, 420*VIEWWITH, 500);
    //_detailFooter.backgroundColor=[UIColor redColor];
    [_detailFooter setDetailFrame];
    [self.view addSubview:_detailFooter];
    
}
//=====报名
#pragma mark - 报名
-(void)joinMethod
{
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    [UIActionSheet showInView:self.view withTitle:@"提示" cancelButtonTitle:@"取消" destructiveButtonTitle:@"打电话" otherButtonTitles:@[@"发短信"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        NSLog(@"Chose %@", [actionSheet buttonTitleAtIndex:buttonIndex]);
        //[self sendName:@"1" andEmail:@""];
        if (buttonIndex==0) {
            NSString *phoneNumber=[NSString stringWithFormat:@"%@",_model.mobile];
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            [self sendName:@"1" andEmail:@""];
        }else if (buttonIndex==1){
            //[self whriteEmali];
            [self showMessageView];
            [self sendName:@"2" andEmail:@""];
        }else if(buttonIndex==2){
            //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13341139782"]];//发短信
//            [self showMessageView];
//            [self sendName:@"2" andEmail:@""];
        }else
        {
            
        }
        
        }];
}
#pragma mark- 发送短信
- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",_model.mobile]];
        controller.body =[NSString stringWithFormat:@"你好,我是%@;通过“同学兼职”看到你们的兼职 %@;相信我可以胜任,谢谢",[CommUtils readUser].nick_name,_model.title];
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"求职"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            //[self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            //[self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            //[self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}
#pragma mark - 输出邮箱
-(void)whriteEmali
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的邮箱" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alert textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeEmailAddress;
    [alert show];
}
- (void) alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1 )
    {
        NSString *email=[theAlertView textFieldAtIndex:0].text;
        if ([Manager isValidateEmail:email]) {
            [self sendName:@"1" andEmail:email];
        }else
        {
            [Manager textNoSpace:@"请输入正确地邮箱"];
        }
        
    }
    
}
//=====投诉
#pragma mark - 投诉
-(void)suggestMethod
{
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    FeedbackVC *fedVC = [[FeedbackVC alloc]init];
    fedVC.navigationItem.titleView = [CommUtils navTittle:@"投诉"];
    [self.navigationController pushViewController:fedVC animated:YES];
//    SuggestVC *vc=LM_CREATE_OBJECT(SuggestVC);
//    vc.jobId=_jobId;
//    LM_PUSH;
}
#pragma mark - 报名
-(void)sendName:(NSString *)type andEmail:(NSString *)email
{
    //__weak typeof(self) weakSelf = self;
    
    if([[NSString stringWithFormat:@"%@",_model.is_user_apply] intValue]==1){
        return;
    }
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":@"1.0",@"type":type,@"email":email,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@apply/job",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                if([type intValue]!=1)
                {
                    //[Manager textNoSpace:@"报名成功,等待发布者联系你"];
                }
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
#pragma mark - 收藏职位
-(void)collectJob
{
    if (![CommUtils is_onLine]) {
        LoginVC *loginViewController = [[LoginVC alloc]init];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        return;
    }
    //__weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@save/job",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                [Manager textNoSpace:@"收藏成功"];
                    
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

#pragma mark 显示百度地图
-(void)showMapVC
{
    MapViewController *vc = [[MapViewController alloc] init];
    vc.mapType = RegionNavi;
    TLog(@"输出需要显示的内容%@",_model.lat);
    TLog(@"输出需要显示的内容%@",_model.lng);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_model.work_address,@"address",@"北京市",@"city",@"google",@"from_map_type",_model.lng,@"google_lat",_model.lat,@"google_lng",_model.title,@"region", nil];
    vc.navDic = dic;
    
    LM_PUSH;
}
#pragma mark - 显示小伙伴列表
-(void)showUersMethod
{
    JoinerVC *vc=LM_CREATE_OBJECT(JoinerVC);
    vc.jobId=_jobId;
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
