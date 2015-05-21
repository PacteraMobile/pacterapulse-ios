//
//  PPLVoteDetailTests.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPLVoteContentQuestionView.h"
@interface PPLVoteDetailTests : XCTestCase

@end

@implementation PPLVoteDetailTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
  
  PPLVoteContentQuestionView *questionView = [[PPLVoteContentQuestionView alloc]initContentQuestionViewWithFrame:CGRectMake(0, 0, 300, 375) withLabelContent:@"This is a new Question"];
  XCTAssertNotNil(questionView,@"it should init a queationView successfully");
  
}


@end
