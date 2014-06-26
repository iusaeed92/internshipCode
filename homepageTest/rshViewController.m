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




@interface rshViewController ()

@end

int x = 1;

@implementation rshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.currentUser = [[User alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([sender isKindOfClass:[UIButton class]]) {
        if ([segue.destinationViewController isKindOfClass:[agentTableViewController class]]) {
            
            
            
            NSString *username = self.usernameTextfield.text;
            NSString *password = self.passwordTextfield.text;
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            
            [manager.responseSerializer setAcceptableContentTypes:
             [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
            
            NSDictionary *parameters = @{@"username": username, @"password" : password};
            
            [manager POST:@"http://54.89.45.91/app/api/user/login"
               parameters:parameters
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      
                      
                      self.currentUser.accessToken = responseObject[@"accessToken"];
                      self.myAccessToken = responseObject[@"accessToken"];
                      NSLog(@" direct Access Token: %@", responseObject[@"accessToken"]);
                      NSLog(@"property access Token:%@", self.myAccessToken);
                      NSLog(@"the new access Token:%@", self.currentUser.accessToken);
                      
                      
                      
                      
           
                      
                      
                          
                          agentTableViewController *agentTableVC = segue.destinationViewController;
                          
                          agentTableVC.theAccessToken = self.myAccessToken;
                    
                      
                    [agentTableVC.tableView reloadData];
                      
                      
                      //Agents http reqyest.
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager.responseSerializer setAcceptableContentTypes:
             [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
                                            //
                    
                      NSDictionary *parameters = @{@"accessToken": self.myAccessToken , @"isIn" : @1 };
                      [manager POST:@"http://54.89.45.91/app/api/user/agent"
                         parameters:parameters
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      
                            NSLog(@"name  %@", responseObject[@"agents"]);
    
                                
                                
                                NSData *data = responseObject[@"agents"];
                                NSLog(@"Take this Dictionary %@", data);
                                
                                NSError *jsonError = nil;
                                
                                
                                if ([responseObject[@"agents"] isKindOfClass:[NSArray class]]) {
                                    NSLog(@"its an array!");
                                    NSArray *jsonArray = (NSArray *)responseObject[@"agents"];
                               //     NSLog(@"jsonArray - %@",jsonArray[0]);
                                    
                                    NSLog(@"Number of elements %i", [jsonArray count]);
                                    agentTableVC.agentArray = jsonArray;
                                }
                                else {
                                    NSLog(@"its probably a dictionary");
                                    NSDictionary *jsonDictionary = (NSDictionary *)responseObject[@"agents"];
                                    NSLog(@"jsonDictionary - %@",jsonDictionary);
                                }
                                
                                
                                
                                [agentTableVC.tableView reloadData];
                                
                            NSLog(@"JSON: %@", responseObject);
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"Error: %@", error);
                                }];
                      
                      
                      
                      
                      NSLog(@"JSON: %@", responseObject);
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", error);
                  }];
            
        }
    }
    
   NSLog(@"Last Test: %@", self.currentUser.accessToken);  
}
//-------------------------------------------------------------
////////////*******This chunk provides the scroll up****------

#define kOFFSET_FOR_KEYBOARD 220.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
  //  if ([sender isEqual:mailTf])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
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

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



//----------------------------------------------------------------------------------
////////////*******End of Scroll up block****---------------------------------------


#pragma implementing delegate method 








- (IBAction)joinButton:(UIButton *)sender { //when join button is pressed, everything in this button is pressed.
}

- (IBAction)loginButtonPressed:(UIButton *)sender {



    
    
    
}







@end








