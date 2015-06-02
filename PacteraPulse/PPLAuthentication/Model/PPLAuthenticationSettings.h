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
#import "ADTokenCacheStoreItem.h"


extern NSString *const kAuthCasheKey;
extern NSString *const kServiceName;
@interface PPLAuthenticationSettings : NSObject

@property(strong) ADTokenCacheStoreItem *userItem;
@property(strong) NSString *taskWebApiUrlString;
@property(strong) NSString *authority;
@property(strong) NSString *clientId;
@property(strong) NSString *resourceId;
@property(strong) NSString *redirectUriString;
@property(strong) NSString *correlationId;
@property BOOL fullScreen;

+ (PPLAuthenticationSettings *)loadSettings;
- (BOOL)checkIfSettingsLoaded;
- (NSString *)getFirstName;
- (NSString *)getLastName;
- (NSString *)getEmailAddress;
- (NSString *)getUserId;
- (void)setCache:(ADTokenCacheStoreItem *)userItem;
@end
