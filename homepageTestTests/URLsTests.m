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

@end

@implementation URLsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testremeshBaseURL
{
    URLs *baseUrl = [ [URLs alloc] init];
    NSString *baseURLString = @"http://54.210.29.136";
    XCTAssertEqual(baseUrl.base_url, baseURLString, @"URLs should have matched");
}

@end
