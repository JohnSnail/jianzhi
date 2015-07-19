//
//  ImageModel.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic, assign) int image_id; //图片唯一标识
@property (nonatomic, copy) NSString *location; //相对路径

@end
