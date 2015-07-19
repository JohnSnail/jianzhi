//
//  SGFocusImageFrame.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import <objc/runtime.h>

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
}
 
- (void)setupViews;
- (void)switchFocusImageItems;
@end

//static NSString *SG_FOCUS_ITEM_ASS_KEY = @"com.touchmob.sgfocusitems";

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 3.0; //switch interval time

@implementation SGFocusImageFrame
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(NSMutableArray *)firstItems andView:(UIView *)views
{
    self = [super initWithFrame:frame];
    if (self) {
        imageItems = [[NSMutableArray array] retain];
        for (SGFocusImageItem *firstItem in firstItems)
        {
  
                [imageItems addObject: firstItem];
        }
        
        [self setupViews:views];
        
        [self setDelegate:delegate]; 
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}

#pragma mark - private methods
- (void)setupViews:(UIView *)views
{
    imagePicArray = [[NSMutableArray alloc] init];
//    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    CGSize size = CGSizeMake(100, 44);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width *.5 - size.width *.5, self.bounds.size.height-30, size.width, size.height)];
    //_pageControl.hidden = YES;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    
    //_scrollView.layer.cornerRadius = 10;
    //_scrollView.layer.borderWidth = 1 ;
    _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = imageItems.count;
    _pageControl.currentPage = 0;
    
    _scrollView.delegate = self;
    
    // single tap gesture recognizer

    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    float picWidths = (_scrollView.frame.size.width-imageItems.count+1)/imageItems.count;
    for (int i = 0; i < imageItems.count; i++) {
        SGFocusImageItem *item = [imageItems objectAtIndex:i];
        //添加图片展示按钮
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        //[imageView setImageWithURL:[NSURL URLWithString:item.image] refreshCache:NO placeholderImage:[UIImage imageNamed:@"好友头像默认图片.png"]];
        TLog(@"输出url%@",item.image);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",item.image]] placeholderImage:[UIImage imageNamed:@"activeimage.png"]];
        imageView.tag = i;
        //添加点击事件
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGestureRecognize];        //添加标题栏
        [tapGestureRecognize release];
        
        UILabel * lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, _scrollView.frame.size.height-22.0, _scrollView.frame.size.width, 22.0)];
        //lbltitle.text = item.title;
        lbltitle.backgroundColor = [UIColor clearColor];
        
        [_scrollView addSubview:imageView];
        //[_scrollView addSubview:lbltitle];
        [imageView release];
        [lbltitle release];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(picWidths+1), 127, picWidths, 3)];
        [button setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [imagePicArray addObject:button];
        [button release];
        [views addSubview:button];
    }
    
    UIButton *button0 = [imagePicArray objectAtIndex:0];
    currentBtn = button0;
    if (button0.selected) {
        TLog(@"yes");
    }else{
        TLog(@"no");
    }
    currentBtn.selected = YES;
    
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
        }
    }
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
//    NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= _scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    _pageControl.currentPage = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);

    int j = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    currentBtn.selected = NO;
    currentBtn = [imagePicArray objectAtIndex:j];
    currentBtn.selected = YES;
    
}
#pragma mark - UIButtonTouchEvent
-(void)clickPageImage:(UIButton *)sender{
    TLog(@"click button tag is %d",sender.tag);
}

@end
