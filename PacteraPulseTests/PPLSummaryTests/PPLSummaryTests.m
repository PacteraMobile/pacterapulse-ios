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
#import "PPLSummaryData.h"
#import "PPLSummaryBarViewController.h"
#import "CSNotificationView.h"


@interface PPLSummaryTests : XCTestCase

@end

@implementation PPLSummaryTests

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

- (void)testForSummaryDataInitialization
{
    XCTAssertNotNil([PPLSummaryData shareInstance],
                    @"Instance of PPLSummaryData");
}

- (void)testForSummayRetuenedData
{
    PPLSummaryData *summaryData = [[PPLSummaryData alloc] init];
    [summaryData
        emotionValues:@"24hours"
             callBack:^(BOOL status, NSArray *graphValues, NSError *error) {
               if (status)
               {
                   XCTAssertGreaterThan(graphValues.count, 0,
                                        @"The count should be greater than 0");
                   XCTAssertNotNil(
                       [[graphValues objectAtIndex:0] objectForKey:@"emotion"],
                       @"The value of iconID should not be null");
               }
               else
               {
                   XCTAssertEqual(graphValues.count, 0,
                                  @"The count should be 0");
               }

             }];
}

- (void)testIfDataFetchedSuccessfully
{
    // Private member, how to test?
    XCTAssertTrue(true);
}

- (void)testIfBarchartShowed
{
    PPLSummaryBarViewController *viewController =
        [[PPLSummaryBarViewController alloc] init];
    NSArray *viewArray = viewController.view.subviews;
    bool testSucceed = false;
    for (UIView *subview in viewArray)
    {

        NSString *subviewClass =
            [NSString stringWithFormat:@"%@", [subview class]];
        NSString *coreplotClass =
            [NSString stringWithFormat:@"%@", [CPTGraphHostingView class]];

        // stupid,this doesn't work
        // if( [subview isKindOfClass:[CPTGraphHostingView class]])
        if ([subviewClass isEqualToString:coreplotClass])
        {
            testSucceed = true;
            break;
        }
    }

    XCTAssertTrue(testSucceed);
}

- (void)testIfNotificationShowed
{
    PPLSummaryBarViewController *viewController =
        [[PPLSummaryBarViewController alloc] init];

    bool alertShowed = false;
    for (UIView *subview in viewController.view.subviews)
    {

        NSString *subviewClass =
            [NSString stringWithFormat:@"%@", [subview class]];
        NSString *csClass =
            [NSString stringWithFormat:@"%@", [CSNotificationView class]];

        if ([subviewClass isEqualToString:csClass])
        {
            alertShowed = true;
            break;
        }
    }

    if (viewController.shouldShowAlert)
    {
        XCTAssertTrue(alertShowed);
    }
    else
    {
        XCTAssertTrue(!alertShowed);
    }
}

- (void)testIfSegmentControlShowed
{
    PPLSummaryBarViewController *viewController =
        [[PPLSummaryBarViewController alloc] init];
    NSArray *viewArray = viewController.view.subviews;
    bool testSucceed = false;
    for (UIView *subview in viewArray)
    {

        NSString *subviewClass =
            [NSString stringWithFormat:@"%@", [subview class]];
        NSString *segmentClass =
            [NSString stringWithFormat:@"%@", [UISegmentedControl class]];

        if ([subviewClass isEqualToString:segmentClass])
        {
            testSucceed = true;
            break;
        }
    }

    XCTAssertTrue(testSucceed);
}

@end
