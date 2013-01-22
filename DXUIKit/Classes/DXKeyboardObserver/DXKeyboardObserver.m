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

- (void)keyboardWillAppear:(NSDictionary *)userInfo;
- (void)keyboardDidAppear:(NSDictionary *)userInfo;
- (void)keyboardWillDisappear:(NSDictionary *)userInfo;
- (void)keyboardDidDisappear:(NSDictionary *)userInfo;

- (void)tapAction:(id)sender;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

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
    }
    return self;
}

#pragma mark - 
#pragma mark - Observing methods

- (void)keyboardWillAppear:(NSDictionary *)userInfo
{
    DXKeyboardUserInfo *info = [[DXKeyboardUserInfo alloc] initWithUserInfo:userInfo];
    
    if (self.scrollView) {
        [UIView animateWithDuration:info.animationDuration animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, info.height, 0);
        }];
    }
    
    if (self.viewToHideByTap) {
        [self.viewToHideByTap addGestureRecognizer:self.tapRecognizer];
    }
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardWillAppear:)]) {
        [self.observerDelegate keyboardWillAppear:info];
    }
}

- (void)keyboardDidAppear:(NSDictionary *)userInfo
{
    DXKeyboardUserInfo *info = [[DXKeyboardUserInfo alloc] initWithUserInfo:userInfo];
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardDidAppear:)]) {
        [self.observerDelegate keyboardDidAppear:info];
    }
}

- (void)keyboardWillDisappear:(NSDictionary *)userInfo
{
    DXKeyboardUserInfo *info = [[DXKeyboardUserInfo alloc] initWithUserInfo:userInfo];
    
    if (self.scrollView) {
        [UIView animateWithDuration:info.animationDuration animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }
    
    [self removeGestureRecognizer];
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardWillDisappear:)]) {
        [self.observerDelegate keyboardWillDisappear:info];
    }
}

- (void)keyboardDidDisappear:(NSDictionary *)userInfo
{
    DXKeyboardUserInfo *info = [[DXKeyboardUserInfo alloc] initWithUserInfo:userInfo];
    
    if ([self.observerDelegate respondsToSelector:@selector(keyboardDidDisappear:)]) {
        [self.observerDelegate keyboardDidDisappear:info];
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

@end
