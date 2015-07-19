//
//  ConnectCell.m
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ConnectCell.h"

@implementation ConnectCell

- (void)awakeFromNib {
    [self setConnectFrame];
}
-(void)setConnectFrame
{
    self.headerView.frame=CGRectMake(0*VIEWWITH,55*VIEWWITH,320*VIEWWITH,45*VIEWWITH);
    self.personLable.frame=CGRectMake(25*VIEWWITH,10*VIEWWITH,147*VIEWWITH,21*VIEWWITH);
    self.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,130*VIEWWITH);
}
-(void)showData:(NSArray *)array andModel:(JobDetailModel *)model
{
    if(array.count==0)
    {
        self.headerView.hidden=YES;
        self.personLable.hidden=YES;
        self.frame=CGRectMake(0, 0, mainscreenwidth, 0);
        return;
    }
    self.personLable.text=[NSString stringWithFormat:@"已报名的小伙伴 %@人",model.apply_count];
    for (UIView *view in self.headerView.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<array.count; i++) {
        ApplyUserModel *model=[array objectAtIndex:i];
        UIImageView *imageview=[self showPerson:CGRectMake((25+75*i)*VIEWWITH, 0, 45,45) andModel:model];
        [self.headerView addSubview:imageview];
    }
}
-(UIImageView *)showPerson:(CGRect)rect andModel:(ApplyUserModel*)model
{
    UIImageView *headImage=[LMImageView lmImageView:rect andUrl:[NSString stringWithFormat:@"%@",model.figure_url] andImageName:@"180"];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 22.5;
    headImage.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [headImage addGestureRecognizer:tap];
    return headImage;
}
-(void)doTap:(UITapGestureRecognizer *)sender
{
    if (_usersShow) {
        _usersShow();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
