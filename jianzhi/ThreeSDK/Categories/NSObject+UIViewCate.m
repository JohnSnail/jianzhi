//
//  NSObject+UIViewCate.m
//  Combo
//
//  Created by lly on 13-4-28.
//  Copyright (c) 2013年 李 萌萌. All rights reserved.
//

#import "NSObject+UIViewCate.h"

@implementation UIView (UIViewCate)
-(void)animateView:(BOOL)up withMovement:(float)length
{
    const float movementDuration = 0.3f;
    int movement=0;
    if (up) {
        movement=-length;
    }
    else
    {
        movement=length;
    }
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.frame = CGRectOffset(mainscreen, 0, movement);
    [UIView commitAnimations];
}
@end
