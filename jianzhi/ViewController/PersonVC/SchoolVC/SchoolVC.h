//
//  SchoolVC.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/29.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol schoolDelegate <NSObject>

-(void)schoolDetail:(NSString *)name;

@end

@interface SchoolVC : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) id<schoolDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *searchTield;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITableView *schooleTbView;

@property (strong, nonatomic) NSMutableArray *schMuArray;

@end
