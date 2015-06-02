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
