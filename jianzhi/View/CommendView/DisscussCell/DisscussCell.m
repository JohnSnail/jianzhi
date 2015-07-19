//
//  DisscussCell.m
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "DisscussCell.h"

@implementation DisscussCell

- (void)awakeFromNib {
    
}
-(void)setDiscussFrame
{
    self.headerImage.frame=CGRectMake(20*VIEWWITH,11*VIEWWITH,50*VIEWWITH,50*VIEWWITH);
    self.name.frame=CGRectMake(74*VIEWWITH,9*VIEWWITH,216*VIEWWITH,21*VIEWWITH);
}
-(void)showData:(CommentModel *)model
{
    for (UIView *view in self.titleView.subviews) {
        [view removeFromSuperview];
    }
    self.name.text=[NSString stringWithFormat:@"%@",model.nick_name];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.figure_url]] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
