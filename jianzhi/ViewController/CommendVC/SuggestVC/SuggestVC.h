//
//  SuggestVC.h
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SuggestVC : UIViewController<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UITextView *textView;
@property (nonatomic,weak) IBOutlet UITextField *textFieldCom;
@property (nonatomic,weak) IBOutlet UITextField *phoneField;
@property (nonatomic,copy) NSString *jobId;
@end
