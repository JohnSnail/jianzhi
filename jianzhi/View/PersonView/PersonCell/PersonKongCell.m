//
//  PersonKongCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/28.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "PersonKongCell.h"

@implementation PersonKongCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setPersonKongCellFrame];
}

-(void)setPersonKongCellFrame
{
    self.bgImageView.frame = CGRectMake(0, 0, 320 * VIEWWITH, 41 * VIEWWITH);
}

@end
