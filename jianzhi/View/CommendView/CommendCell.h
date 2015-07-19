//
//  CommendCell.h
//  jianzhi
//
//  Created by li on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommendCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *place;
@property (nonatomic,weak) IBOutlet UILabel *time;
@property (nonatomic,weak) IBOutlet UILabel *price;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UIImageView *backImage;
-(void)showData:(JobListModel*)model;
-(void)showCommend:(CommendModel *)model;
@end
