//
//  DetailFooter.h
//  jianzhi
//
//  Created by li on 15/6/10.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFooter : UIView
@property (nonatomic, copy) void (^applyMethod)();
@property (nonatomic, copy) void (^collectMethod)();
@property (nonatomic, copy) void (^suggestMethod)();
@property (nonatomic,weak) IBOutlet UIButton *applyBt;
@property (nonatomic,weak) IBOutlet UIButton *collectBt;
@property (nonatomic,weak) IBOutlet UIButton *suggestBt;
-(void)setDetailFrame;
@end
