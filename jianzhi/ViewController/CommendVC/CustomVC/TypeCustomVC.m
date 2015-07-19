//
//  TypeCustomVC.m
//  jianzhi
//
//  Created by li on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "TypeCustomVC.h"
#import "PlaceCustomVC.h"
@interface TypeCustomVC ()

@end

@implementation TypeCustomVC

-(NSMutableDictionary *)mutableDict
{
    if (!_mutableDict) {
        _mutableDict=[[NSMutableDictionary alloc] init];
    }
    return _mutableDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommUtils navTittle:@"选择兼职类型"];
    [self showViewMethod];
    self.navigationItem.rightBarButtonItem=[LMButton setNavright:@"确定" andcolor:RGB(255, 255, 255) andSelector:@selector(sendType) andTarget:self];
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
    [self setTypeFrame];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle600"]];
    self.contentView.frame=CGRectMake(0*VIEWWITH, 0*VIEWWITH, 320*VIEWWITH, 710*VIEWWITH);
    self.scrollView.frame=CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    self.view.frame=CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    [self.scrollView addSubview:self.contentView];
    //self.scrollView.bounces=NO;
    self.contentView.frame=CGRectMake(0, -64, mainscreenwidth, mainscreenhight);
    self.scrollView.contentSize=CGSizeMake(mainscreenwidth, self.contentView.frame.size.height+50);
}
-(void)setTypeFrame
{
    self.backImage.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,710*VIEWWITH);
    self.kefuBt.frame=CGRectMake(30*VIEWWITH,86*VIEWWITH,57,85);
    self.yanchuBt.frame=CGRectMake(130*VIEWWITH,86*VIEWWITH,57,85);
    self.jiajiaoBt.frame=CGRectMake(230*VIEWWITH,86*VIEWWITH,57,85);
    self.moteBt.frame=CGRectMake(30*VIEWWITH,183*VIEWWITH,57,85);
    self.paidanBt.frame=CGRectMake(130*VIEWWITH,183*VIEWWITH,57,85);
    self.shejiBt.frame=CGRectMake(30*VIEWWITH,280*VIEWWITH,57,85);
    self.xiaoneiBt.frame=CGRectMake(130*VIEWWITH,280*VIEWWITH,57,85);
    self.linshiBt.frame=CGRectMake(230*VIEWWITH,280*VIEWWITH,57,85);
    self.fuwuBt.frame=CGRectMake(30*VIEWWITH,377*VIEWWITH,57,85);
    self.xiaoshouBt.frame=CGRectMake(130*VIEWWITH,377*VIEWWITH,57,85);
    self.anbaoBt.frame=CGRectMake(230*VIEWWITH,377*VIEWWITH,57,85);
    self.liyiBt.frame=CGRectMake(30*VIEWWITH,474*VIEWWITH,57,85);
    self.cuxiaoBt.frame=CGRectMake(130*VIEWWITH,474*VIEWWITH,57,85);
    self.fanyiBt.frame=CGRectMake(230*VIEWWITH,474*VIEWWITH,57,85);
    self.otherBt.frame=CGRectMake(30*VIEWWITH,571*VIEWWITH,57,85);
    self.wenyuanBt.frame=CGRectMake(230*VIEWWITH,183*VIEWWITH,57,85);
}
#pragma mark - 提交兼职类型
-(void)sendType
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
    [self.delegate selectTypeCustom:self.mutableDict];
}

-(IBAction)timeSelectMethod:(id)sender
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
                    [_mutableDict removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                }else
                {
                    button.selected=YES;
                    [_mutableDict setObject:button.titleLabel.text forKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                    
                }
            }
        }
    }
    TLog(@"输出选择的兼职%@",_mutableDict);
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
