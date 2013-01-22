//
//  DXKeyboardUserInfo.h
//  DXUIKit
//
//  Created by Sheva on 22.01.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXKeyboardUserInfo : NSObject

@property (nonatomic) CGRect startFrame, endFrame;
@property (nonatomic) NSTimeInterval animationDuration;
@property (nonatomic) UIViewAnimationCurve animationCurve;

- (id)initWithUserInfo:(NSDictionary *)userInfo;
- (CGFloat)height;

@end
