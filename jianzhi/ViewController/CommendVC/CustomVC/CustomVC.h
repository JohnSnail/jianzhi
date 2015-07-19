//
//  CustomVC.h
//  jianzhi
//
//  Created by li on 15/5/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeCustomVC.h"
#import "PlaceCustomVC.h"
@interface CustomVC : UIViewController<TypeCustomDelegate,AreaDelegate>
@property (nonatomic,weak) IBOutlet UIScrollView *scrollview;
@property (nonatomic,weak) IBOutlet UIView *contentView;
@property (nonatomic,weak) IBOutlet UILabel *timeLable;
@property (nonatomic,weak) IBOutlet UILabel *typeLable;
@property (nonatomic,weak) IBOutlet UILabel *placeLable;
@property (nonatomic,strong) NSArray *timeArray;
@property (nonatomic,strong) NSArray *areaArray;
@property (nonatomic,strong) NSArray *typeArray;
@property (nonatomic,copy) NSString *timeString;
@property (nonatomic,copy) NSString *timeCompare;
@property (nonatomic,copy) NSString *typeCompare;
@property (nonatomic,copy) NSString *areaCompare;
@end
