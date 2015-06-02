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
#import "PPLVoteViewController.h"
#import "AppDelegate.h"
#import "PPLLaunchViewController.h"
#import "PPLVoteTableViewCell.h"
#import "OCMockObject.h"
#import "OCMArg.h"
#import "OCMStubRecorder.h"
@interface PPLVoteTests : XCTestCase

@property(nonatomic, strong) PPLVoteViewController *voteViewController;
@property(nonatomic, strong) UINavigationController *navigationController;

@end

@implementation PPLVoteTests

- (void)setUp
{
    [super setUp];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _navigationController =
        (UINavigationController *)appDelegate.window.rootViewController;
    ;

    UIViewController *visibleView =
        self.navigationController.viewControllers[0];

    if ([visibleView isKindOfClass:[PPLVoteViewController class]])
    {

        _voteViewController = (PPLVoteViewController *)visibleView;
    }
    else
    {

        [visibleView performSegueWithIdentifier:kVoteSegueId sender:nil];
        _voteViewController = self.navigationController.viewControllers[1];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of
    // each
    // test method in the class.
    [super tearDown];
}
- (void)testUIElementsVoteScreen
{
    XCTAssertEqual(_voteViewController.data.count, 3);

    for (id cell in self.voteViewController.tableView.visibleCells)
    {

        XCTAssertTrue([cell isKindOfClass:[PPLVoteTableViewCell class]]);
    }
}

- (void)testFeedbackSubmitted
{

    UIButton *temp = [UIButton new];

    temp.tag = 1;
    PPLVoteData *voteData = self.voteViewController.voteData;

    [voteData setDeviceID:[[PPLUtils sharedInstance] getUniqueId]];
    [voteData setUserID:@"myName"];
    id voteDataMock = [OCMockObject partialMockForObject:voteData];
    [[[voteDataMock stub] andDo:^(NSInvocation *invocation) {
      void (^sendFeedBackResponse)(BOOL status, NSString *serverResponse,
                                   NSError *error);
      [invocation getArgument:&sendFeedBackResponse atIndex:2];
      BOOL status = YES;
      NSString *serverResponse = @"";
      NSError *error = nil;
      sendFeedBackResponse(status, serverResponse, error);
      XCTAssert(YES, @"Pass");
    }] sendFeedback:[OCMArg any]];

    [self.voteViewController handleClick:temp];


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
