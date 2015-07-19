//
//  JoinerCell.m
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "JoinerCell.h"

@implementation JoinerCell

- (void)awakeFromNib {
    // Initialization code
    [self setjoinFrame];
}
-(void)setjoinFrame
{
    self.headerImage.frame=CGRectMake(8*VIEWWITH,9*VIEWWITH,50*VIEWWITH,50*VIEWWITH);
    self.sexImage.frame=CGRectMake(74*VIEWWITH,12*VIEWWITH,12*VIEWWITH,16*VIEWWITH);
    self.name.frame=CGRectMake(94*VIEWWITH,9*VIEWWITH,216*VIEWWITH,21*VIEWWITH);
    self.background.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,63*VIEWWITH);
    self.comment.frame=CGRectMake(74*VIEWWITH,38*VIEWWITH,230*VIEWWITH,21*VIEWWITH);
    self.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,67*VIEWWITH);
}
-(void)showDate:(ApplyUserModel*)model
{
    self.name.text=[NSString stringWithFormat:@"%@",model.nick_name];
    self.comment.text=[Manager convertNull:[NSString stringWithFormat:@"%@",model.college]];//[NSString stringWithFormat:@"%@",model.college];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.figure_url]] placeholderImage:nil];
    if ([[NSString stringWithFormat:@"%@",model.sex] intValue] == 2) {
        self.sexImage.image = [UIImage imageNamed:@"boy"];
    }else{
        self.sexImage.image = [UIImage imageNamed:@"girl"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
