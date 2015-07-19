//
//  DisscussCell.h
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisscussCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UIImageView *backGround;
@property (nonatomic,weak) IBOutlet UIView *titleView;
-(void)showData:(CommentModel *)model;
@end
