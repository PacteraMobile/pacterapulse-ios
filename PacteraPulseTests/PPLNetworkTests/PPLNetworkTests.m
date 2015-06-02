//
//  PPLNetworkTests.m
//  PacteraPulse
//
//  Created by Qazi on 02/06/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPLNetworkingHelper.h"

@interface PPLNetworkTests : XCTestCase
@property PPLNetworkingHelper *networkController;
@end

@implementation PPLNetworkTests

- (void)setUp
{
    [super setUp];
    _networkController = [PPLNetworkingHelper sharedClient];
    // Put setup code here. This method is called before the invocation of each
    // test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of
    // each test method in the class.
    [super tearDown];
}

- (void)testNetworkCalls
{
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
