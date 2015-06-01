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
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import "PPLVoteManagerClass.h"
#import "PPLUtils.h"
/**
 *  Tests for the Vote manager functions
 */
@interface PPLVoteManagerTests : XCTestCase

@end

@implementation PPLVoteManagerTests

// Variable to keep the initial values already in userDefaults
id valueForFeedback = nil;
id valueForDate = nil;

/**
 *  In setup we get the default values of the userDefaults and save it for
 *  restoration
 */
- (void)setUp {
  [super setUp];

  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];

  valueForDate = [prefs objectForKey:FEEDBACK_DATE_KEY];
  valueForFeedback = [prefs objectForKey:FEEDBACK_VALUE_KEY];

  [prefs removeObjectForKey:FEEDBACK_VALUE_KEY];
  [prefs removeObjectForKey:FEEDBACK_DATE_KEY];

  [prefs synchronize];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
}
/**
 *  In teardown we restore the original values
 */
- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of
  // each test method in the class.
  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];

  [prefs setObject:valueForFeedback forKey:FEEDBACK_VALUE_KEY];
  [prefs setObject:valueForDate forKey:FEEDBACK_DATE_KEY];

  [super tearDown];
}

/**
 *  This function checks if the submission is noted by voteManager in
 *  userDefaults
 */
- (void)testSubmissionVoteNoted {
  // This is an example of a functional test case.

  PPLVoteManagerClass *testClass = [PPLVoteManagerClass sharedInstance];

  XCTAssertFalse([testClass checkIfVoteSubmittedToday]);

  [testClass recordVoteSubmission:@"1"];

  XCTAssertTrue([testClass checkIfVoteSubmittedToday]);
}
/**
 *  This function checks if the check for vote today function works properly
 */
- (void)testCheckIfVoteSubmitted {
  // This is an example of a functional test case.

  PPLVoteManagerClass *testClass = [PPLVoteManagerClass sharedInstance];
  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];

  [prefs setObject:[NSDate date] forKey:FEEDBACK_DATE_KEY];
  [prefs setObject:valueForFeedback forKey:FEEDBACK_VALUE_KEY];

  XCTAssertTrue([testClass checkIfVoteSubmittedToday]);

  // Create a date in past
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:1];
  [comps setMonth:1];
  [comps setYear:2015];

  // Set it in preferences
  [prefs setObject:[[NSCalendar currentCalendar] dateFromComponents:comps]
            forKey:FEEDBACK_DATE_KEY];

  XCTAssertFalse([testClass checkIfVoteSubmittedToday]);
}

- (void)testVoteIDCached {
  PPLVoteManagerClass *testClass = [PPLVoteManagerClass sharedInstance];
  NSString *voteIDTestCase = @"12";
  [testClass recordVoteIDIntoCache:voteIDTestCase];
  XCTAssertEqual(voteIDTestCase, [testClass getVoteIDFromCache]);
}

@end
