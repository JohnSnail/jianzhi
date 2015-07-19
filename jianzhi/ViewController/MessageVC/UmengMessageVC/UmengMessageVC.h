//
//  UmengMessageVC.h
//  jianzhi
//
//  Created by li on 15/5/5.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UmengMessageVC : UIViewController<UMFeedbackDataDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UMFeedback *feedback;
@property (strong, nonatomic) NSMutableArray *mutableArray;
@property (strong, nonatomic) IBOutlet UITableView *umTableView;
@property (nonatomic, retain) NSMutableArray *chatArray;
@end
