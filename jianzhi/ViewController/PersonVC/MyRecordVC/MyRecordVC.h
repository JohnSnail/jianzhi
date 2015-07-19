//
//  MyRecordVC.h
//  jianzhi
//
//  Created by li on 15/6/17.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecordVC : UIViewController
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIView *contentView;
@property (nonatomic,weak) IBOutlet UIImageView *headerImage;
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *age;
@property (nonatomic,weak) IBOutlet UILabel *college;
@property (nonatomic,weak) IBOutlet UILabel *phoneLable;
@property (nonatomic,weak) IBOutlet UILabel *emailLable;
@property (nonatomic,weak) IBOutlet UILabel *typeLable;
@property (nonatomic,weak) IBOutlet UILabel *phone;
@property (nonatomic,weak) IBOutlet UILabel *email;
@property (nonatomic,weak) IBOutlet UILabel *type;
@property (nonatomic,weak) IBOutlet UILabel *personLable;
@property (nonatomic,weak) IBOutlet UILabel *introduce;
@property (nonatomic,weak) IBOutlet UILabel *workLable;
@property (nonatomic,weak) IBOutlet UILabel *work;
@property (nonatomic,weak) IBOutlet UIImageView *lineImageOne;
@property (nonatomic,weak) IBOutlet UIImageView *lineImageTwo;
@property (nonatomic,weak) IBOutlet UIImageView *lineImageThree;
@end
