//
//  rshViewController.h
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "agentTableViewController.h"

@interface rshViewController : UIViewController 


@property (strong, nonatomic) IBOutlet UILabel *logoLabel;


@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;


@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;


@property (strong, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) User *currentUser; //creating a current user object

@property (strong, nonatomic) NSString *myAccessToken; //This is dangerous and uncalled for. 

- (IBAction)joinButton:(UIButton *)sender;


- (IBAction)loginButtonPressed:(UIButton *)sender;

@end
