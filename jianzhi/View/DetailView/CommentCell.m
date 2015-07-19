//
//  CommentCell.m
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [self setCommentFrame];
}
-(void)setCommentFrame
{
    self.personNum.frame=CGRectMake(197*VIEWWITH,22*VIEWWITH,28*VIEWWITH,16*VIEWWITH);
    self.headerImage.frame=CGRectMake(0*VIEWWITH,0*VIEWWITH,320*VIEWWITH,56*VIEWWITH);
    self.moreBt.frame=CGRectMake(188*VIEWWITH,8*VIEWWITH,132*VIEWWITH,41*VIEWWITH);
}
-(void)showData:(NSArray *)array andModel:(JobDetailModel*)model
{
//    if(array.count==0)
//    {
//        self.personNum.hidden=YES;
//        self.headerImage.hidden=YES;
//        self.frame=CGRectMake(0, 0, mainscreenwidth, 0);
//        return;
//    }
    for (UIView *view in self.commentDeatilView.subviews) {
        [view removeFromSuperview];
    }
    float offY = 0;
    for (int i=0; i<array.count; i++) {
        CommentModel *model=[array objectAtIndex:i];
        UIView *view=[self commentPerson:CGRectMake(0,offY, 320, 85) andModel:model];
        offY+=85;
        TLog(@"输出view的frame%f",view.frame.size.height);
        TLog(@"输出view的frame%f",view.frame.origin.y);
        [self.commentDeatilView addSubview:view];
    }
    self.commentDeatilView.frame=CGRectMake(0, 70, mainscreenwidth, offY);
    self.frame=CGRectMake(0, 0, mainscreenwidth, offY+70);

}
-(UIView *)commentPerson:(CGRect)rect andModel:(CommentModel*)model
{
    UIView *view=[[UIView alloc] initWithFrame:rect];
    UIImageView *imageBack=[LMImageView lmImageView:CGRectMake(0, 0, mainscreenwidth, 85) andUrl:nil andImageName:@"CommentDetail"];
    UIImageView *headerImage=[LMImageView lmImageView:CGRectMake(20, 24, 43, 43) andUrl:[NSString stringWithFormat:@"%@",model.figure_url] andImageName:@"CommentDetail"];
    UILabel *nameLable=[LMLable lmlablerect:CGRectMake(70,15,220, 36) anduiFontname:@"HiraKakuProN-W3" andTextcolor:[UIColor redColor] andSize:12];
    nameLable.text=[NSString stringWithFormat:@"%@",model.nick_name];
    UILabel *commentLable=[LMLable lmlablerect:CGRectMake(70,40,220, 36) anduiFontname:@"HiraKakuProN-W3" andTextcolor:RGB(145, 149, 160) andSize:12];
    commentLable.text=[NSString stringWithFormat:@"%@",model.content];
    [view addSubview:imageBack];
    [view addSubview:headerImage];
    [view addSubview:nameLable];
    [view addSubview:commentLable];
    return  view;
}
#pragma mark - 点击更多
-(IBAction)moreShow:(id)sender
{
    if (_disMoreShow) {
        _disMoreShow();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
