//
//  agentTableViewController.h
//  homepageTest
//
//  Created by ibs on 6/20/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h> 
#import "User.h"
#import "rshViewController.h"
#import "agentTableViewCell.h"
#import "PageContentViewController.h"


@interface agentTableViewController : UITableViewController <UITableViewDataSource>




@property (nonatomic, strong) User *thisUser;

@property (nonatomic, strong) NSString *theAccessToken;

@property (nonatomic, strong) NSArray *agentArray;

@property(nonatomic, strong) UIView *tableViewFooter;

- (IBAction)buttonToAddAgent:(UIBarButtonItem *)sender;





- (IBAction)backButton:(id)sender;

@end
