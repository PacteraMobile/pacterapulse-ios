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

#import "PPLVoteManagerClass.h"
#import "PPLUtils.h"
#import "PPLVoteData.h"
/**
 *  Vote manager class will keep a track of votes, for now we restrict voting
 *  to one vote per day, so this class will keep a track of submitted votes
 *  and check if another can be submitted
 */
@implementation PPLVoteManagerClass

/**
 *  Create a singleton instans
 *
 *  @return return the signleton instans
 */
+ (PPLVoteManagerClass *)sharedInstance {
  static PPLVoteManagerClass *shareInstance;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    shareInstance = [[self alloc] init];
  });
  return shareInstance;
}
/**
 *  This function records the current date and value of last vote
 *
 *  @param value value of this vote
 */
- (void)recordVoteSubmission:(NSString *)value {
  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];

  [prefs setObject:value forKey:FEEDBACK_VALUE_KEY];
  [prefs setObject:[self getCurrentDate] forKey:FEEDBACK_DATE_KEY];

  [prefs synchronize];
}
/**
 *  This function is used to check if the user has already submitted his vote
 * for the current day
 *
 *  @return returns true if vote has been submitted and false otherwise
 */

- (BOOL)checkIfVoteSubmittedToday {

  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];

  NSDate *voteDate = [prefs objectForKey:FEEDBACK_DATE_KEY];

  return [self ifDateIsToday:voteDate];
}
/**
 *  Internal funciton to get only the date portion (removing the time element)
 *
 *  @return Date object with time set to default start of the day
 */
- (NSDate *)getCurrentDate {
  NSDateComponents *components = [[NSCalendar currentCalendar]
      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
        fromDate:[NSDate date]];

  return [[NSCalendar currentCalendar] dateFromComponents:components];
}
/**
 *  Internal function to check if the date passed is todays
 *
 *  @param date date which is to be checked
 *
 *  @return returns true if the date sent for checking is today and false
 *  otherwise
 */
- (BOOL)ifDateIsToday:(NSDate *)date {
  if (date == nil) {
    return NO;
  }
  NSDateComponents *components1 = [[NSCalendar currentCalendar]
      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
        fromDate:date];

  NSDateComponents *components2 = [[NSCalendar currentCalendar]
      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
        fromDate:[NSDate date]];

  NSDate *tempDate1 =
      [[NSCalendar currentCalendar] dateFromComponents:components1];

  NSDate *tempDate2 =
      [[NSCalendar currentCalendar] dateFromComponents:components2];

  return [tempDate1 isEqualToDate:tempDate2];
}

- (void)recordVoteIDIntoCache:(NSString *)voteID {
  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];
  [prefs setObject:voteID forKey:VOTEID];
  [prefs synchronize];
}

- (NSString *)getVoteIDFromCache {
  NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];
  NSString *voteID = [prefs objectForKey:VOTEID];
  return voteID;
}
@end
