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

#ifndef PacteraPulse_PPLSummaryGenerals_h
#define PacteraPulse_PPLSummaryGenerals_h


// Navigation bar logout button
static NSString *const sPPLSummaryVoteDetail = @"More Info";
static NSString *const sPPLSummaryLogout = @"Logout";
static NSString *const sPPLSummaryLogoutAlert =
    @"You will be logouted and redirected to homepage.";
static NSString *const sPPLSummaryLogoutPrompts =
    @"You are not logined, please log in firstly.";
// Navigation bar title
static NSString *const sPPLSummaryTilte = @"Results";
// Bar chart title
static NSString *const sBarchartTitle =
    @"Employees' Satisfaction is everything";
// Error handling
static NSString *const sPPLSummaryVoteAgainAlert =
    @"Already voted, vote once per day only.";
static NSString *const sPPLSummaryFetchDataFailed =
    @"Can't get feedback from server, please kindly try later.";
// This is used for locating space for title in barchart, and height of segment
// control as well
static const NSInteger iTitleSpace = 60;
// This is used for locating space for label on the top of bar in barchart
static const NSInteger iLabelSpace = 20;
// 100 per cent
static const NSInteger iMaxPercent = 100;
// showing happy, so so, unhappy
static const NSInteger iMinColumnInBarchart = 3;

// String used in bar chart
static NSString *const sBarchartSubtitleHappy = @"Happy";
static NSString *const sBarchartSubtileSoso = @"So so";
static NSString *const sBarchartSubtitleUnhappy = @"Unhappy";

// String used in network request
static NSString *const sResultPeriodDay = @"24hours";
static NSString *const sResultPeriodWeek = @"7days";
static NSString *const sResultPeriodMonth = @"30days";
static NSString *const kEmotion = @"emotion";
static NSString *const kEmotionValue = @"count";
// String used in segment control
static NSString *const sResultPeriodDayTitle = @"24 Hours";
static NSString *const sResultPeriodWeekTitle = @"7 Days";
static NSString *const sResultPeriodMonthTitle = @"30 Days";
// Report type, which is the same order of Segment control
typedef enum
{
    k24HourReport,
    k7DayReport,
    k30DayReport
} ReportPeriodType;

#endif
