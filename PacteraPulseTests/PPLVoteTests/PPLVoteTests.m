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
@interface PPLVoteTests : XCTestCase

@end

@implementation PPLVoteTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each
    // test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of
    // each
    // test method in the class.
    [super tearDown];
}

- (void)testFeedbackSubmitted
{
    //  TODO update the test case, or remove it into the votedetail testcase
    //    PPLVoteData *dataModel = [PPLVoteData shareInstance];
    //    XCTestExpectation *completionExpectation = [self
    //    expectationWithDescription:@"Checkin Submitted Fetch"];
    //
    //    [dataModel sendFeedback:[NSString stringWithFormat:@"%d", (rand()%3 +1
    //    )]
    //                   callBack:^(BOOL status, NSString* serverResponse,
    //                   NSError
    //                   *error)
    //     {
    //         XCTAssertTrue(status);
    //         [completionExpectation fulfill];
    //     }];
    //    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
