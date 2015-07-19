//
//  CustomVC.m
//  jianzhi
//
//  Created by li on 15/5/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CustomVC.h"
#import "TimeCustom.h"
#import "KGModal.h"
@interface CustomVC ()
@property (nonatomic,strong) TimeCustom *timeCustom;
@end

@implementation CustomVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommUtils navTittle:@"个人定制"];
    [self getPersonCustom];
    [self showViewMethod];
    [self timeMethod];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    self.navigationItem.rightBarButtonItem=[LocolData setCustomTitle:@"完成" Action:@selector(sendDateServer) Target:self];
    _timeCompare=@"";
    _typeCompare=@"";
    _areaCompare=@"";
    _timeString=@"";
}
#pragma mark- 返回
-(void)backMethod
{
    if (![_timeCompare isEqualToString:_timeLable.text]) {
        [self someThingChange];
        return;
    }else if (![_typeCompare isEqualToString:_typeLable.text]){
        [self someThingChange];
        return;
    }else if (![_areaCompare isEqualToString:_placeLable.text])
    {
        [self someThingChange];
        return;
    }
    LM_POP;
}
-(void)someThingChange
{
    //[Manager textNoSpace:@"修改了东西"];
    [UIAlertView showWithTitle:@"温馨提示" message:@"您修改了条件,需要保存吗" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"确定"]) {
            NSLog(@"退出");
            [self sendDataToServer];
        }else
        {
            LM_POP;
        }
    }];
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
    }];
}
#pragma mark - 提交个人定制数据
-(void)sendDateServer
{
    [self sendDataToServer];
}
#pragma mark - 提交私人定制数据
-(void)sendDataToServer
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"city_id":[ClassModel LMAppModel].city_id,@"job_area_intention":[Manager jsonStringWithArray:_areaArray],@"job_type_intention":[Manager jsonStringWithArray:_typeArray],@"spare_time":_timeString,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@user/setting",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
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
#pragma mark - 加载基础视图
-(void)showViewMethod
{
    [self.scrollview addSubview:self.contentView];
    //self.scrollview.bounces=NO;
    self.contentView.frame=CGRectMake(0, -64, mainscreenwidth, mainscreenhight);
    self.scrollview.contentSize=CGSizeMake(mainscreenwidth, self.contentView.frame.size.height);
}
-(void)showPersonArea:(NSArray*)area andType:(NSArray *)type andTime:(NSDictionary *)time
{
    //========类型=======
    if (area.count>0) {
        //========区域==========
        NSMutableString* areaCustomStr=[NSMutableString string];
        NSMutableArray *areaMutable=[[NSMutableArray alloc] init];
        for(NSDictionary * dict in area) {
            
            [areaCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"name"]]];
            [areaMutable addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
        }
        _areaArray=areaMutable;
        TLog(@"输出区域%@",areaCustomStr);
        _areaCompare=areaCustomStr;
        _placeLable.text=areaCustomStr;
    }
    if (type.count>0) {
        NSMutableString* typeCustomStr=[NSMutableString string];
        NSMutableArray *typeMutable=[[NSMutableArray alloc] init];
        for(NSDictionary * dict in type) {
            
            [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"title"]]];
            [typeMutable addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
        }
        _typeArray=typeMutable;
        TLog(@"输出类型%@",typeCustomStr);
        _typeCompare=typeCustomStr;
        _typeLable.text=typeCustomStr;
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
        _timeLable.text=strTime;
        _timeCompare=strTime;
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
    _timeLable.text=strTime;
    NSLog(@"keys :%@", _timeLable.text);
    [[KGModal sharedInstance] hide];
}
#pragma mark - 兼职时间
-(IBAction)timeMethod:(id)sender
{
    [[KGModal sharedInstance] showWithContentView:_timeCustom andAnimated:YES];
}
#pragma mark - 兼职类型
-(IBAction)typeMethod:(id)sender
{
    TypeCustomVC *vc=LM_CREATE_OBJECT(TypeCustomVC);
    vc.delegate=self;
    LM_PUSH;
}
-(void)selectTypeCustom:(NSMutableDictionary *)dict
{
    NSMutableString* typeCustomStr=[NSMutableString string];
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:key]]];
    }
    TLog(@"输出选择的兼职%@",typeCustomStr);
    self.typeLable.text=typeCustomStr;
    _typeArray=[dict allKeys];
    TLog(@"输出选择的兼职地点%@",_typeArray);
}
#pragma mark - 兼职区域
-(IBAction)placeMethod:(id)sender
{
    PlaceCustomVC *vc=LM_CREATE_OBJECT(PlaceCustomVC);
    vc.delegate=self;
    LM_PUSH;
}
-(void)selectAreaMetohd:(NSMutableDictionary *)dict
{
    NSMutableString* typeCustomStr=[NSMutableString string];
    for(id key in dict) {
        NSLog(@"key :%@  value :%@", key, [dict objectForKey:key]);
        [typeCustomStr appendString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:key]]];
    }
    TLog(@"输出选择的兼职%@",typeCustomStr);
    self.placeLable.text=typeCustomStr;
    _areaArray=[dict allKeys];
    TLog(@"输出选择的兼职地点%@",_areaArray);
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
