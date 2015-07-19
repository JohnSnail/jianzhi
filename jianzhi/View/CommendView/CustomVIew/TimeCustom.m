//
//  TimeCustom.m
//  jianzhi
//
//  Created by li on 15/5/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "TimeCustom.h"

@implementation TimeCustom

-(IBAction)selectTimeMethod:(id)sender
{
    if (_selectTime) {
        _selectTime();
    }
}

-(IBAction)cancleTimeMethod:(id)sender
{
    if (_cancleTime) {
        _cancleTime();
    }
}
-(IBAction)timeSelectMethod:(id)sender
{
    UIButton *button=(UIButton *)sender;
    for (UIView * v in button.superview.subviews)
    {
        
        if ([v isKindOfClass:[UIButton class]])
        {
            if (v.tag==button.tag) {
                if (button.selected) {
                    button.selected=NO;
                    TLog(@"输出view%@",[ClassModel LMAppModel].muCustomTime);
                    [[ClassModel LMAppModel].muCustomTime removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                }else
                {
                    button.selected=YES;
                    [[ClassModel LMAppModel].muCustomTime setObject:[NSString stringWithFormat:@"%ld",(long)button.tag] forKey:[NSString stringWithFormat:@"%ld",(long)button.tag]];
                }
            }
        }
    }
}
-(void)showTimeArray:(NSInteger)index
{
    NSInteger i=index-100;
    NSInteger x=i/3;
    NSInteger y=i%3;
    TLog(@"输出显示的内容%ld,输出yyy==%ld",(long)x,(long)y);
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:[NSString stringWithFormat:@"%ld",x]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
