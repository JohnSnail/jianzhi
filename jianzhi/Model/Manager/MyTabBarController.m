//
//  MyTabBarController.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController
@synthesize lastSelectedIndex=_lastSelectedIndex;

+ (MyTabBarController *)sharedInstance
{
    static MyTabBarController *tabVC = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tabVC = [[self alloc] init];
    });
    return tabVC;
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
        if (_lastSelectedIndex > 1) {
            _lastSelectedIndex = 0;
        }
        NSLog(@"1 OLD:%d , NEW:%d",self.lastSelectedIndex,selectedIndex);
    }
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
        if (_lastSelectedIndex > 1) {
            _lastSelectedIndex = 0;
        }
        NSLog(@"2 OLD:%d , NEW:%d",self.lastSelectedIndex,tabIndex);
    }
}

@end
