//
//  DisscussVC.h
//  jianzhi
//
//  Created by li on 15/4/15.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisscussVC : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *disTableView;
@property (strong, nonatomic) NSMutableArray *mutableArray;
@property (nonatomic,strong) NSMutableArray *chatArray;
@property (nonatomic,copy) NSString *jobId;
@end
