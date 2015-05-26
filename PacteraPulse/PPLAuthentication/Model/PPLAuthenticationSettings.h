//
//  PPLAuthenticationSettings.h
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADTokenCacheStoreItem.h"

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
@end
