//
//  ResumeVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeCustomVC.h"
#import "PlaceCustomVC.h"

@interface ResumeVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,TypeCustomDelegate,AreaDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resTbView;
@property (weak, nonatomic) IBOutlet UIImageView *contentBg;

@property (weak, nonatomic) IBOutlet UIImageView *sepImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *chooseView;

@property (weak, nonatomic) IBOutlet UITextView *contentField;

@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *defLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseViewBg;

@property (nonatomic, copy) NSString *timeString;

@property (nonatomic,copy) NSDictionary *timeDic;

@property (nonatomic,copy) NSMutableArray *typeCustomArr;
@property (nonatomic,copy) NSMutableArray *areaCustomArr;

- (IBAction)quitAction:(UIButton *)sender;

- (IBAction)doneAction:(UIButton *)sender;

@end
