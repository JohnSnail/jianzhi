//
//  WelcomeViewController.m
//  jianzhi
//
//  Created by Jiangwei on 15/6/7.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scroView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight);
    for (int i=0; i<4; i++) {
        UIImageView *imageview=[LMImageView lmImageView:CGRectMake(i*320*VIEWWITH, 0, mainscreenwidth, mainscreenhight) andUrl:nil andImageName:[NSString stringWithFormat:@"welcome%d",i+1]];
        [_scroView addSubview:imageview];
        
    }
    
    [self.scroView addSubview:self.starBtn];
    self.starBtn.frame = CGRectMake(1013*VIEWWITH, 462*VIEWWITH, 215*VIEWWITH, 39*VIEWWITH);
    
    self.scroView.delegate = self;
    
    self.scroView.contentSize = CGSizeMake(mainscreenwidth * 4, mainscreenhight);
    
    self.scroView.pagingEnabled = YES;
    
    self.pageControl.numberOfPages = 4;
    
    self.pageControl.frame = CGRectMake(mainscreenwidth/2 - 100/2, mainscreenhight - 50, 100, 37);
    
    [self.view addSubview:self.pageControl];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page_on"]];
    
    self.pageControl.currentPageIndicatorTintColor = RGB(250, 109, 111);
}

- (IBAction)enter:(UIButton *)sender {
    [self.delegate enterHome];
}

#pragma mark UIScrollViewDelegate
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    if(scrollView.contentOffset.x < 320){
        self.pageControl.currentPage = 0;
    }else if (scrollView.contentOffset.x < 640){
        self.pageControl.currentPage = 1;
    }else if (scrollView.contentOffset.x < 960){
        self.pageControl.currentPage = 2;
    }else{
        self.pageControl.currentPage = 3;
    }
}

@end
