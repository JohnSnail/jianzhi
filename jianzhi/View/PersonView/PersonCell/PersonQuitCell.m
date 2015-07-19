//
//  PersonQuitCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/28.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PersonQuitCell.h"

@implementation PersonQuitCell

- (void)awakeFromNib {
    // Initialization code
    
//    [self.QuitBtn setTitleColor:RGB(151, 167, 184) forState:UIControlStateNormal];
    self.QuitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self setPersonQuitCellFrame];
}

-(void)setPersonQuitCellFrame
{
    self.QuitBtn.frame = CGRectMake(10 * VIEWWITH, 50*VIEWWITH, 300 * VIEWWITH, 50 * VIEWWITH);
    self.frame=CGRectMake(0, 0*VIEWWITH, 320 * VIEWWITH, 177 * VIEWWITH);
}

@end
