//
//  CommendVC.h
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import <CoreLocation/CoreLocation.h>
@interface CommendVC : UIViewController<SGFocusImageFrameDelegate,CLLocationManagerDelegate>
@property float lat,lng;
@property (nonatomic,strong) NSArray *adsArray;
@property(nonatomic,retain) CLLocationManager* locationmanager;
@property (nonatomic,weak) IBOutlet UITableView *commendTable;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@end
