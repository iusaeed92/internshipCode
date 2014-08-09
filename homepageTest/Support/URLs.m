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
    self.apiTimeSyncUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/time/sync"];
    //    self.api_time_sync_url = [NSString stringWithFormat:@"%@%@", self.base_url, @"http://54.210.29.136/api/time/sync"];
    return self;
}

//
//

//@"http://54.210.29.136/api/user/agent"
//@"http://54.210.29.136/api/user/agent/join"

//@"http://54.210.29.136/api/user/join"
//@"http://54.210.29.136/api/user/login"
//@"http://54.210.29.136/api/user/logout"

//@"http://54.210.29.136/api/convos/messages/real"

//@"http://54.210.29.136/api/convos/agent"
//@"http://54.210.29.136/api/convos/thoughts"
//@"http://54.210.29.136/api/convos/thoughts/choose"
//@"http://54.210.29.136/api/convos/thoughts/send"
//

@end
