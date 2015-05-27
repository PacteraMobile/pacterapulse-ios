//
//  PPLNotificationCenter.h
//  PacteraPulse
//
//  Created by Randy on 26/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFICATION_MESSAGE @"Don't forget to vote"
#define NOTIFICATION_KEY_IN_USERDEFAULTS @"votedFlage"
#define NOTIFICATION_TIME_ON_HOUR 17 // We will get this later from web server
@interface PPLNotificationCenter : NSObject

+ (PPLNotificationCenter *)sharedClient;
- (void)registerNotificationPermission;
- (BOOL)checkIfRegistionSuccessful;

- (void)clearAllNotifications;
- (void)addNewNotificationAfterVote;

@end
