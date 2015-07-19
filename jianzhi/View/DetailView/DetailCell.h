//
//  DetailCell.h
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *backImage;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *company;
@property (nonatomic,weak) IBOutlet UILabel *personLable;
@property (nonatomic,weak) IBOutlet UILabel *salaryLable;
@property (nonatomic,weak) IBOutlet UILabel *time;
@property (nonatomic,weak) IBOutlet UILabel *contactLable;
@property (nonatomic,weak) IBOutlet UILabel *contact_person;
@property (nonatomic,weak) IBOutlet UILabel *address;
@property (nonatomic,weak) IBOutlet UILabel *personNum;
@property (nonatomic,weak) IBOutlet UILabel *salary;
@property (nonatomic,weak) IBOutlet UILabel *comment;
@property (nonatomic,weak) IBOutlet UIButton *mapBt;
@property (nonatomic,copy) void (^mapViewShow)();
-(void)showData:(JobDetailModel*)model;
@end
