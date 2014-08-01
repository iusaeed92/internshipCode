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
#import "rshChatViewController.h"

@interface conversationTableViewController ()
@end

@implementation conversationTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
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
    [manager POST:@"http://54.89.45.91/app/api/convos/agent" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([responseObject[@"convos"] isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject[@"convos"];
                  self.convosArray = jsonArray;
                  [self.tableView reloadData];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSDictionary *parameter = @{};
    [manage POST:@"http://54.89.45.91/app/api/time/sync" parameters:parameter
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSString *serverTime = [responseObject[@"serverTime"] stringByAppendingString:@" +0300"];
             NSLog(@"serveTime : %@", serverTime);
             NSDateFormatter *oDateFormatter = [[NSDateFormatter alloc] init];
             [oDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
             [oDateFormatter setDateFormat:@"yyyy - MM - dd HH:mm:ss Z"];
             self.serverCurrentDate = [oDateFormatter dateFromString:serverTime];
             self.offset = [self.serverCurrentDate timeIntervalSinceNow];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
       }
     ];
}

-(void)viewWillAppear:(BOOL)animated {
    countDown = 0;
    [timer invalidate];
}

-(void)viewWillDisappear:(BOOL)animated {
    countDown = 0;
    [timer invalidate];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.convosArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    conversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[conversationTableViewCell alloc] init];
    }
    
    UIImage *greenCircleImage = [UIImage imageNamed:@"GreenCircle.png"];
    UIImage *redCircleImage   = [UIImage imageNamed:@"RedCircle.png"];
    
    UIColor *myGreen = [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    UIColor *myRed   = [UIColor colorWithRed:(238.0/255.0) green:(61.0/255.0) blue:(14.0/255.0) alpha:1.0];
    
    //Configuring topic label
    NSString *topicSign = @"#";
    NSString *topicName = [topicSign stringByAppendingString:
                           (self.convosArray)[indexPath.row][@"topic"]];
    cell.customStoryTitleLabel.text = topicName;
    
    //Conversation data retrieval from Array
    NSDictionary *thisConvoDetails =
    (self.convosArray)[indexPath.row][@"lastMessage"];
    NSDictionary *oponentData = (self.convosArray)[indexPath.row][@"opponent"];
    
    //Deducing who's turn to speak it is
    NSNumber *speakingStatus = (self.convosArray)[indexPath.row][@"speaking"];
    if ([speakingStatus isEqual:@1]) {
        cell.customImageView.image = greenCircleImage;
        cell.customTimeLabel.textColor = myGreen;
        self.turnToSpeak = TRUE;
    }
    else {
        cell.customImageView.image = redCircleImage;
        cell.customTimeLabel.textColor = myRed;
        self.turnToSpeak = FALSE;
    }

    if ([oponentData[@"mind"] isEqual: @"mesh"]) {
        NSString *meshSign = @"<";
        NSString *meshName = oponentData[@"name"];
        cell.customAgentNameLabel.text =
        [meshSign stringByAppendingString:meshName];
    }
    else {
        NSString *userSign = @"@";
        NSString *userName = oponentData[@"name"];
        cell.customAgentNameLabel.text =
        [userSign stringByAppendingString:userName];
    }
    
    //configuring most recent messahe view
    cell.customTextLabelView.text = thisConvoDetails[@"text"];
    
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    [objDateFormatter setDateFormat:@"yyyy - MM - dd HH:mm:ss Z"];
    
    NSString *nextMessageTime =
    (self.convosArray)[indexPath.row][@"nextMessageTime"];
    NSDate *nextMessageDate = [objDateFormatter dateFromString:nextMessageTime];
    NSLog(@"serverDate %@", self.serverCurrentDate);
    NSLog(@"NMD Server %@", nextMessageDate);
    
    NSDate *newNextMessageDate = [nextMessageDate dateByAddingTimeInterval:(-1*self.offset)];
    NSTimeInterval secondsBetween = [newNextMessageDate timeIntervalSinceNow];
    countDown = secondsBetween;
    cell.customCellCountdown = secondsBetween;
    
    timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    if (countDown > 0) {
        if (countDown < 60) {
            cell.customTimeLabel.text = [[NSString stringWithFormat:@"%i", countDown] stringByAppendingString:@"s"];
        }
        else if (secondsBetween > 60.0 && secondsBetween < 3600.0){
            int mins = countDown / 60;
            cell.customTimeLabel.text =
            [[NSString stringWithFormat:@"%i", mins] stringByAppendingString:@"m"];
        }
        else {
            int hours = countDown / 3600;
            cell.customTimeLabel.text =
            [[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@"h"];
        }
    }
    else {
        cell.customTimeLabel.text = nil;
    }
    return cell;
}

-(void)tick {
    countDown--;
    [self.tableView reloadData];
    if (countDown < 0)
        [timer invalidate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ }

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    conversationTableViewCell *CellForSegue = sender;

    rshChatViewController *chatVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    chatVC.thisConversation = (self.convosArray)[indexPath.row];
    chatVC.thisConvoId = (self.convosArray)[indexPath.row][@"convoId"];
    NSLog(@"To chat: %@", chatVC.thisConversation);
    NSDictionary *oponentData = (self.convosArray)[indexPath.row][@"opponent"];
    chatVC.OponentName = oponentData[@"name"];
    chatVC.transportCountDown = CellForSegue.customCellCountdown;
    
    if ([oponentData[@"mind"] isEqual: @"mesh"]) {
        chatVC.agentSign = @"<";
    }
    else {
        chatVC.agentSign = @"@";
    }

    NSNumber *speakingStatus = (self.convosArray)[indexPath.row][@"speaking"];
    if ([speakingStatus isEqual:@1]) {
        self.turnToSpeak = TRUE;
    }
    else {
        self.turnToSpeak = FALSE;
    }
    
    chatVC.title = (self.convosArray)[indexPath.row][@"topic"];
    chatVC.turnToSpeak = self.turnToSpeak;
    chatVC.speakingStatus = (self.convosArray)[indexPath.row][@"speaking"] ;
    NSLog(@"Convo ID is %@", chatVC.thisConvoId);
}

@end