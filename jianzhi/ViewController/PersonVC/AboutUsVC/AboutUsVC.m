//
//  AboutUsVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [CommUtils navTittle:@"关于我们"];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    self.contentView.userInteractionEnabled = NO;
    
    [self setAboutUsVCFrame];
    [self showViewMethod];
}

-(void)setAboutUsVCFrame
{
    self.AUScrollerVIew.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    
    self.contentView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);

    self.nameLabel.frame = CGRectMake(81 * VIEWWITH, 139 * VIEWWITH, 159 * VIEWWITH, 36 * VIEWWITH);
    self.logoImageView.frame = CGRectMake(107 * VIEWWITH, 24 * VIEWWITH, 107 * VIEWWITH, 107 * VIEWWITH);
    self.detailView.frame = CGRectMake(40 * VIEWWITH, 218 * VIEWWITH, 240 * VIEWWITH, 317 * VIEWWITH);
}

-(void)backMethod
{
    LM_POP;
}

-(void)showViewMethod
{
    self.AUScrollerVIew.contentSize=CGSizeMake(mainscreenwidth, mainscreenhight + 50);
    self.AUScrollerVIew.frame=CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    [self.AUScrollerVIew addSubview:self.contentView];
}

@end
