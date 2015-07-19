//
//  CollectVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (weak, nonatomic) IBOutlet UITableView *colTbView;
@property (strong , nonatomic) NSMutableArray *mutableArray;

@end
