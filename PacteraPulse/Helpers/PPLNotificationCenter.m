//
//  PPLNotificationCenter.m
//  PacteraPulse
//
//  Created by Randy on 26/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PPLNotificationCenter.h"
#import "PPLUtils.h"

@implementation PPLNotificationCenter


/**
 *  Returns the signletone instance of this class
 *
 *  @return creates and returns the instance or returns the already created
 * instance
 */
+ (PPLNotificationCenter *)sharedClient
{
    static PPLNotificationCenter *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _sharedClient = [[PPLNotificationCenter alloc] init];
    });
    return _sharedClient;
}

- (id)init
{
    if (self = [super init])
    {
        // nothing here at the moment
    }
    return self;
}

/**
 *  Regist for notification permission
 *  Called in app delegate
 */
- (void)registerNotificationPermission
{
    if ([UIApplication
            instancesRespondToSelector:@selector(
                                           registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication]
            registerUserNotificationSettings:
                [UIUserNotificationSettings
                    settingsForTypes:UIUserNotificationTypeAlert |
                                     UIUserNotificationTypeBadge |
                                     UIUserNotificationTypeSound
                          categories:nil]];
    }
}

- (void)clearAllNofitications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

/**
 *  Clear existed notifications and add a new one after vote
 *  Called in PPLVoteViewController
 */
- (void)addNewNotificationAfterVote
{
    // Currently we have only one notification, so clear all
    [self clearAllNofitications];
    // At this stage, we don't need to record, reserve for future usage
    [self recordVoteSubmissionTimeForNotificationSetup];
    [self addNewNoficationForTomorrow];
    [self ifDateIsNextDay:[NSDate date]];
}

#pragma Notification
/**
 *  Add one notification on the next day, time:NOTIFICATION_TIME_ON_HOUR
 *  Will make this configurale on web server later
 */
- (void)addNewNoficationForTomorrow
{
    NSCalendar *calendar = [self getCalendarWithGMT];
    NSDateComponents *deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:0];
    NSDate *tomorrowDate = [calendar dateByAddingComponents:deltaComps
                                                     toDate:[NSDate date]
                                                    options:0];
    NSDateComponents *componentsForFireDate =
        [calendar components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear |
                              NSCalendarUnitHour | NSCalendarUnitMinute |
                              NSCalendarUnitSecond | NSCalendarUnitWeekday)
                    fromDate:tomorrowDate];
    [componentsForFireDate
        setHour:NOTIFICATION_TIME_ON_HOUR]; // for fixing 5PM hour:use 17
    [componentsForFireDate setMinute:0];
    [componentsForFireDate setSecond:0];

    UILocalNotification *notifyAlarm = [[UILocalNotification alloc] init];
    notifyAlarm.repeatInterval = 0; // don't repeat
    notifyAlarm.fireDate = [calendar dateFromComponents:componentsForFireDate];
    notifyAlarm.alertBody = NOTIFICATION_MESSAGE;
    notifyAlarm.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
}

- (NSCalendar *)getCalendarWithGMT
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return calendar;
}

// The following function reserved for future usage
- (void)recordVoteSubmissionTimeForNotificationSetup
{
    NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];
    [prefs setObject:[self getCurrentDate]
              forKey:NOTIFICATION_KEY_IN_USERDEFAULTS];
    [prefs synchronize];
}


- (NSDate *)getCurrentDate
{
    NSCalendar *calendar = [self getCalendarWithGMT];
    NSDateComponents *components = [calendar
        components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:[NSDate date]];
    return [calendar dateFromComponents:components];
}

- (BOOL)checkIfRegisterVoteNotification
{
    NSUserDefaults *prefs = [[PPLUtils sharedInstance] getStandardUserDefaults];
    NSDate *voteDate = [prefs objectForKey:NOTIFICATION_KEY_IN_USERDEFAULTS];
    return [self ifDateIsNextDay:voteDate];
}

/**
 *  Check if today is the next day of inputted date
 */
- (BOOL)ifDateIsNextDay:(NSDate *)date
{
    if (date == nil)
    {
        return NO;
    }

    NSCalendar *calendar = [self getCalendarWithGMT];
    NSDateComponents *deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];
    NSDate *recordedTomorrowDate =
        [calendar dateByAddingComponents:deltaComps toDate:date options:0];

    NSDateComponents *componentsToday = [calendar
        components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:[NSDate date]];
    NSDate *todayDate = [calendar dateFromComponents:componentsToday];

    return [recordedTomorrowDate isEqualToDate:todayDate];
}
@end
