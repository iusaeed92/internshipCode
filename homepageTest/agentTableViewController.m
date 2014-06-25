//
//  agentTableViewController.m
//  homepageTest
//
//  Created by ibs on 6/20/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "agentTableViewController.h"

@interface agentTableViewController ()

@end

@implementation agentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    NSLog(@"latest Test %@", self.theAccessToken);
    
    UIColor *myGreen =
    [UIColor colorWithRed:(40.0/255.0) green:(159.0/255.0) blue:(90.0/255.0) alpha:1.0];
    self.navigationController.navigationBar.barTintColor = myGreen;
    
    
    [self.navigationController setNavigationBarHidden:NO];

    
    //lets try and play with the agents API route. 
    
    self.thisUser = [[User alloc] init];
    
    
    [self.tableView reloadData]; 
    NSLog(@"latest Test %@", self.theAccessToken);
    
  //  NSLog(@"OBJECT access Token:%@", self.thisUser.accessToken);
    
//    
//
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:
//     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
//    
//    
//    
//    
//    NSDictionary *parameters = @{@"accessToken": self.theAccessToken , @"inIn" : @"1"};
//    
//    [manager POST:@"http://54.89.45.91/app/api/user/agent"
//       parameters:parameters
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              
//              //   NSLog(@"Access Token%@", responseObject[@"accessToken"]);
//              
//             NSLog(@"JSON: %@", responseObject);
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"Error: %@", error);
//          }];
//    
//    
//    
//    
//    
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.agentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    cell.textLabel.text = [[self.agentArray objectAtIndex:indexPath.row] objectForKey:@"name"];
   
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
