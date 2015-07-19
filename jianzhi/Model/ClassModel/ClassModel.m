//
//  ClassModel.m
//  jianzhi
//
//  Created by li on 15/5/31.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel
+ (ClassModel *)LMAppModel
{
    static ClassModel *user = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        user = [[self alloc] init];
    });
    return user;
}
@end
