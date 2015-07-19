//
//  MyTabBarController.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarController : UITabBarController<UITabBarControllerDelegate> {
    //最近一次选择的Index
    NSUInteger _lastSelectedIndex;
}

@property(readonly, nonatomic) NSUInteger lastSelectedIndex;

+ (MyTabBarController *)sharedInstance;

@end
