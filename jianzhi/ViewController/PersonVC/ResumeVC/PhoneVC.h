//
//  PhoneVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/6/2.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *doneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *phongBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *doneImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *doneField;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
