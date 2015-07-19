//
//  DetailCell.m
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    [self setDetailFrame];
}
-(void)setDetailFrame
{
    self.backImage.frame=CGRectMake(0*VIEWWITH,135*VIEWWITH,320*VIEWWITH,408*VIEWWITH);
    self.headerImage.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,135*VIEWWITH);
    self.name.frame=CGRectMake(8*VIEWWITH,164*VIEWWITH,304*VIEWWITH,21*VIEWWITH);
    self.company.frame=CGRectMake(8*VIEWWITH,196*VIEWWITH,304*VIEWWITH,21*VIEWWITH);
    self.personLable.frame=CGRectMake(24*VIEWWITH,239*VIEWWITH,70*VIEWWITH,21*VIEWWITH);
    self.salaryLable.frame=CGRectMake(24*VIEWWITH,284*VIEWWITH,59*VIEWWITH,21*VIEWWITH);
    self.time.frame=CGRectMake(44*VIEWWITH,382*VIEWWITH,232*VIEWWITH,21*VIEWWITH);
    self.contact_person.frame=CGRectMake(206*VIEWWITH,332*VIEWWITH,70*VIEWWITH,21*VIEWWITH);
    self.contactLable.frame=CGRectMake(24*VIEWWITH,332*VIEWWITH,70*VIEWWITH,21*VIEWWITH);
    self.address.frame=CGRectMake(53*VIEWWITH,430*VIEWWITH,230*VIEWWITH,47*VIEWWITH);
    self.personNum.frame=CGRectMake(191*VIEWWITH,239*VIEWWITH,85*VIEWWITH,21*VIEWWITH);
    self.salary.frame=CGRectMake(193*VIEWWITH,279*VIEWWITH,83*VIEWWITH,21*VIEWWITH);
    self.mapBt.frame=CGRectMake(8*VIEWWITH,422*VIEWWITH,304*VIEWWITH,62*VIEWWITH);
    
}
-(void)showData:(JobDetailModel*)model
{
    self.comment.text=[NSString stringWithFormat:@"%@",model.comment];
    self.company.text=[NSString stringWithFormat:@"%@",model.company_title];
    self.contact_person.text=[NSString stringWithFormat:@"%@",model.contact_person];
    self.time.text=[NSString stringWithFormat:@"发布时间:%@",[LocolData timeDate:[NSString stringWithFormat:@"%@",model.create_timestamp] andtype:@"yyyy-MM-dd"]];
    self.personNum.text=[NSString stringWithFormat:@"%@",model.need_count];
    self.salary.text=[NSString stringWithFormat:@"%@",model.salary];
    self.name.text=[NSString stringWithFormat:@"%@",model.title];
    self.address.text=[NSString stringWithFormat:@"%@",model.work_address];
    NSString *commentString=nil;
    if ([model.valid_time_start floatValue]>0) {
        commentString=[NSString stringWithFormat:@"%@\\n工作时间：%@--%@",model.comment,[LocolData timeDate:[NSString stringWithFormat:@"%@",model.valid_time_start] andtype:@"yyyy-MM-dd HH:mm:ss"],[LocolData timeDate:[NSString stringWithFormat:@"%@",model.valid_time_end] andtype:@"yyyy-MM-dd HH:mm:ss"]];
    }else
    {
        commentString=[NSString stringWithFormat:@"%@",model.comment];
    }
    [self showCommend:commentString];
}
-(void)showCommend:(NSString *)commentStr
{
    self.comment.frame=CGRectMake(24*VIEWWITH,551*VIEWWITH,281*VIEWWITH,0);
    //自动换行
    self.comment.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    self.comment.textColor=RGB(148, 148, 161);
    //[label setBackgroundColor:[UIColor greenColor]];
    [self.comment setNumberOfLines:0];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:commentStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [commentStr length])];
    self.comment.attributedText = attributedString;
    [self.comment sizeToFit];
    self.comment.frame=CGRectMake(24*VIEWWITH, 551*VIEWWITH, self.comment.frame.size.width, self.comment.frame.size.height);
    self.frame=CGRectMake(0, 0,mainscreenwidth,self.comment.frame.size.height+558*VIEWWITH);
}
-(IBAction)mapViewButton:(id)sender
{
    if (_mapViewShow) {
        _mapViewShow();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
