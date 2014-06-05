//
//  rshViewController.h
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rshViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *logoLabel;


@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;


@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;


@property (strong, nonatomic) IBOutlet UIView *whiteView;


- (IBAction)loginButton:(UIButton *)sender;



- (IBAction)joinButton:(UIButton *)sender;



@end
