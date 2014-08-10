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

- (void)testApiConvosAgent {
    NSString *apiConvosAgent = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/convos/agent"];
    XCTAssertTrue([self.remeshUrls.apiConvosAgent isEqualToString: apiConvosAgent],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiConvosAgent, apiConvosAgent);
}

- (void)testApiConvosMesssagesReal {
    NSString *apiConvosMessagesReal = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/convos/messages/real"];
    XCTAssertTrue([self.remeshUrls.apiConvosMessagesReal isEqualToString: apiConvosMessagesReal],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiConvosMessagesReal, apiConvosMessagesReal);
}

- (void)testApiConvosThoughts {
    NSString *apiConvosThoughts = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/convos/thoughts"];
    XCTAssertTrue([self.remeshUrls.apiConvosThoughts isEqualToString: apiConvosThoughts],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiConvosThoughts, apiConvosThoughts);
}

- (void)testApiConvosThoughtsChoose {
    NSString *apiConvosThoughtsChoose = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/convos/thoughts/choose"];
    XCTAssertTrue([self.remeshUrls.apiConvosThoughtsChoose isEqualToString: apiConvosThoughtsChoose],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiConvosThoughtsChoose, apiConvosThoughtsChoose);
}

- (void)testApiConvosThoughtsSend {
    NSString *apiConvosThoughtsSend = [NSString stringWithFormat:@"%@%@", self.testBaseUrl, @"api/convos/thoughts/send"];
    XCTAssertTrue([self.remeshUrls.apiConvosThoughtsSend isEqualToString: apiConvosThoughtsSend],
                  @"URLs should have matched [%@][%@]", self.remeshUrls.apiConvosThoughtsSend, apiConvosThoughtsSend);
}

@end
