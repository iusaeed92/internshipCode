//
//  joinViewController.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/4/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "joinViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SSKeychain/SSKeychain.h>

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
    
    UIColor *myGreen =
    [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    self.navigationController.navigationBar.barTintColor = myGreen;
    
    
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.passwordTextfield becomeFirstResponder]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinButton:(UIButton *)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextfield.text;
    NSString *email = self.emailTextfield.text;

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSDictionary *parameters = @{@"username": username, @"password" : password, @"email": email};
    
    [manager POST:@"http://54.89.45.91/app/api/user/join"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              
            NSString *accessToken = responseObject[@"accessToken"];
              
              
              [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
              
              [SSKeychain setPassword:accessToken forService:@"Remesh" account:username];
              [self performSegueWithIdentifier:@"joinToAgent" sender:self];
              
              NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
    

}
@end
