//
//  AboutUsVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *AUScrollerVIew;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end
