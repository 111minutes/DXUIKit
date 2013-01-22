//
//  DXFormViewController.m
//  DXUIKit
//
//  Created by Sheva on 22.01.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "DXFormViewController.h"

@interface DXFormViewController () <DXKeyboardObserverDelegate>

@property (nonatomic, strong) DXKeyboardObserver *keyboardObserver;

@end

@implementation DXFormViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentSize = self.view.frame.size;
    
    self.keyboardObserver = [DXKeyboardObserver new];
    self.keyboardObserver.scrollView = scrollView;
    self.keyboardObserver.viewToHideByTap = self.view;
    self.keyboardObserver.observerDelegate = self;
    self.keyboardObserver.visibleRectOnKeyboardAppearence = CGRectMake(0, 120, 320, 264);
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.keyboardObserver = nil;
    [super viewWillDisappear:animated];
}

#pragma mark - 
#pragma mark - DXKeyboardObserverDelegate methods

- (void)keyboardWillAppear:(DXKeyboardUserInfo *)userInfo
{
    NSLog(@"keyboardWillAppear:");
}

- (void)keyboardDidAppear:(DXKeyboardUserInfo *)userInfo
{
    NSLog(@"keyboardDidAppear:");
}

- (void)keyboardWillDisappear:(DXKeyboardUserInfo *)userInfo
{
    NSLog(@"keyboardWillDisappear:");
}

- (void)keyboardDidDisappear:(DXKeyboardUserInfo *)userInfo
{
    NSLog(@"keyboardDidDisappear:");
}

@end
