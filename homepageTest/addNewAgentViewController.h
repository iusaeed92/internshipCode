//
//  addNewAgentViewController.h
//  homepageTest
//
//  Created by ibs on 7/21/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewAgentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *publicMeshesLabel;


@property (strong, nonatomic) IBOutlet UITextField *meshCodeTextField;

@property (strong, nonatomic) IBOutlet UITableView *suggestedMeshTableView;


@property (strong, nonatomic) NSArray *suggestedMeshesArray;




- (IBAction)addButton:(UIButton *)sender;

@end
