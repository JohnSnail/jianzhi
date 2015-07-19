//
//  ProfileDetailCell.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/28.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDetailCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UILabel *boyLabel;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
@property (weak, nonatomic) IBOutlet UILabel *girlLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;

-(void)hideSexView:(BOOL)hidden;
@property (weak, nonatomic) IBOutlet UITextField *detTextField;

@end
