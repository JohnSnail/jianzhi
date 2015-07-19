//
//  ProfileVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadSingleImageViewController.h"
#import "ZHPickView.h"
#import "SchoolVC.h"
#import "CollegeVC.h"

@interface ProfileVC : UIViewController<UITableViewDataSource,UITableViewDelegate,GetSingleImageDelegate,UIActionSheetDelegate,ZHPickViewDelegate,schoolDelegate,collegeDelegate>{
    ZHPickView *_pickview;
    ZHPickView *_pickview2;

}

@property (weak, nonatomic) IBOutlet UITableView *proTbView;

@end
