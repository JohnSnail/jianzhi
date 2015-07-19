//
//  ProfileDetailCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/28.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ProfileDetailCell.h"

@implementation ProfileDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.boyLabel.textColor = RGB(151, 167, 184);
    self.girlLabel.textColor = RGB(151, 167, 184);
    self.headLabel.textColor = RGB(151, 167, 184);
    self.detTextField.textColor = RGB(151, 167, 184);
    self.contentsLabel.textColor = RGB(151, 167, 184);
    
    [self.headLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [self hideSexView:YES];
    self.detTextField.hidden = YES;
    self.contentsLabel.hidden = YES;
    self.detTextField.delegate = self;
    
    [self setProfileDetailCellFrame];
}

-(void)setProfileDetailCellFrame
{
    self.backImageView.frame = CGRectMake(0, 0, 320 * VIEWWITH, 54 * VIEWWITH);
    
    self.headLabel.frame = CGRectMake(20 * VIEWWITH, 8 * VIEWWITH, 60 * VIEWWITH, 38 * VIEWWITH);
    self.contentsLabel.frame = CGRectMake(79 * VIEWWITH, 8 * VIEWWITH, 233 * VIEWWITH, 38 * VIEWWITH);
    self.boyBtn.frame = CGRectMake(187 * VIEWWITH, 8 * VIEWWITH, 40 * VIEWWITH, 40 * VIEWWITH);
    self.boyLabel.frame = CGRectMake(220 * VIEWWITH, 18 * VIEWWITH, 20 * VIEWWITH, 20 * VIEWWITH);
    self.girlLabel.frame = CGRectMake(277 * VIEWWITH, 18 * VIEWWITH, 20 * VIEWWITH, 20 * VIEWWITH);
    self.girlBtn.frame = CGRectMake(243 * VIEWWITH, 8 * VIEWWITH, 40 * VIEWWITH, 40 * VIEWWITH);
    self.detTextField.frame = CGRectMake(79 * VIEWWITH, 12 * VIEWWITH, 111 * VIEWWITH, 30 * VIEWWITH);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    UserModel * user = [CommUtils readUser];
    user.nick_name = self.detTextField.text;
    [CommUtils saveUserModel:user];
    
    return NO;
}

-(void)hideSexView:(BOOL)hidden
{
    self.boyBtn.hidden = hidden;
    self.boyLabel.hidden = hidden;
    self.girlBtn.hidden = hidden;
    self.girlLabel.hidden = hidden;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
