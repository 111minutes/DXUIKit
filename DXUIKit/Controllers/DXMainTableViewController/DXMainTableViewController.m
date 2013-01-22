//
//  DXMainTableViewController.m
//  DXUIKit
//
//  Created by Max Mashkov on 10/1/12.
//  Copyright (c) 2012 111minutes. All rights reserved.
//

#import "DXMainTableViewController.h"
#import "DetailedViewControllers.h"
#import "DXFormViewController.h"

@interface DXMainTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *controllersDictionary;

@end

@implementation DXMainTableViewController

- (id)init
{
    self = [super initWithNibName:@"DXMainTableViewController" bundle:nil];
    if (self) {
        self.controllersDictionary = [NSMutableDictionary dictionary];
        [_controllersDictionary setObject:[DXBlockActionsDetailedViewController new]
                                   forKey:@"Block actions"];
        [_controllersDictionary setObject:[DXFormViewController new] forKey:@"Form with scroll"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"DXUIKit";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_controllersDictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *titleKey = [_controllersDictionary allKeys][indexPath.row];
    
    cell.textLabel.text = titleKey;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *selectedController = [_controllersDictionary allValues][indexPath.row];
    selectedController.title = [_controllersDictionary allKeys][indexPath.row];
    
    [self.navigationController pushViewController:selectedController animated:YES];
}

@end
