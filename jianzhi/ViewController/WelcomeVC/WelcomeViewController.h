//
//  WelcomeViewController.h
//  jianzhi
//
//  Created by Jiangwei on 15/6/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol appDelegate <NSObject>

-(void)enterHome;

@end
@interface WelcomeViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (nonatomic,assign) id<appDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
- (IBAction)enter:(UIButton *)sender;

@end
