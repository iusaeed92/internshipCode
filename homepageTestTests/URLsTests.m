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

@end
