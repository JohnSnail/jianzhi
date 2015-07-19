//
//  CollegeVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/29.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol collegeDelegate <NSObject>

-(void)collegeDetail:(NSString *)name;

@end

@interface CollegeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id<collegeDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *colTbView;
@property (strong, nonatomic) NSMutableArray *colMuArray;

@end
