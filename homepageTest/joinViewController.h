//
//  joinViewController.h
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/4/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface joinViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;


@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;


- (IBAction)joinButton:(UIButton *)sender;

@end
