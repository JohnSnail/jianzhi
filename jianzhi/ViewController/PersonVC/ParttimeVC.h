//
//  ParttimeVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/4/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParttimeVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;

@property (weak, nonatomic) IBOutlet UITableView *parTbView;
@property (strong , nonatomic) NSMutableArray *mutableArray;

@end
