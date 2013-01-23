//
//  DXKeyboardObserver.h
//  DXUIKit
//
//  Created by Sheva on 22.01.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DXKeyboardUserInfo;
@protocol DXKeyboardObserverDelegate <NSObject>

@optional
- (void)keyboardWillAppear:(DXKeyboardUserInfo *)userInfo;
- (void)keyboardDidAppear:(DXKeyboardUserInfo *)userInfo;
- (void)keyboardWillDisappear:(DXKeyboardUserInfo *)userInfo;
- (void)keyboardDidDisappear:(DXKeyboardUserInfo *)userInfo;

@end

@interface DXKeyboardObserver : NSObject

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) CGRect visibleRectOnKeyboardAppearence;
@property (nonatomic, weak) UIView *viewToHideByTap;

@property (nonatomic, weak) id<DXKeyboardObserverDelegate> observerDelegate;

@end
