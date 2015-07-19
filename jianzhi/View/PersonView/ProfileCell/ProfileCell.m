//
//  ProfileCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.headLabel.textColor = RGB(151, 167, 184);
    self.headIamgeView.image = [UIImage imageNamed:@"180"];
    [self setProfileCellFrame];
}

-(void)setProfileCellFrame
{
    self.bgImageView.frame = CGRectMake(0, 0, 320*VIEWWITH, 70*VIEWWITH);
    self.headIamgeView.frame = CGRectMake(241*VIEWWITH, 8 * VIEWWITH, 54*VIEWWITH, 54*VIEWWITH);
    self.headLabel.frame = CGRectMake(20*VIEWWITH, 8*VIEWWITH, 191*VIEWWITH, 54*VIEWWITH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
