//
//  ComButtonCell.h
//  jianzhi
//
//  Created by li on 15/5/16.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComButtonCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIButton *moreButton;
@property (nonatomic,copy) void (^discussMethod)();
@end
