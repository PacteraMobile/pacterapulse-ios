//  Copyright (c) 2015 Pactera. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS
// OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
// ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A
// PARTICULAR PURPOSE, MERCHANTABILITY OR NON-INFRINGEMENT.
//
// See the Apache License, Version 2.0 for the specific language
// governing permissions and limitations under the License.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPLAuthenticationSettings.h"
#import "PPLAuthenticationController.h"
@interface PPLAuthenticationTests : XCTestCase

@end

@implementation PPLAuthenticationTests

- (void)setUp
{
    [super setUp];
    // TODO: add proper implementation
}

- (void)tearDown
{
    // TODO: add proper implementation
    [super tearDown];
}

- (void)testLogin
{
    // TODO: add proper implementation
    XCTAssert(YES, @"Pass");
}

- (void)testLogout
{
    // TODO: add proper implementation
    PPLAuthenticationController *controller =
        [PPLAuthenticationController sharedInstance];

    [controller logoutUser];

    XCTAssertFalse([controller checkIfLoggedIn:nil]);
}

- (void)testIfLoggedIn
{
    // TODO: add proper implementation
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAuthenticationSettingsLoad
{

    PPLAuthenticationSettings *settings =
        [PPLAuthenticationSettings loadSettings];

    // TODO: add proper implementation
    XCTAssert(YES, @"Pass");
}

@end
