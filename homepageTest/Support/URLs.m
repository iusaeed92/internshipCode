//
//  URLs.m
//  homepageTest
//
//  Created by Lincoln Dickerson on 8/8/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "URLs.h"

@implementation URLs

- (id)init {
    self.baseUrl = @"http://54.210.29.136/";
    self.apiTimeSyncUrl   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/time/sync" ];
    self.apiUserAgent     = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/user/agent"];
    self.apiUserAgentJoin = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/user/agent/join"];

    self.apiUserJoin   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/user/join"];
    self.apiUserLogin  = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/user/login"];
    self.apiUserLogout = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/user/logout"];

    self.apiConvosAgent          = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/agent"];
    self.apiConvosMessagesReal   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/messages/real"];
    self.apiConvosThoughts       = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts"];
    self.apiConvosThoughtsChoose = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts/choose"];
    self.apiConvosThoughtsSend   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts/send"];
    
    return self;
}
@end
