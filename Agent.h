//
//  Agent.h
//  homepageTest
//
//  Created by ibs on 6/23/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//


//agent class declaration/
//an agent is either a Mesh or a Person, and the conversation or crowdversation is typically between 2 agents.



#import <Foundation/Foundation.h>

@interface Agent : NSObject

@property (strong, nonatomic) NSString *agentId; // id unique to each agent

@property (strong, nonatomic) NSString *agentName; // agent name

@property (strong, nonatomic) NSString *agentMind; // mind, mesh or person

@property (nonatomic) int agentSize;// size, how many people belong to it, this only matters if the agent is a mesh
@property (nonatomic) int numberOfConversations; //number of activeConvos the agent is in



@end
