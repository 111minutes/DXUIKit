//
//  DXKeyboardUserInfo.m
//  DXUIKit
//
//  Created by Sheva on 22.01.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "DXKeyboardUserInfo.h"

@implementation DXKeyboardUserInfo

- (id)init
{
    NSAssert(NO, @"Init method is deprecated. Use initWithUserInfo: instead.");
    return nil;
}

- (id)initWithUserInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        NSValue *startFrameValue = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        self.startFrame = startFrameValue.CGRectValue;
        
        NSValue *endFrameValue = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        self.endFrame = endFrameValue.CGRectValue;
        
        NSNumber *animationDuration = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
        self.animationDuration = animationDuration.doubleValue;
        
        NSNumber *animationCurve = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
        self.animationCurve = animationCurve.integerValue;
    }
    return self;
}

- (CGFloat)height
{
    return self.endFrame.size.height;
}


@end
