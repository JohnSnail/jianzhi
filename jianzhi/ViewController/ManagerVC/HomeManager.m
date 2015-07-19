//
//  HomeManager.m
//  Zhongchou
//
//  Created by li on 15/3/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "HomeManager.h"
#import "CommendVC.h"
#import "MessageVC.h"
#import "PersonVC.h"
#import "NavVC.h"
#import "MyTabBarController.h"

@implementation HomeManager
- (void)configureDependencies:(UIWindow *)window
{
    [ClassManager getClassCity:@"北京" Success:nil];
    _tabbarMuArray=[[NSMutableArray alloc] init];
    //商家
    CommendVC *commendVC = [[CommendVC alloc]init];
    [self showRootViewContrller:commendVC andUnselectedImage:[UIImage imageNamed:@"unHouse"] andSelectedImage:[UIImage imageNamed:@"house"] andTitle:@"推荐"];
    //局==
    NavVC *navVC = [[NavVC alloc]init];
    [self showRootViewContrller:navVC andUnselectedImage:[UIImage imageNamed:@"unTarget"] andSelectedImage:[UIImage imageNamed:@"target"] andTitle:@"发现"];
    //
    MessageVC *messageVC = [[MessageVC alloc]init];
    [self showRootViewContrller:messageVC andUnselectedImage:[UIImage imageNamed:@"unComments"] andSelectedImage:[UIImage imageNamed:@"comments"] andTitle:@"消息"];
    //个人
    PersonVC *personVC = [[PersonVC alloc]init];
    [self showRootViewContrller:personVC andUnselectedImage:[UIImage imageNamed:@"unProfile"] andSelectedImage:[UIImage imageNamed:@"profile"] andTitle:@"我"];
    
    MyTabBarController *tabbarController = [MyTabBarController sharedInstance];
    UIImage *image = [UIImage imageNamed:@"tabbar"];
    [tabbarController.tabBar setBackgroundImage:image];
    
    tabbarController.viewControllers = [NSArray arrayWithArray:self.tabbarMuArray];
    window.rootViewController = tabbarController;
}

- (void)showRootViewContrller:(UIViewController *)viewController andUnselectedImage:(UIImage *)unSelectImage andSelectedImage:(UIImage *)selectImage andTitle:(NSString *)title
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nevBar"] forBarMetrics:UIBarMetricsDefault];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:selectImage tag:0];
    viewController.tabBarItem.image = [unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBar appearance] setSelectedImageTintColor:RGB(252,109,111)];
    
    
    MLNavigationController *navigationController = [[MLNavigationController alloc]initWithRootViewController:viewController];
    //navigationController.delegate=self;
    
    [self.tabbarMuArray addObject:navigationController];
    
}



+ (void)presentLoginView:(UIViewController *)viewController
{
//    UseWanjuVC *useWanjuVC = [[UseWanjuVC alloc]init];
//    MLNavigationController * loginNav= [[MLNavigationController alloc]initWithRootViewController:useWanjuVC];
//    //[viewController presentModalViewController:loginNav animated:YES];
//    loginNav.navigationBarHidden=YES;
//    loginNav.canDragBack=NO;
//    [viewController presentViewController:loginNav animated:YES completion:nil];
}

@end
