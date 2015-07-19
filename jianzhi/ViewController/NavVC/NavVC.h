//
//  NavVC.h
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
#import <CoreLocation/CoreLocation.h>
@interface NavVC : UIViewController<UITableViewDataSource,UITableViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource,CLLocationManagerDelegate>
@property float lat,lng;
@property(nonatomic,retain) CLLocationManager* locationmanager;
@property (nonatomic,weak) IBOutlet UITableView *commendTable;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@end
