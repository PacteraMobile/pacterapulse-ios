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

#import "PPLAuthenticationSettings.h"
#import "ADUserInformation.h"
#import "PPLUtils.h"
#import "FDKeychain.h"

@implementation PPLAuthenticationSettings

NSString *const kAuthCasheKey = @"TokenCache";
NSString *const kServiceName = @"ActiveDirectory";

static PPLAuthenticationSettings *shareInstance;

+ (PPLAuthenticationSettings *)loadSettings
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
      shareInstance = [[self alloc] init];

    });
    return shareInstance;
}

- (id)init
{
    self = [super self];
    if (self)
    {

        NSDictionary *dictionary = [NSDictionary
            dictionaryWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"AuthenticationSettings"
                                                ofType:@"plist"]];

        NSLog(@"%@",
              [[NSBundle mainBundle] pathForResource:@"AuthenticationSettings"
                                              ofType:@"plist"]);

        NSString *va = [dictionary objectForKey:@"fullScreen"];

        _clientId = [dictionary objectForKey:@"clientId"];
        _authority = [dictionary objectForKey:@"authority"];
        _resourceId = [dictionary objectForKey:@"resourceString"];
        _redirectUriString = [dictionary objectForKey:@"redirectUri"];
        _taskWebApiUrlString = [dictionary objectForKey:@"taskWebAPI"];
        _fullScreen = [va boolValue];

        NSError *error = nil;

        _userItem = [FDKeychain itemForKey:kAuthCasheKey
                                forService:kServiceName
                                     error:&error];
    }
    return self;
}

- (BOOL)checkIfSettingsLoaded { return (shareInstance != nil); }

- (NSString *)getFirstName
{
    return self.userItem.userInformation.getGivenName;
}
- (NSString *)getLastName
{
    return self.userItem.userInformation.getFamilyName;
}
- (NSString *)getEmailAddress { return self.userItem.userInformation.getEMail; }
- (NSString *)getUserId { return self.userItem.userInformation.userId; }
- (void)setCache:(ADTokenCacheStoreItem *)userItem
{

    NSError *error = nil;

    [FDKeychain saveItem:userItem
                  forKey:kAuthCasheKey
              forService:kServiceName
                   error:&error];

    _userItem = userItem;
}
@end
