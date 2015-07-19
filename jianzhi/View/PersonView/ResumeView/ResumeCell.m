//
//  ResumeCell.m
//  jianzhi
//
//  Created by Jiangwei on 15/6/2.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ResumeCell.h"

@implementation ResumeCell

- (void)awakeFromNib {
    // Initialization code
    
    self.emailField.hidden = YES;
    self.emailField.delegate = self;
    
    [self setResumeCellFrame];
}

-(void)setResumeCellFrame
{
    self.cellBg.frame = CGRectMake(0, 0, 320 * VIEWWITH, 55* VIEWWITH);
    self.headLabel.frame = CGRectMake(20* VIEWWITH, 8* VIEWWITH, 74* VIEWWITH, 38* VIEWWITH);
    self.detailLabel.frame = CGRectMake(102* VIEWWITH, 8* VIEWWITH, 176* VIEWWITH, 38* VIEWWITH);
    self.emailField.frame = CGRectMake(102* VIEWWITH, 13* VIEWWITH, 176* VIEWWITH, 30* VIEWWITH);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.emailField resignFirstResponder];
    
    UserModel *user = [CommUtils readUser];
    user.email = self.emailField.text;
    [CommUtils saveUserModel:user];
    
    return NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
