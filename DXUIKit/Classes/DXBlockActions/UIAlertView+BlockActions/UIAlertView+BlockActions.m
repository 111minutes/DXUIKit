//
//  UIAlertView+BlockActions.m
//  DXUIKit
//
//  Created by Max Mashkov on 9/22/12.
//  Copyright (c) 2012 Max Mashkov. All rights reserved.
//

#import "UIAlertView+BlockActions.h"

@implementation UIAlertView (BlockActions)

- (id)initWithTitle:(NSString *)aTitle
            message:(NSString *)aMessage
   cancelButtonItem:(DXActionButtonItem *)cancelButtonItem
   otherButtonItems:(DXActionButtonItem *)otherButtonItems, ...
{
    self = [self initWithTitle:aTitle
                       message:aMessage
                      delegate:self
             cancelButtonTitle:cancelButtonItem.title
             otherButtonTitles:nil];

    if (self) {
        
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        DXActionButtonItem *eachItem;
        va_list argumentList;
        if (otherButtonItems) {
            
            [buttonsArray addObject: otherButtonItems];
            
            va_start(argumentList, otherButtonItems);
            while ((eachItem = va_arg(argumentList, DXActionButtonItem *))) {
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        for (DXActionButtonItem *item in buttonsArray) {
            [self addButtonWithTitle:item.title];
        }
        
        if (cancelButtonItem) {
            [buttonsArray insertObject:cancelButtonItem atIndex:0];
        }
        
        objc_setAssociatedObject(self, kBlockActionHandlersArrayKey, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
    }
    return self;
}

- (void)addButtonItem:(DXActionButtonItem *)item
{
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, kBlockActionHandlersArrayKey);
    
	[buttonsArray addObject:item];
	
	[self addButtonWithTitle:item.title];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0) {
        
        NSArray *buttonsArray = objc_getAssociatedObject(self, kBlockActionHandlersArrayKey);
        
        DXActionButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        [item callBlockAction];
    }
}

@end
