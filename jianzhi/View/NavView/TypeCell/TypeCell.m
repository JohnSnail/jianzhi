//
//  TypeCell.m
//  jianzhi
//
//  Created by li on 15/5/16.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "TypeCell.h"

@implementation TypeCell

- (void)awakeFromNib {
    // Initialization code
    [self setTypeFrame];
}
-(void)setTypeFrame
{
    self.nameLable.frame=CGRectMake(21*VIEWWITH, 12*VIEWWITH, 146*VIEWWITH, 21*VIEWWITH);
    self.headerImage.frame=CGRectMake(271*VIEWWITH, 11*VIEWWITH, 21*VIEWWITH, 23*VIEWWITH);
    self.backImage.frame=CGRectMake(0*VIEWWITH, 0*VIEWWITH, 320*VIEWWITH, 43*VIEWWITH);
    self.frame=CGRectMake(0, 0, mainscreenwidth, 43*VIEWWITH);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
