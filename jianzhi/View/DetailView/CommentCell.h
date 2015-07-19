//
//  CommentCell.h
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (nonatomic,copy) void (^disMoreShow)();

@property (nonatomic,weak) IBOutlet UILabel *personNum;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UIButton *moreBt;
@property (nonatomic,weak) IBOutlet UIView *commentDeatilView;
-(void)showData:(NSArray *)array andModel:(JobDetailModel*)model;
@end
