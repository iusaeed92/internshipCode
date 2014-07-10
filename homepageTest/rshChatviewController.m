//
//  rshChatViewController.m
//  homepageTest
//
//  Created by ibs on 6/18/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "rshChatViewController.h"
#import <SSKeychain/SSKeychain.h>
#import <AFNetworking/AFNetworking.h>



@interface rshChatViewController ()

@end

@implementation rshChatViewController

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
    
    self.delegate = self;
    self.dataSource = self;
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
  

    
    
    
    
    
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
    self.messageInputView.textView.placeHolder = @"Mesh!";
    
    [self setBackgroundColor:[UIColor whiteColor]]; 
 
    
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    //loads convos a given agent is in.
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"limit" : @"10"};
    [manager POST:@"http://54.89.45.91/app/api/convos/messages" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"messages %@", responseObject[@"messages"]);
        
        if ([responseObject[@"messages"] isKindOfClass:[NSArray class]]) {
            NSLog(@"its an array!");
            self.Messages = (NSArray *)responseObject[@"messages"];
            NSLog(@"jsonArray - %@", self.Messages[0]);
            
            NSLog(@"Number of elements are%i", [self.Messages count]);
            [self.tableView reloadData];
        }
        else {
            NSLog(@"its probably a dictionary");
           // self.Messages = (NSDictionary *)responseObject[@"messages"];
           // NSLog(@"jsonDictionary - %@", self.Messages);
            [self.tableView reloadData];
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    //you can set user here
    
    //nav bar title, so you'd put who you are currently chatting with..
    
//initial load complete/
    
    //data source method.
    
    //number of rows in previous table would be the number of conversations. 
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -TableView DataSource



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.Messages count];

}


#pragma mark - tableView Delegate

-(void)didSendText:(NSString *)text{
    
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"thought" : text};
    [manager POST:@"http://54.89.45.91/app/api/convos/thoughts/send" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"The choices are...  %@", responseObject[@"choices"]);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSLog(@"its an array!");
            NSArray *jsonArray = (NSArray *)responseObject[@"agents"];
              NSLog(@"jsonArray - %@",jsonArray[0]);
            
//            NSLog(@"Number of elements %i", [jsonArray count]);
//            self.agentArray = jsonArray;
//            [self.tableView reloadData];
        }
        else {
            NSLog(@"its probably a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
        
        
        
        
        NSLog(@"JSON: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    
}




-(JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //here you want to figure out who is doing the sending
    
    
    //here depending on who is doing the sending, you will return a j
    
    
    NSDictionary *messageSenderData = [[self.Messages objectAtIndex:indexPath.row] objectForKey:@"sender"];
    
    
    
    
    if ([self.OponentName isEqual:messageSenderData[@"name"]]) {
    return JSBubbleMessageTypeIncoming;
    }
    else {
    return JSBubbleMessageTypeOutgoing;
    }
}


-(UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //you want access to chat and who you're getting message from
    
    //if you are sending it...
    
    NSDictionary *messageSenderData = [[self.Messages objectAtIndex:indexPath.row] objectForKey:@"sender"];
    
   
    
    
    if ([self.OponentName isEqual:messageSenderData[@"name"]]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];
      }
  
    else {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor remesh_GreenColor]];
    }
    
}


-(JSMessagesViewTimestampPolicy)timestampPolicy{
    
    return JSMessagesViewTimestampPolicyAll;
}


-(JSMessagesViewAvatarPolicy)avatarPolicy {
    
    
    return JSMessagesViewAvatarPolicyNone;
    

}



-(JSMessagesViewSubtitlePolicy)subtitlePolicy {
    
    return JSMessagesViewSubtitlePolicyNone;
}


-(JSMessageInputViewStyle)inputViewStyle {
    
    return JSMessageInputViewStyleFlat; 
}




#pragma mark - Messahe View delegate optional


-(void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    
    }
}



-(BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}


#pragma mark - Messages View Data Source REQUIRED

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    NSString *message = [[self.Messages objectAtIndex:indexPath.row] objectForKey:@"text"];

    //[self.Messages objectForKey:@"text"];
    return message;
}


-(NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
    
}

-(UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  nil;
}

-(NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil; 
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



//will abe a didSendText button, which is what should happen when the user presses send. 
//refer to lecture 349.



//Lecture 50 onwards essential.






