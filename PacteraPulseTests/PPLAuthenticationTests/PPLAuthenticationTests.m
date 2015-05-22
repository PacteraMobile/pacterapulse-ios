//
//  PPLAuthenticationTests.m
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPLAuthenticationSettings.h"
#import "PPLAuthenticationController.h"
@interface PPLAuthenticationTests : XCTestCase

@end

@implementation PPLAuthenticationTests

- (void)setUp {
    [super setUp];
    //TODO: add proper implementation
}

- (void)tearDown {
    //TODO: add proper implementation
    [super tearDown];
}

- (void)testLogin{
    //TODO: add proper implementation
    XCTAssert(YES, @"Pass");
}

- (void)testLogout{
    //TODO: add proper implementation
    PPLAuthenticationController *controller = [PPLAuthenticationController sharedInstance];
    
    [controller logoutUser];
    
    XCTAssertFalse([controller checkIfLoggedIn:nil]);
}

- (void)testIfLoggedIn{
    //TODO: add proper implementation
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAuthenticationSettingsLoad
{

    PPLAuthenticationSettings *settings = [PPLAuthenticationSettings loadSettings];
    
    //TODO: add proper implementation
    XCTAssert(YES, @"Pass");

}

@end
