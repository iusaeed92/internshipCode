//
//  RootViewController.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 7/1/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "RootViewController.h"
#import "rshViewController.h"
#import <SSKeychain/SSKeychain.h>
#import "agentTableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    
   // this is to display login page if there's no access token available.
    // 
 
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    if ([token length] != 0) {
        
        agentTableViewController *agentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"agentVC"];
        UINavigationController *navigationViewController =
        [[UINavigationController alloc] initWithRootViewController:agentVC];
        [self addChildViewController:navigationViewController];
        [navigationViewController didMoveToParentViewController:self];
        [self.view addSubview:navigationViewController.view];

    }
    else{
        UINavigationController *navigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationVC"];
        [self addChildViewController:navigationViewController];
        [navigationViewController didMoveToParentViewController:self];
        [self.view addSubview:navigationViewController.view];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
