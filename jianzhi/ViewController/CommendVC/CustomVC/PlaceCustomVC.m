//
//  PlaceCustomVC.m
//  jianzhi
//
//  Created by li on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PlaceCustomVC.h"

@interface PlaceCustomVC ()

@end

@implementation PlaceCustomVC
-(NSMutableDictionary *)mutableDict
{
    if (!_mutableDict) {
        _mutableDict=[[NSMutableDictionary alloc] init];
    }
    return _mutableDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCity];
    self.navigationItem.titleView=[CommUtils navTittle:@"选择兼职区域"];
    [self showViewMethod];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}
#pragma mark- 返回
-(void)backMethod
{
    LM_POP;
}
#pragma mark - 显示视图
-(void)showViewMethod
{
    [self mutableDict];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle600"]];
    self.navigationItem.rightBarButtonItem=[LMButton setNavright:@"确定" andcolor:RGB(255, 255, 255) andSelector:@selector(sendArea) andTarget:self];
    [self.scrollView addSubview:self.contentView];
    //self.scrollView.bounces=NO;
    self.contentView.frame=CGRectMake(0, -64, mainscreenwidth, mainscreenhight);
    self.scrollView.contentSize=CGSizeMake(mainscreenwidth, self.contentView.frame.size.height);
}
#pragma mark - 获取城市
-(void)getCity
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@city/area",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        TLog(@"输出区域%@",results);
        if (results) {
            if ((NSNull *)results != [NSNull null])
            {
                if ([[results objectForKey:@"code"] intValue]==0) {
                    NSArray *array=[results objectForKey:@"area"];
                    [weakSelf showAreaView:array];
                }else
                {
                    [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
                }
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}
#pragma mark - 显示城市区域
-(void)showAreaView:(NSArray *)array;
{
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict=[array objectAtIndex:i];
        TLog(@"输出地址字典%@",dict);
        int x=i%3;
        int y=i/3;
        TLog(@"输出x坐标%d y坐标%d",x,y);
        [self areaButton:CGRectMake((30+x*100)*VIEWWITH, (85+y*75)*VIEWWITH, 58, 58) andTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]] andTag:[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue]];
    }
}
-(UIButton *)areaButton:(CGRect)rect andTitle:(NSString *)title andTag:(NSInteger)tag
{
    UIButton *button=[LMButton lmTitleBt:rect andTarget:self andtag:tag andimage:@"AreaImageUn" andTitle:title andaction:@selector(clickButton:)];
    [button setBackgroundImage:[UIImage imageNamed:@"AreaImageSe"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:button];
    return button;
}
-(void)clickButton:(id)sender
{
    UIButton *button=(UIButton *)sender;
    for (UIView * v in button.superview.subviews)
    {
        TLog(@"输出view%@",v);
        if ([v isKindOfClass:[UIButton class]])
        {
            if (v.tag==button.tag) {
                if (button.selected) {
                    button.selected=NO;
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_mutableDict removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                }else
                {
                    button.selected=YES;
                    [button setTitleColor:LMButtonColor forState:UIControlStateNormal];
                    [_mutableDict setObject:button.titleLabel.text forKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                    
                }
            }
        }
    }
    TLog(@"输出选择的兼职%@",_mutableDict);
}
#pragma mark - 提交城市区域

-(void)sendArea
{
    for(id key in self.mutableDict) {
        NSLog(@"key :%@  value :%@", key, [self.mutableDict objectForKey:key]);
    }
    NSArray *keys = [self.mutableDict allKeys];
    NSLog(@"keys :%@", keys);
    //所有值集合
    NSArray *values = [self.mutableDict allValues];
    NSLog(@"values :%@", values);
    LM_POP;
    [self.delegate selectAreaMetohd:self.mutableDict];
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
