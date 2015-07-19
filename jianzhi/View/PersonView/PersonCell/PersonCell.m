//
//  PersonCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/28.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headLabel.textColor = RGB(151, 167, 184);
    [self.headLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    
    [self setPersonCellFrame];
}

-(void)setPersonCellFrame
{
    self.headLabel.frame = CGRectMake(13 * VIEWWITH, 3 * VIEWWITH, 256 * VIEWWITH, 49 * VIEWWITH);
    self.bgViewImage.frame = CGRectMake(0, 0, 320 * VIEWWITH, 55 * VIEWWITH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
