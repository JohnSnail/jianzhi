//
//  UploadSingleImageViewController.h
//  Combo
//
//  Created by lly on 13-7-19.
//  Copyright (c) 2013年 李 萌萌. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GetSingleImageDelegate
-(void)ReloadImageMessage:(UIImage*)aImage;
@end
@interface UploadSingleImageViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (assign,nonatomic) id<GetSingleImageDelegate> delegate;

@property (nonatomic,assign) NSInteger flag;//0-相机;1-图片库

@end
