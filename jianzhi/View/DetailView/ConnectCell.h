//
//  ConnectCell.h
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectCell : UITableViewCell
@property (nonatomic,copy) void (^usersShow)();
@property (nonatomic,weak) IBOutlet UIView *headerView;
@property (nonatomic,weak) IBOutlet UILabel *personLable;
-(void)showData:(NSArray *)array andModel:(JobDetailModel*)model;
@end
