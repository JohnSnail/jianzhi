//
//  MyRecordVC.m
//  jianzhi
//
//  Created by li on 15/6/17.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "MyRecordVC.h"

@interface MyRecordVC ()

@end

@implementation MyRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showViewMethod];
    [self getPersonCustom];
}
#pragma mark - 获取个人定制数据
-(void)getPersonCustom
{
    //__weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@user/info",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出个人定制内容%@",results);
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                
                
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

-(void)showViewMethod
{
    [self.scrollView addSubview:self.contentView];
    [self setMyRecordFrame];
    
    
}
-(void)setMyRecordFrame
{
    self.contentView.frame=CGRectMake(0*VIEWWITH, 0*VIEWWITH, 0*VIEWWITH, 0*VIEWWITH);
    self.headerImage.frame=CGRectMake(0*VIEWWITH, 0*VIEWWITH,320*VIEWWITH, 228*VIEWWITH);
    self.name.frame=CGRectMake(23*VIEWWITH, 290*VIEWWITH, 275*VIEWWITH, 21*VIEWWITH);
    self.age.frame=CGRectMake(118*VIEWWITH, 319*VIEWWITH, 85*VIEWWITH, 21*VIEWWITH);
    self.college.frame=CGRectMake(11*VIEWWITH, 345*VIEWWITH, 298*VIEWWITH, 21*VIEWWITH);
    self.phoneLable.frame=CGRectMake(30*VIEWWITH,402*VIEWWITH,85*VIEWWITH, 21*VIEWWITH);
    self.emailLable.frame=CGRectMake(30*VIEWWITH,450*VIEWWITH,85*VIEWWITH, 21*VIEWWITH);
    self.typeLable.frame=CGRectMake(30*VIEWWITH,496*VIEWWITH,85*VIEWWITH, 21*VIEWWITH);
    self.phone.frame=CGRectMake(160*VIEWWITH,402*VIEWWITH,120*VIEWWITH, 21*VIEWWITH);
    self.email.frame=CGRectMake(105*VIEWWITH,450*VIEWWITH,175*VIEWWITH, 21*VIEWWITH);
    self.type.frame=CGRectMake(105*VIEWWITH,496*VIEWWITH,175*VIEWWITH, 21*VIEWWITH);
    self.personLable.frame=CGRectMake(86*VIEWWITH,577*VIEWWITH, 148*VIEWWITH,21*VIEWWITH);
    self.introduce.frame=CGRectMake(30*VIEWWITH,618*VIEWWITH,268*VIEWWITH,83*VIEWWITH);
    self.workLable.frame=CGRectMake(86*VIEWWITH,720*VIEWWITH,148*VIEWWITH, 21*VIEWWITH);
    self.work.frame=CGRectMake(30*VIEWWITH, 749*VIEWWITH,268*VIEWWITH,83*VIEWWITH);
    self.lineImageOne.frame=CGRectMake(27*VIEWWITH, 431*VIEWWITH, 260*VIEWWITH,1);
    self.lineImageTwo.frame=CGRectMake(27*VIEWWITH,480*VIEWWITH, 260*VIEWWITH, 1);
    self.lineImageThree.frame=CGRectMake(27*VIEWWITH,529*VIEWWITH, 260*VIEWWITH, 1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取个人简历
/*
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
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
