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
#import "agentTableViewController.h"

@interface rshChatViewController ()
@end

@implementation rshChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    self.delegate = self;
    self.dataSource = self;
    
    countDown = self.transportCountDown;
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.agentNameForLabel = [self.agentSign stringByAppendingString:self.OponentName];
    
    timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    
   if (self.turnToSpeak == FALSE) {
        self.blockUser = [[UIView alloc] initWithFrame:CGRectMake(0, 430, self.view.frame.size.width, 260)];
        self.blockUser.backgroundColor = [UIColor remesh_GreenColor];
        [self.view addSubview:self.blockUser];
        
        [self.messageInputView resignFirstResponder];
        self.yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 60)];
        [self.yourLabel setTextColor:[UIColor whiteColor]];
        [self.yourLabel setBackgroundColor:[UIColor clearColor]];
        [self.yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 18.0f]];
        [self.blockUser addSubview:self.yourLabel];
       
       // yourLabel.text = [@"Awaiting response from " stringByAppendingString:self.OponentName];
       self.yourLabel.numberOfLines = 0;
       [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 490)];
    }
   else {
       
       self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(260,8,280,30)];
       [self.timeLabel setTextColor:[UIColor whiteColor]];
       [self.navigationController.navigationBar addSubview:self.timeLabel];
       
       
   }

    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
    self.messageInputView.textView.placeHolder = @"post thought...";
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    //loads convos a given agent is in.
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"limit" : @"10"};
    [manager POST:@"http://54.210.29.136/api/convos/messages/real" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([responseObject[@"messages"] isKindOfClass:[NSArray class]]) {
                  self.Messages = (NSArray *)responseObject[@"messages"];
                  [self.tableView reloadData];
              }
              else {
                  [self.tableView reloadData];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    }

-(void)tick {
    countDown--;
if (self.turnToSpeak == FALSE) {
        if (countDown > 0) {
           if (countDown < 60) {
               self.yourLabel.text = [self.agentNameForLabel stringByAppendingString:
               [[NSString stringWithFormat:@ " has %i", countDown]
                stringByAppendingString:@"s to respond"]];
           }
           else if (countDown > 60.0 && countDown < 3600.0){
               int mins = countDown / 60;
               self.yourLabel.text = [self.agentNameForLabel stringByAppendingString:
               [[NSString stringWithFormat:@" has %i", mins]
                stringByAppendingString:@"m to respond"]];
           }
           else {
               int hours = countDown / 3600;
               self.yourLabel.text =
               [self.agentNameForLabel stringByAppendingString:
               [[NSString stringWithFormat:@" has %i", hours]
                stringByAppendingString:@"h to respond"]];
           }
       }
       
        if (countDown == 0){
            [timer invalidate];
            self.transportCountDown = self.deltaT;
            self.turnToSpeak = TRUE;
            [self viewDidLoad];
            [self viewDidAppear:YES];
            [self.headerView removeFromSuperview];
                   }
        }
    else {
        
        if (countDown > 0) {
            if (countDown < 60) {
                self.timeLabel.text = [[NSString stringWithFormat:@ " %i", countDown]
                                        stringByAppendingString:@"s"];
            }
            else if (countDown > 60.0 && countDown < 3600.0){
                int mins = countDown / 60;
                self.timeLabel.text = [[NSString stringWithFormat:@ " %i", mins]
                                       stringByAppendingString:@"m"];            }
            else {
                int hours = countDown / 3600;
                self.timeLabel.text = [[NSString stringWithFormat:@ " %i", hours]
                                       stringByAppendingString:@"h"];;
            }
        }
        
        if (countDown == 0){
            [timer invalidate];
               self.transportCountDown = self.deltaT; //messy, but i don't have any better ideas.
            self.turnToSpeak = FALSE;
            [self.messageInputView resignFirstResponder];
            [self viewDidLoad];
            [self viewDidAppear:YES];
            [self.view addSubview:self.blockUser];
            [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
            [self.timeLabel removeFromSuperview];
        }
        
        
    }
    
    
        if (countDown < 0) {
            self.yourLabel.text = @"Loading"; 
        }
    
    }
    //you can set user here
    
    //nav bar title, so you'd put who you are currently chatting with..
    
//initial load complete/
    
    //data source method.
    
    //number of rows in previous table would be the number of conversations. 
    
    
-(void)viewDidDisappear:(BOOL)animated{
    [self.timeLabel removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.Messages count];
}


#pragma mark - tableView Delegate

-(void)didSendText:(NSString *)text {
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"thought" : text};
    [manager POST:@"http://54.210.29.136/api/convos/thoughts/send" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            if ([responseObject[@"choices"] isKindOfClass:[NSArray class]]) {
              self.Choices = (NSArray *)responseObject[@"choices"];
              self.ChoicePair = self.Choices[0];
              self.ChoiceOne = self.ChoicePair[@"choiceOne"];
              self.ChoiceTwo = self.ChoicePair[@"choiceTwo"];
              self.numberOfChoices = 1;
            }
        
            [self.messageInputView resignFirstResponder];
            [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
            self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 245, self.view.frame.size.width, 260)];
            self.choiceOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.choiceOneButton addTarget:self action:@selector(choiceOneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.choiceOneButton setFrame:CGRectMake(0, 0, 320, 130)];
            self.choiceOneButton.backgroundColor = [UIColor remesh_GreenColor];
            self.choiceOneButton.titleLabel.numberOfLines = 3;
            [self.choiceOneButton setTitle:self.ChoiceOne[@"text"] forState:UIControlStateNormal];
            [self.headerView addSubview:self.choiceOneButton];

            self.choiceTwoButton= [UIButton buttonWithType:UIButtonTypeCustom];
            [self.choiceTwoButton addTarget:self action:@selector(choiceTwoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.choiceTwoButton setFrame:CGRectMake(0, 134, 320, 130)];
            self.choiceTwoButton.backgroundColor = [UIColor remesh_GreenColor];
            self.choiceTwoButton.titleLabel.numberOfLines = 3;
            [self.choiceTwoButton setTitle:self.ChoiceTwo[@"text"] forState:UIControlStateNormal];
            self.headerView.backgroundColor = [UIColor whiteColor];
            [self.headerView addSubview:self.choiceTwoButton];
        
            [self.view addSubview:self.headerView];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

-(JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *messageSenderData = (self.Messages)[indexPath.row][@"sender"];

    if ([self.OponentName isEqual:messageSenderData[@"name"]]) {
        return JSBubbleMessageTypeIncoming;
    }
    else {
        return JSBubbleMessageTypeOutgoing;
    }
}

-(UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *messageSenderData = (self.Messages)[indexPath.row][@"sender"];
    if ([self.OponentName isEqual:messageSenderData[@"name"]]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];
    }
    else {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor remesh_GreenColor]];
    }
}

-(JSMessagesViewTimestampPolicy)timestampPolicy {
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
    if (indexPath.row == (1 + [self.Messages count])) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    }

    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    }
}

-(BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}

#pragma mark - Messages View Data Source REQUIRED
-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message; message = (self.Messages)[indexPath.row][@"text"];
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

#pragma mark - button functions

-(void) choiceOneButtonClicked: (UIButton*)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"acceptId" : self.ChoiceOne[@"id"], @"rejectId" : self.ChoiceTwo[@"id"]};
    
    [manager POST:@"http://54.210.29.136/api/convos/thoughts/choose"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];

    if ([self.Choices count] != self.numberOfChoices) {
        self.ChoicePair = self.Choices[self.numberOfChoices];
        self.ChoiceOne = self.ChoicePair[@"choiceOne"];
        self.ChoiceTwo = self.ChoicePair[@"choiceTwo"];
        [self.choiceOneButton setTitle:self.ChoiceOne[@"text"] forState:UIControlStateNormal];
        [self.choiceTwoButton setTitle:self.ChoiceTwo[@"text"] forState:UIControlStateNormal];
        self.numberOfChoices++;
    }
    else {
        NSDictionary *parametersTwo = @{@"accessToken": token, @"convoId" :self.thisConvoId };
        [manager POST:@"http://54.210.29.136/api/convos/thoughts"
           parameters:parametersTwo
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSNumber *pairs = responseObject[@"pairExists"];
              if([pairs isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {
                  [self reloadInputViews];
              }
              
              self.numberOfChoices = 1;
              self.Choices = (NSArray *)responseObject[@"choices"];
              self.ChoicePair = self.Choices[0];
              self.ChoiceOne = self.ChoicePair[@"choiceOne"];
              self.ChoiceTwo = self.ChoicePair[@"choiceTwo"];
              [self.choiceOneButton setTitle:self.ChoiceOne[@"text"] forState:UIControlStateNormal];
              [self.choiceTwoButton setTitle:self.ChoiceTwo[@"text"] forState:UIControlStateNormal];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    }
}

-(void) choiceTwoButtonClicked: (UIButton*)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    NSDictionary *parameters = @{@"accessToken": token, @"convoId" :self.thisConvoId, @"acceptId" : self.ChoiceTwo[@"id"], @"rejectId" : self.ChoiceOne[@"id"]};
    
    [manager POST:@"http://54.210.29.136/api/convos/thoughts/choose"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
    if ([self.Choices count] != self.numberOfChoices) {
        self.ChoicePair = self.Choices[self.numberOfChoices];
        self.ChoiceOne = self.ChoicePair[@"choiceOne"];
        self.ChoiceTwo = self.ChoicePair[@"choiceTwo"];
        [self.choiceOneButton setTitle:self.ChoiceOne[@"text"] forState:UIControlStateNormal];
        [self.choiceTwoButton setTitle:self.ChoiceTwo[@"text"] forState:UIControlStateNormal];
        self.numberOfChoices++;
    }
    else {
        NSDictionary *parametersTwo = @{@"accessToken": token, @"convoId" :self.thisConvoId };
        [manager POST:@"http://54.210.29.136/api/convos/thoughts"
           parameters:parametersTwo
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  self.numberOfChoices = 1;
                  NSNumber *pairs = responseObject[@"pairExists"];
                  if([pairs isEqualToNumber:@1]) {
                      [self reloadInputViews];
                  }
                  self.Choices = (NSArray *)responseObject[@"choices"];
                  self.ChoicePair = self.Choices[0];
                  self.ChoiceOne = self.ChoicePair[@"choiceOne"];
                  self.ChoiceTwo = self.ChoicePair[@"choiceTwo"];

                  [self.choiceOneButton setTitle:self.ChoiceOne[@"text"] forState:UIControlStateNormal];
                  [self.choiceTwoButton setTitle:self.ChoiceTwo[@"text"] forState:UIControlStateNormal];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              } ];
    }
}
@end