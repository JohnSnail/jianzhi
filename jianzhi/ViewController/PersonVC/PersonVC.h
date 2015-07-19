//
//  PersonVC.h
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectVC.h"
#import "ParttimeVC.h"
#import "FeedbackVC.h"
#import "AboutUsVC.h"

@interface PersonVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *personTbView;
@property (weak, nonatomic) IBOutlet UIImageView *modImageView;

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *schLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@end
