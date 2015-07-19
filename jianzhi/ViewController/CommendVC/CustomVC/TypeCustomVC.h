//
//  TypeCustomVC.h
//  jianzhi
//
//  Created by li on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeCustomDelegate<NSObject>
-(void)selectTypeCustom:(NSMutableDictionary *)dict;
@end
@interface TypeCustomVC : UIViewController
@property(nonatomic,assign)   id <TypeCustomDelegate> delegate;
@property (nonatomic,strong) NSMutableDictionary *mutableDict;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIImageView *backImage;
@property (nonatomic,weak) IBOutlet UIView *contentView;
@property (nonatomic,weak) IBOutlet UIButton *kefuBt;
@property (nonatomic,weak) IBOutlet UIButton *yanchuBt;
@property (nonatomic,weak) IBOutlet UIButton *jiajiaoBt;
@property (nonatomic,weak) IBOutlet UIButton *moteBt;
@property (nonatomic,weak) IBOutlet UIButton *paidanBt;
@property (nonatomic,weak) IBOutlet UIButton *wenyuanBt;
@property (nonatomic,weak) IBOutlet UIButton *shejiBt;
@property (nonatomic,weak) IBOutlet UIButton *xiaoneiBt;
@property (nonatomic,weak) IBOutlet UIButton *linshiBt;
@property (nonatomic,weak) IBOutlet UIButton *fuwuBt;
@property (nonatomic,weak) IBOutlet UIButton *xiaoshouBt;
@property (nonatomic,weak) IBOutlet UIButton *anbaoBt;
@property (nonatomic,weak) IBOutlet UIButton *liyiBt;
@property (nonatomic,weak) IBOutlet UIButton *cuxiaoBt;
@property (nonatomic,weak) IBOutlet UIButton *fanyiBt;
@property (nonatomic,weak) IBOutlet UIButton *otherBt;
@end
