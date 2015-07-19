//
//  JoinerCell.h
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinerCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *background;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UIImageView *sexImage;
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *comment;
-(void)showDate:(ApplyUserModel*)model;
@end
