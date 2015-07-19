//
//  DetailVC.h
//  jianzhi
//
//  Created by li on 15/4/11.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface DetailVC : UIViewController<MFMessageComposeViewControllerDelegate>
@property (nonatomic,weak) IBOutlet UITableView *commendTable;

@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,strong) JobDetailModel *model;
@property (nonatomic,copy) NSString *jobId;
@property (nonatomic,strong) NSArray *UersArray;
@property (nonatomic,strong) NSArray *Comments;
@end
