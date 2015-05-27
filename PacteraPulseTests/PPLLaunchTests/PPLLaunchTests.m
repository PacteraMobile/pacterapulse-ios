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
#import "AppDelegate.h"
#import "PPLLaunchViewController.h"
#import "PPLVoteViewController.h"
@interface PPLLaunchTests : XCTestCase

@end

@implementation PPLLaunchTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each
    // test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of
    // each test method in the class.
    [super tearDown];
}

- (void)testCheckFirstLaunchMarked
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if ([prefs boolForKey:kLauchFirstTime])
    {
        [prefs removeObjectForKey:kLauchFirstTime];
    }
    [delegate markFirstLaunch];
    XCTAssertFalse([delegate checkFirstLaunch]);
}

- (void)testSkipLaunchScreenOnSecondLaunch
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate checkFirstLaunch])
    {
        XCTAssertTrue([[delegate selectRootViewController]
            isKindOfClass:[PPLLaunchViewController class]]);
    }
    else
    {
        XCTAssertTrue([[delegate selectRootViewController]
            isKindOfClass:[PPLVoteViewController class]]);
    }
}

@end
