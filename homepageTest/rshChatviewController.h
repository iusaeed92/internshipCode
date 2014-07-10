//
//  rshChatViewController.h
//  homepageTest
//
//  Created by ibs on 6/18/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "JSMessagesViewController.h"





@interface rshChatViewController : JSMessagesViewController <JSMessagesViewDataSource , JSMessagesViewDelegate>

@property (strong, nonatomic) NSArray *thisConversation;

@property (strong, nonatomic) NSString *thisConvoId;

@property (strong, nonatomic) NSArray *Messages;


@property (strong, nonatomic) NSString *OponentName; 



@end
