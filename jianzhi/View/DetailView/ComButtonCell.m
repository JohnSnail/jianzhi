//
//  ComButtonCell.m
//  jianzhi
//
//  Created by li on 15/5/16.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ComButtonCell.h"

@implementation ComButtonCell

- (void)awakeFromNib {
    [self setComButtonFrame];
}
-(void)setComButtonFrame
{
    self.moreButton.frame=CGRectMake(28*VIEWWITH,11*VIEWWITH,265*VIEWWITH,43*VIEWWITH);
    self.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,316*VIEWWITH);
}
-(IBAction)discussButton:(id)sender
{
    if (_discussMethod) {
        _discussMethod();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
