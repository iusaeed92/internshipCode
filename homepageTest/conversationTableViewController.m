//
//  conversationTableViewController.m
//  homepageTest
//
//  Created by ibs on 6/25/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "conversationTableViewController.h"
#import "conversationTableViewCell.h"
#import <SSKeychain/SSKeychain.h>
#import <AFNetworking/AFNetworking.h>

@interface conversationTableViewController ()

@end

@implementation conversationTableViewController

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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    
    NSDictionary *parameters = @{@"accessToken": token, @"agentId" :self.agentID};
    [manager POST:@"http://54.89.45.91/app/api/convos/agent" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Convos %@", responseObject[@"convos"]);
        
        if ([responseObject[@"convos"] isKindOfClass:[NSArray class]]) {
            NSLog(@"its an array!");
            NSArray *jsonArray = (NSArray *)responseObject[@"convos"];
            NSLog(@"jsonArray - %@",jsonArray[0]);
            
            NSLog(@"Number of elements %i", [jsonArray count]);
            self.convosArray = jsonArray;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"its probably a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)responseObject[@"convos"];
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
        
        
        
        //NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];






}

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
    
   
    return [self.convosArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    conversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[conversationTableViewCell alloc] init];
    }
    
    UIImage *greenCircleImage = [UIImage imageNamed:@"GreenCircle.png"];
    UIImage *redCircleImage = [UIImage imageNamed:@"RedCircle.png"];
    
    
    
    
   
    
    
    NSString *topicSign = @"#";
    NSString *topicName = [topicSign stringByAppendingString:[[self.convosArray objectAtIndex:indexPath.row] objectForKey:@"topic"]];
    
    cell.customStoryTitleLabel.text = topicName;
    
    NSDictionary *thisConvoDetails = [[self.convosArray objectAtIndex:indexPath.row] objectForKey:@"lastMessage"];
    
    
    
    
    
    
    NSDictionary *oponentData = [[self.convosArray objectAtIndex:indexPath.row] objectForKey:@"opponent"];
    
    NSDictionary *senderData = thisConvoDetails[@"sender"];
    
    if ([senderData[@"name"] isEqual:oponentData[@"name"]]) {
         cell.customImageView.image = greenCircleImage;
    }
    else {
        cell.customImageView.image = redCircleImage;
    }
    
    
    
    //determining if opponent is mesh or user.
        if ([oponentData[@"mind"] isEqual: @"mesh"]) {
            NSString *meshSign = @"<";
            NSString *meshName = oponentData[@"name"];
            cell.customAgentNameLabel.text = [meshSign stringByAppendingString:meshName];
            }
        else {
            
            NSString *userSign = @"@";
            NSString *userName = oponentData[@"name"];
            cell.customAgentNameLabel.text = [userSign stringByAppendingString:userName];
            
        }
    
    
    
    
    cell.customTextView.text = thisConvoDetails[@"text"];
   // NSLog(@"Date %@",[NSDate new]);
    
     NSTimeInterval deltaTime = [[[self.convosArray objectAtIndex:indexPath.row] objectForKey:@"deltaT"] doubleValue];
   
    
    
    NSDate *currentTime = [NSDate date];
    NSString *lastMessageTime = thisConvoDetails[@"timestamp"];
    
    
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    [objDateFormatter setDateFormat:@"yyyy - MM - dd HH:mm:ss Z"];
  NSDate *tester = [objDateFormatter dateFromString:lastMessageTime];

    [objDateFormatter stringFromDate:currentTime];
    NSLog(@"Last Message time stamp string %@", lastMessageTime);
    NSLog(@"Last message time stamp Date %@", tester);
   
    
    //NSDate *currentActualDate = [objDateFormatter dateFromString:currentTime];
    //NSLog(@"current time 2 %@", currentActualDate);
 
    NSDate *lastPlusDelta = [tester dateByAddingTimeInterval:deltaTime];
    
    
    NSLog(@"Delta Seconds %f", deltaTime);
    NSLog(@"current time %@", currentTime);
    NSLog(@"last plus delta %@", lastPlusDelta);
    NSTimeInterval secondsBetween = [lastPlusDelta timeIntervalSinceNow];
    NSLog(@"Time till next message %f", secondsBetween);
    double hours = secondsBetween / 3600.0;
    double mins = secondsBetween / 60.0;
    NSLog(@"Seconds %f", secondsBetween);
    NSLog(@"Minutes: %f", mins);
    NSLog(@"Hours: %f", hours);
    if (secondsBetween < 60.0) {
        NSLog(@"Seconds %f", secondsBetween);
        NSString *secondString = [[NSString alloc] initWithFormat:@"%.2f", secondsBetween];
        cell.customTimeLabel.text =[secondString stringByAppendingString:@"s"];
    }
    else if (secondsBetween > 60.0 && secondsBetween < 3600.0){
        NSLog(@"Minutes: %f", mins);
        NSString *minuteString = [[NSString alloc] initWithFormat:@"%.2f", mins];
        NSLog(@"Minute String: %@", minuteString);
        cell.customTimeLabel.text =[minuteString stringByAppendingString:@"m"];
    }
    else {
         NSLog(@"Hours %f", hours);
        NSString *hourString = [[NSString alloc] initWithFormat:@"%.2f", hours];
        cell.customTimeLabel.text = [hourString stringByAppendingString:@"h"];
    }
    
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
