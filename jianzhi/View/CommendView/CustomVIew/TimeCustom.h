//
//  TimeCustom.h
//  jianzhi
//
//  Created by li on 15/5/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeCustom : UIView
@property (nonatomic,weak) IBOutlet UIButton *mondayAM;
@property (nonatomic,weak) IBOutlet UIButton *mondayPM;
@property (nonatomic,weak) IBOutlet UIButton *mondayNight;
@property (nonatomic,weak) IBOutlet UIButton *tuesdayAM;
@property (nonatomic,weak) IBOutlet UIButton *tuesdayPM;
@property (nonatomic,weak) IBOutlet UIButton *tuesdayNight;
@property (nonatomic,weak) IBOutlet UIButton *wednesdayAM;
@property (nonatomic,weak) IBOutlet UIButton *wednesdayPM;
@property (nonatomic,weak) IBOutlet UIButton *wednesdayNight;
@property (nonatomic,weak) IBOutlet UIButton *thursdayAM;
@property (nonatomic,weak) IBOutlet UIButton *thursdayPM;
@property (nonatomic,weak) IBOutlet UIButton *thursdayNight;
@property (nonatomic,weak) IBOutlet UIButton *fridayAM;
@property (nonatomic,weak) IBOutlet UIButton *fridayPM;
@property (nonatomic,weak) IBOutlet UIButton *fridayNight;
@property (nonatomic,weak) IBOutlet UIButton *saturdayAM;
@property (nonatomic,weak) IBOutlet UIButton *saturdayPM;
@property (nonatomic,weak) IBOutlet UIButton *saturdayNight;
@property (nonatomic,weak) IBOutlet UIButton *sundayAM;
@property (nonatomic,weak) IBOutlet UIButton *sundayPM;
@property (nonatomic,weak) IBOutlet UIButton *sundayNight;

@property (nonatomic, copy) void (^selectTime)();
@property (nonatomic, copy) void (^cancleTime)();
@end
