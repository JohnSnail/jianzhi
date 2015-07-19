//
//  ClassManager.h
//  jianzhi
//
//  Created by li on 15/6/6.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassManager : NSObject
+(void)getClassCity:(NSString *)city Success:(void (^)(id))block;
+(void)getCityArearesponse:(void (^)(id))block;
@end
