//
//  conversationTableViewController.h
//  homepageTest
//
//  Created by ibs on 6/25/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conversationTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *convosArray;

@property (strong, nonatomic) NSArray *currentAgent;

@property (strong, nonatomic) NSIndexPath *path; 

@property (strong, nonatomic) NSString *agentID;



@end
