//
//  rshViewController.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "rshViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import "agentTableViewController.h"
#import <SSKeychain/SSKeychain.h>



@interface rshViewController ()

@end

int x = 1;

@implementation rshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.view = [self.view initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.width)];
    [self.navigationController setNavigationBarHidden:YES];
    self.currentUser = [[User alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        if ([segue.destinationViewController isKindOfClass:[agentTableViewController class]]) {
        }
    }
}
//-------------------------------------------------------------
////////////*******This chunk provides the scroll up****------
//
#define kOFFSET_FOR_KEYBOARD 220.0

-(void)keyboardWillShow {
    NSLog(@"Keyboard will show");
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender {
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // why are there 2 calls to this
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

//----------------------------------------------------------------------------------
////////////*******End of Scroll up block****---------------------------------------


#pragma implementing delegate method
- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
}

//segue's to Join page through storyboard
- (IBAction)joinButton:(UIButton *)sender {
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    NSString *username = self.usernameTextfield.text;
    NSString *password = self.passwordTextfield.text;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    //  [manager POST:@"http://54.210.29.136/api/user/login"
    //https://remesh.xyz/api/user/login
    
    
    NSDictionary *parameters = @{@"username": username, @"password" : password};
    [manager POST:@"https://remesh.xyz/api/org/user/login"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSNumber *errorCode = responseObject[@"errorCode"];
              NSLog(@"error:%@", errorCode);
              if ([errorCode isEqual:@1]) {
                  [[[UIAlertView alloc]
                    initWithTitle:NSLocalizedString(@"Login Failed", @"")
                    message:NSLocalizedString(@"Username and or Password incorrect", @"")
                    delegate:nil
                    cancelButtonTitle:NSLocalizedString(@"Retry", @"")
                    otherButtonTitles: nil] show];
              }
              else{
                  self.currentUser.accessToken = responseObject[@"accessToken"];
                  self.myAccessToken = responseObject[@"accessToken"];
                  [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
                  [SSKeychain setPassword:password forService:@"Error_2" account:username];
                  [SSKeychain setPassword:self.myAccessToken forService:@"Remesh" account:username];
                  [self performSegueWithIdentifier:@"toAgentsList" sender:self];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}
@end








