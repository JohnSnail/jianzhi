//
//  CommendCell.m
//  jianzhi
//
//  Created by li on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CommendCell.h"

@implementation CommendCell

- (void)awakeFromNib {
    // Initialization code
    [self setCommendFrame];
}
-(void)setCommendFrame
{
    self.backImage.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,72*VIEWWITH);
    self.headerImage.frame=CGRectMake(14*VIEWWITH,12*VIEWWITH,50*VIEWWITH,50*VIEWWITH);
    self.name.frame=CGRectMake(90*VIEWWITH,11*VIEWWITH,157*VIEWWITH,21*VIEWWITH);
    self.place.frame=CGRectMake(90*VIEWWITH,42*VIEWWITH,132*VIEWWITH,21*VIEWWITH);
    self.price.frame=CGRectMake(212*VIEWWITH,42*VIEWWITH,91*VIEWWITH,21*VIEWWITH);
    self.time.frame=CGRectMake(238*VIEWWITH,8*VIEWWITH,65*VIEWWITH,19*VIEWWITH);
    self.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,72*VIEWWITH);
}
-(void)showData:(JobListModel*)model
{
    self.name.text=[NSString stringWithFormat:@"%@",model.title];
    self.place.text=[NSString stringWithFormat:@"%@",model.area_name];
    self.price.text=[NSString stringWithFormat:@"%@",model.salary];
    self.time.text=[LocolData compareCurrentTime:[NSString stringWithFormat:@"%@",model.create_timestamp]];
    self.headerImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",model.job_type_title]];
}
-(void)showCommend:(CommendModel *)model
{
    self.name.text=[NSString stringWithFormat:@"%@",model.title];
    self.place.text=[NSString stringWithFormat:@"%@",model.area_name];
    self.price.text=[NSString stringWithFormat:@"%@",model.salary];
    self.time.text=[LocolData compareCurrentTime:[NSString stringWithFormat:@"%@",model.create_timestamp]];
    self.headerImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",model.job_type_title]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
