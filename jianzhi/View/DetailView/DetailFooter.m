//
//  DetailFooter.m
//  jianzhi
//
//  Created by li on 15/6/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "DetailFooter.h"

@implementation DetailFooter
-(void)setDetailFrame
{
    self.collectBt.frame=CGRectMake(13*VIEWWITH,8, 96*VIEWWITH, 43);
    self.suggestBt.frame=CGRectMake(110*VIEWWITH,8, 96*VIEWWITH, 43);
    self.applyBt.frame=CGRectMake(207*VIEWWITH,8, 96*VIEWWITH, 43);
//    self.frame=CGRectMake(0, 200, mainscreenwidth, 50);
}
#pragma mark - 投诉
-(IBAction)seggestMethod:(id)sender
{
    if (_suggestMethod) {
        _suggestMethod();
    }
}
#pragma mark - 收藏职位
-(IBAction)collectJob:(id)sender
{
    if (_collectMethod) {
        _collectMethod();
    }
}
#pragma mark - 报名
-(IBAction)joinMethod:(id)sender
{
    if (_applyMethod) {
        _applyMethod();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
