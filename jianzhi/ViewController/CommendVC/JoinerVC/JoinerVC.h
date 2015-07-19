//
//  JoinerVC.h
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinerVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *joinerTable;

@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,copy) NSString *jobId;
@end
