//
//  PlaceCustomVC.h
//  jianzhi
//
//  Created by li on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AreaDelegate<NSObject>
-(void)selectAreaMetohd:(NSMutableDictionary *)dict;
@end
@interface PlaceCustomVC : UIViewController
@property(nonatomic,assign)   id <AreaDelegate> delegate;
@property (nonatomic,strong) NSMutableDictionary *mutableDict;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIView *contentView;
@end
