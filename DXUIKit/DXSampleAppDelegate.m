//
//  DXAppDelegate.m
//  DXUIKit
//
//  Created by Max Mashkov on 10/1/12.
//  Copyright (c) 2012 111minutes. All rights reserved.
//

#import "DXSampleAppDelegate.h"

#import "DXMainTableViewController.h"

@implementation DXSampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:[DXMainTableViewController new]];

    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
