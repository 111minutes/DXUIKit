//
//  DXKeyboardObserver.m
//  DXUIKit
//
//  Created by Sheva on 22.01.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "DXKeyboardObserver.h"
#import "DXKeyboardUserInfo.h"

@interface DXKeyboardObserver ()

- (void)keyboardWillAppear:(NSNotification *)notification;
- (void)keyboardDidAppear:(NSNotification *)notification;
- (void)keyboardWillDisappear:(NSNotification *)notification;
- (void)keyboardDidDisappear:(NSNotification *)notification;

- (void)tapAction:(id)sender;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic) BOOL shouldScrollToVisibleRect;

@end

@implementation DXKeyboardObserver

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        [notificationCenter addObserver:self
                               selector:@selector(keyboardWillAppear:)
                                   name:UIKeyboardWillShowNotification
                                 object:nil];
        [notificationCenter addObserver:self
                               selector:@selector(keyboardDidAppear:)
                                   name:UIKeyboardDidShowNotification
                                 object:nil];
        [notificationCenter addObserver:self
                               selector:@selector(keyboardWillDisappear:)
                                   name:UIKeyboardWillHideNotification
                                 object:nil];
        [notificationCenter addObserver:self
                               selector:@selector(keyboardDidDisappear:)
                                   name:UIKeyboardDidHideNotification
                                 object:nil];
        
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        self.visibleRectOnKeyboardAppearence = CGRectZero;
        self.shouldScrollToVisibleRect = NO;
    }
    return self;
}

#pragma mark - 
#pragma mark - Observing methods

- (void)keyboardWillAppear:(NSNotification *)notification
{
    DXKeyboardUserInfo *userInfo = [[DXKeyboardUserInfo alloc] initWithUserInfo:notification.userInfo];
    
    if (self.viewToHideByTap) {
        [self.viewToHideByTap addGestureRecognizer:self.tapRecognizer];
    }
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardWillAppear:)]) {
        [self.observerDelegate keyboardWillAppear:userInfo];
    }
}

- (void)keyboardDidAppear:(NSNotification *)notification
{
    DXKeyboardUserInfo *userInfo = [[DXKeyboardUserInfo alloc] initWithUserInfo:notification.userInfo];
    
    if (self.scrollView) {
        __weak DXKeyboardObserver *observer = self;
        [UIView animateWithDuration:userInfo.animationDuration animations:^{
            observer.scrollView.contentInset = UIEdgeInsetsMake(0, 0, userInfo.height, 0);
        } completion:^(BOOL finished) {
            if (observer.shouldScrollToVisibleRect) {
                [observer.scrollView scrollRectToVisible:observer.visibleRectOnKeyboardAppearence animated:YES];
            }
        }];
    }
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardDidAppear:)]) {
        [self.observerDelegate keyboardDidAppear:userInfo];
    }
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    DXKeyboardUserInfo *userInfo = [[DXKeyboardUserInfo alloc] initWithUserInfo:notification.userInfo];
    
    if (self.scrollView) {
        __weak DXKeyboardObserver *observer = self;
        [UIView animateWithDuration:userInfo.animationDuration animations:^{
            observer.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }
    
    [self removeGestureRecognizer];
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardWillDisappear:)]) {
        [self.observerDelegate keyboardWillDisappear:userInfo];
    }
}

- (void)keyboardDidDisappear:(NSNotification *)notification
{
    DXKeyboardUserInfo *userInfo = [[DXKeyboardUserInfo alloc] initWithUserInfo:notification.userInfo];
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardDidDisappear:)]) {
        [self.observerDelegate keyboardDidDisappear:userInfo];
    }
}

#pragma mark - 
#pragma mark - gesture recognizer methods

- (void)tapAction:(id)sender
{
    [self.viewToHideByTap endEditing:YES];
    [self removeGestureRecognizer];
}

- (void)removeGestureRecognizer
{
    UIView *view = self.tapRecognizer.view;
    if (view) {
        [view removeGestureRecognizer:self.tapRecognizer];
    }
}

#pragma mark -
#pragma mark - setters

- (void)setVisibleRectOnKeyboardAppearence:(CGRect)visibleRectOnKeyboardAppearence {
    _visibleRectOnKeyboardAppearence = visibleRectOnKeyboardAppearence;
    self.shouldScrollToVisibleRect = YES;
}

@end
