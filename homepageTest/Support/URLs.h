//
//  URLs.h
//  homepageTest
//
//  Created by Lincoln Dickerson on 8/8/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLs : NSObject

@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSString *apiTimeSyncUrl;
@property (strong, nonatomic) NSString *apiUserAgent;
@property (strong, nonatomic) NSString *apiUserAgentJoin;

@property (strong, nonatomic) NSString *apiUserJoin;
@property (strong, nonatomic) NSString *apiUserLogin;
@property (strong, nonatomic) NSString *apiUserLogout;

@property (strong, nonatomic) NSString *apiConvosAgent;
@property (strong, nonatomic) NSString *apiConvosMessagesReal;
@property (strong, nonatomic) NSString *apiConvosThoughts;
@property (strong, nonatomic) NSString *apiConvosThoughtsChoose;
@property (strong, nonatomic) NSString *apiConvosThoughtsSend;

@end