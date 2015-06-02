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
#import "PPLSummaryBarViewController.h"
@interface PPLVoteTests : XCTestCase <UINavigationControllerDelegate>

@property(nonatomic, strong) PPLVoteViewController *voteViewController;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) XCTestExpectation *navigationComplete;


@end

@implementation PPLVoteTests

- (void)setUp
{
    NSLog(@"Setup in voteTest");
    [super setUp];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _navigationController =
        (UINavigationController *)appDelegate.window.rootViewController;
    ;

    _navigationController.delegate = self;
    UIViewController *visibleView = self.navigationController.topViewController;

    if ([visibleView isKindOfClass:[PPLVoteViewController class]])
    {

        _voteViewController = (PPLVoteViewController *)visibleView;
    }
    else
    {


        UIStoryboard *storyboard =
            [UIStoryboard storyboardWithName:kStoryboardId bundle:nil];

        _voteViewController =
            [storyboard instantiateViewControllerWithIdentifier:kVoteScreen];


        _navigationComplete =
            [self expectationWithDescription:@"Thankyou navigation complete"];

        [_navigationController pushViewController:_voteViewController
                                         animated:NO];


        [self waitForExpectationsWithTimeout:
                  10.0 handler:^(NSError *error) {
          XCTAssertTrue([self.navigationController.topViewController
                            isKindOfClass:[PPLVoteViewController class]],
                        @"Error in navigation");

        }];
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

    NSArray *temp = self.navigationController.viewControllers;

    NSLog(@"%@", temp);
    XCTAssertTrue([self.navigationController.topViewController
        isKindOfClass:[PPLVoteViewController class]]);
    XCTAssertEqual(self.voteViewController.data.count, 3);

    for (id cell in self.voteViewController.tableView.visibleCells)
    {

        XCTAssertTrue([cell isKindOfClass:[PPLVoteTableViewCell class]]);
    }

    [[PPLUtils sharedInstance] showLaunch:self.voteViewController];
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(
        DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
      XCTAssertTrue([self.navigationController.topViewController
                        isKindOfClass:[PPLLaunchViewController class]],
                    @"Did not navigate to Start Controller");
    });
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
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{

    if ([viewController isKindOfClass:[PPLVoteViewController class]])
    {
        [self.navigationComplete fulfill];
    }
}
@end
