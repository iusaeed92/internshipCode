//
//  joinViewController.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/4/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "joinViewController.h"

@interface joinViewController ()

@end

@implementation joinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.passwordTextfield becomeFirstResponder]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinButton:(UIButton *)sender {
}
@end
