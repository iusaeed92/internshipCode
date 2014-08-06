
//  agentTableViewController.m
//  homepageTest
//
//  Created by ibs on 6/20/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "agentTableViewController.h"
#import "conversationTableViewController.h"
#import <SSKeychain/SSKeychain.h>

@interface agentTableViewController ()

@end

@implementation agentTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    UIColor *myGreen =
    [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    self.navigationController.navigationBar.barTintColor = myGreen;
    // Uncomment the following line to preserve selection between presentations
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    
    self.tableViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 430, self.view.frame.size.width, 80)];
    [self.tableViewFooter setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.toolbarHidden = NO;
    self.navigationController.navigationBar.barTintColor = myGreen;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
        @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.tableView setBackgroundColor:myGreen];
    
    self.thisUser = [[User alloc] init];
    
    [self.tableView reloadData];
    [self loadAgents];

}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.agentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    agentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[agentTableViewCell alloc] init];
    }

    UIColor *myGreen = [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    cell.customMaskImageView.image = [UIImage imageNamed:@"mask_white_22x22-01.png"];
    [cell setBackgroundColor:myGreen];
    
    //if Mesh, display in green and display '<' before agent name.
    if ([(self.agentArray)[indexPath.row][@"mind"]  isEqual: @"mesh"]) {
        
        cell.customMeshNameLabel.textColor = [UIColor whiteColor];
        NSString *meshSign = @"<";
        NSString *meshName = [meshSign stringByAppendingString:(self.agentArray)[indexPath.row][@"name"]];

        cell.customCountMeshLabel.textColor = [UIColor whiteColor];
        cell.customMeshNameLabel.text = meshName;
        NSNumber *meshSize = (self.agentArray)[indexPath.row][@"size"];
        
        NSString *textForSize = [NSString stringWithFormat:@"%@", meshSize, nil];
        NSLog(@"Size :%@", meshSize);
        cell.customCountMeshLabel.text = textForSize; 
        NSLog(@"Agent: %@", self.agentArray[indexPath.row]);
    }
    else {
        cell.customMeshNameLabel.text = [@"@" stringByAppendingString:(self.agentArray)[indexPath.row][@"name"]];
        cell.customMeshNameLabel.textColor = [UIColor whiteColor];
        cell.customCountMeshLabel.text = nil;
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //introspection, making sure what kind of class it is
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        if ([segue.destinationViewController isKindOfClass:[conversationTableViewController class]]) {
            //passing details forward so AF call can be made in ConvoTableVC.
            conversationTableViewController *ConvoTableVC = segue.destinationViewController;
            ConvoTableVC.path = [self.tableView indexPathForCell:sender];
            ConvoTableVC.currentAgent = self.agentArray[ConvoTableVC.path.row];
            ConvoTableVC.agentID = (self.agentArray)[ConvoTableVC.path.row][@"id"];
            ConvoTableVC.title = (self.agentArray)[ConvoTableVC.path.row][@"name"];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { }

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (IBAction)buttonToAddAgent:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddAgentsView" sender:self];
}

- (IBAction)HelpButtonPressed:(UIBarButtonItem *)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Options:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Help",
                            @"Logout",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)logOut {
    NSDictionary *parameters = @{@"accessToken": self.accessToken};
AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    [manager POST:@"http://54.210.29.136/api/user/logout"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
              [SSKeychain deletePasswordForService:@"Remesh" account:userName];
              
              [self performSegueWithIdentifier:@"backToLogin" sender:self];

          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self Help];
                    break;
                case 1:
                    [self logOut];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

-(void)Help {
    [self performSegueWithIdentifier:@"toHelpView" sender:self];
}

-(void)newAccesToken {
    
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *password = [SSKeychain passwordForService:@"Error_2" account:username];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSDictionary *parameters = @{@"username": username, @"password" : password};
    [manager POST:@"http://54.210.29.136/api/user/login"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              self.accessToken = responseObject[@"accessToken"];
              [SSKeychain setPassword:password forService:@"Error_2" account:username];
              [SSKeychain setPassword:self.accessToken forService:@"Remesh" account:username];
             
              [self loadAgents];
              //[self.tableView reloadData];
              NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

-(void)loadAgents {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    self.accessToken = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    
    NSLog(@"Username %@", userName);
    NSDictionary *parameters = @{@"accessToken": self.accessToken , @"isIn" : @"1"};
    [manager POST:@"http://54.210.29.136/api/user/agent"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              
              NSNumber *errorCode = [responseObject objectForKey:@"errorCode"];
              NSLog(@"error:%@", errorCode);
              if ([errorCode isEqual:[[NSNumber alloc] initWithInt:2]]) {
                  [self newAccesToken];
              }
              
              if ([responseObject[@"agents"] isKindOfClass:[NSArray class]]) {
                  NSLog(@"its an array!");
                  NSArray *jsonArray = (NSArray *)responseObject[@"agents"];
                  self.agentArray = jsonArray;
                  [self.tableView reloadData];
              }
              else {
                  NSLog(@"its probably a dictionary");
                  NSDictionary *jsonDictionary = (NSDictionary *)responseObject[@"agents"];
                  NSLog(@"jsonDictionary - %@",jsonDictionary);
              }
              NSLog(@"JSON:  %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];

    
}



@end

