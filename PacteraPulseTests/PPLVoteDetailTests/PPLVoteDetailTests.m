//
//  PPLVoteDetailTests.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPLVoteContentView.h"
#import "PPLVoteContentQuestionView.h"
#import "PPLUtils.h"
@interface PPLVoteDetailTests : XCTestCase

@end

@implementation PPLVoteDetailTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each
  // test method in the class.
  [super tearDown];
}

- (void)testExample {
  // This is an example of a functional test case.
  XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
      // Put the code you want to measure the time of here.
  }];
}

- (void)testVoteContentQuestionView {

  PPLVoteContentQuestionView *questionView = [[PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, 0, 300, 375)
                      withLabelContent:@"This is a new Question"];
  XCTAssertNotNil(questionView, @"it should init a queationView successfully");
}

- (void)testVoteContentView {
  PPLVoteContentView *testVoteContentView =
      [[PPLVoteContentView alloc] initViewWithFrame:CGRectMake(0, 0, 400, 650)];
  [testVoteContentView setFeedBack:kSoso];
  [testVoteContentView setUserName:@"Randy"];
  XCTAssertEqual(3, [[testVoteContentView fetchVoteComments] count],
                 @"it should have three comments");

  NSArray *testSubViews = testVoteContentView.subviews;
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

@end
