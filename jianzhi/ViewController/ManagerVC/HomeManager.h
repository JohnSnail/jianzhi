//
//  HomeManager.h
//  Zhongchou
//
//  Created by li on 15/3/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HomeManager : NSObject
@property (nonatomic, strong) NSMutableArray *tabbarMuArray;
- (void)configureDependencies:(UIWindow *)window;

+ (void)presentLoginView:(UIViewController *)viewController;


@end
