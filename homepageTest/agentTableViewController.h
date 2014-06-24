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



@interface agentTableViewController : UITableViewController <UITableViewDataSource>



@property (nonatomic, strong) User *thisUser;

@property (nonatomic, strong) NSString *theAccessToken;

@end
