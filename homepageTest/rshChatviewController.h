//
//  rshChatViewController.h
//  homepageTest
//
//  Created by ibs on 6/18/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "JSMessagesViewController.h"





@interface rshChatViewController : JSMessagesViewController <JSMessagesViewDataSource , JSMessagesViewDelegate>{
    
    int countDown;
    NSTimer *timer;
    
}

@property (strong, nonatomic) NSArray *thisConversation;

@property (strong, nonatomic) NSString *thisConvoId;

@property (strong, nonatomic) NSArray *Messages;

@property (strong, nonatomic) NSArray *Choices;

@property (strong, nonatomic) NSDictionary *ChoicePair; 

@property (strong, nonatomic) NSDictionary *ChoiceOne;

@property (strong, nonatomic) NSDictionary *ChoiceTwo; 

@property (strong, nonatomic) NSString *OponentName;

@property (nonatomic) int numberOfChoices;

@property (nonatomic) BOOL turnToSpeak;

@property (nonatomic) int transportCountDown;

@property (strong, nonatomic) UIButton *choiceOneButton;

@property (strong, nonatomic) UIButton *choiceTwoButton;

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) NSNumber *speakingStatus; 

@property (nonatomic) id cellFromAgent;

@property (strong, nonatomic) NSString *agentSign;

@property (strong, nonatomic) NSString *agentNameForLabel;


@property (strong, nonatomic) UILabel *yourLabel;


@end
