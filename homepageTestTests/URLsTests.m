//
//  URLsTests.m
//  URLsTests
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "URLs.h"

@interface URLsTests : XCTestCase
@property (strong, nonatomic) NSString *testBaseUrl;
@property (strong, nonatomic) URLs* remeshUrls;
@end

@implementation URLsTests

- (void)setUp
{
    [super setUp];
    self.remeshUrls = [ [URLs alloc] init];
    self.testBaseUrl = @"http://54.210.29.136/";
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testremeshBaseURL {
    XCTAssertTrue([self.remeshUrls.baseUrl isEqualToString: self.testBaseUrl],
                  @"base URLs should have matched");
}

- (void)testApiSyncTimeUrl {
    NSString *apiSyncTimeUrl = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/time/sync"];
    XCTAssertTrue([self.remeshUrls.apiTimeSyncUrl isEqualToString: apiSyncTimeUrl],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiTimeSyncUrl, apiSyncTimeUrl);
}

- (void)testApiUserAgent {
    NSString *apiUserAgent = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/user/agent"];
    XCTAssertTrue([self.remeshUrls.apiUserAgent isEqualToString: apiUserAgent],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiUserAgent, apiUserAgent);
}

- (void)testApiUserAgentJoin {
    NSString *apiUserAgentJoin = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/user/agent/join"];
    XCTAssertTrue([self.remeshUrls.apiUserAgentJoin isEqualToString: apiUserAgentJoin],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiUserAgentJoin, apiUserAgentJoin);
}

- (void)testApiUserJoin {
    NSString *apiUserJoin = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/user/join"];
    XCTAssertTrue([self.remeshUrls.apiUserJoin isEqualToString: apiUserJoin],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiUserJoin, apiUserJoin);
}

- (void)testApiUserLogin {
    NSString *apiUserLogin = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/user/login"];
    XCTAssertTrue([self.remeshUrls.apiUserLogin isEqualToString: apiUserLogin],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiUserLogin, apiUserLogin);
}

- (void)testApiUserLogout {
    NSString *apiUserLogout = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/user/logout"];
    XCTAssertTrue([self.remeshUrls.apiUserLogout isEqualToString: apiUserLogout],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiUserLogout, apiUserLogout);
}

//self.apiConvosAgent          = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/agent"];
//self.apiConvosMessagesReal   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/messages/real"];
//self.apiConvosThoughts       = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts"];
//self.apiConvosThoughtsChoose = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts/choose"];
//self.apiConvosThoughtsSend   = [NSString stringWithFormat:@"%@%@", self.baseUrl, @"api/convos/thoughts/send"];

@end
