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
#import "PPLVoteContentQuestionView.h"
#import "PPLVoteDetailViewController.h"
#import "PPLVoteData.h"
#import "PPLUtils.h"
#import <OCMock/OCMock.h>
#import "PPLVoteContentView.h"
@interface PPLVoteDetailTests : XCTestCase
@property(nonatomic, strong) PPLVoteContentView *testVoteContentView;
@property(nonatomic, strong) PPLVoteDetailViewController *pplVoteViewController;
@end

@implementation PPLVoteDetailTests

- (void)setUp {
  [super setUp];
  self.testVoteContentView =
      [[PPLVoteContentView alloc] initViewWithFrame:CGRectMake(0, 0, 400, 650)];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of
  // each
  // test method in the class.
  [super tearDown];
}

- (void)testVoteContentQuestionView {

  PPLVoteContentQuestionView *questionView = [[PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, 0, 300, 375)
                      withLabelContent:@"This is a new Question"];
  XCTAssertNotNil(questionView, @"it should init a queationView successfully");
}

- (void)testVoteContent {

  [self.testVoteContentView setFeedBack:kSoso];
  [self.testVoteContentView setUserName:@"Randy"];
  XCTAssertEqual(3, [[self.testVoteContentView fetchVoteComments] count],
                 @"it should have three comments");
}

- (void)testVoteSlideView {

  NSArray *testSubViews = self.testVoteContentView.subviews;
  for (UIView *view in testSubViews) {
    NSString *subviewClass = [NSString stringWithFormat:@"%@", [view class]];
    NSString *slideClass = [NSString stringWithFormat:@"%@", [UISlider class]];
    if ([subviewClass isEqualToString:slideClass]) {
      UISlider *mySlider = (UISlider *)view;
      XCTAssertEqual(0.5f, mySlider.value,
                     @"the slide value should be equal to 0.5");
    }
  }
}

- (void)testVoteDetailViewController {
  self.pplVoteViewController = [[PPLVoteDetailViewController alloc]
      initWithNibName:@"PPLVoteDetailViewController"
               bundle:nil];

  XCTAssertNotNil(self.pplVoteViewController,
                  @"It should initial a PPLVoteDetailViewController object");
}

- (void)testSetFeedBackTypeForVoteDetailViewController {
  [self.pplVoteViewController setFeedBack:kHappy];
  NSArray *testSubViews = self.pplVoteViewController.view.subviews;
  for (UIView *view in testSubViews) {
    if ([view isKindOfClass:[UIImageView class]]) {
      UIImageView *iconImageView = (UIImageView *)view;
      XCTAssertNotNil(iconImageView.image, @"It should have a emotion "
                      @"image in the " @"voteDetailViewController");
    }
  }
}

- (void)testVoteData {
  PPLVoteData *voteData = [PPLVoteData shareInstance];
  [voteData setDeviceID:[[PPLUtils sharedInstance] getUniqueId]];
  [voteData setUserID:@"myName"];
  id voteDataMock = [OCMockObject partialMockForObject:voteData];
  [[[voteDataMock stub] andDo:^(NSInvocation *invocation) {
    void (^sendFeedBackResponse)(BOOL status, NSString *serverResponse,
                                 NSError *error);
    [invocation getArgument:&sendFeedBackResponse atIndex:3];
    BOOL status = YES;
    NSString *serverResponse = @"";
    NSError *error = nil;
    sendFeedBackResponse(status, serverResponse, error);
    XCTAssert(YES, @"Pass");
  }] sendFeedback:[OCMArg any]];
}

- (void)testVoteFeedBackDetail {
  PPLVoteData *voteData = [PPLVoteData shareInstance];
  [voteData setComments:[self.testVoteContentView fetchVoteComments]];
  id voteDataMock = [OCMockObject partialMockForObject:voteData];
  [[[voteDataMock stub] andDo:^(NSInvocation *invocation) {
    void (^sendFeedBackResponse)(BOOL status, NSString *serverResponse,
                                 NSError *error);
    [invocation getArgument:&sendFeedBackResponse atIndex:3];
    BOOL status = YES;
    NSString *serverResponse = @"";
    NSError *error = nil;
    sendFeedBackResponse(status, serverResponse, error);
    XCTAssert(YES, @"Pass");
  }] sendDetailFeedback:@"12"
        feedBackComments:[self.testVoteContentView fetchVoteComments]
                callBack:[OCMArg any]];
}

- (void)testVoteComments {
  NSArray *comments = self.testVoteContentView.fetchVoteComments;
  XCTAssertEqual(3, [comments count]);
}

@end
