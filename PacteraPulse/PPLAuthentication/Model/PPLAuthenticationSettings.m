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
/**
 *  This class is data part of Authentication, it saves all information related
 * to user login from saving the authentication token for re-use to loading
 * settings information from the Plist
 */
@implementation PPLAuthenticationSettings

NSString *const kAuthCasheKey = @"TokenCache";
NSString *const kServiceName = @"ActiveDirectory";

static PPLAuthenticationSettings *shareInstance;
/**
 *  Singleton function to get the settings
 *
 *  @return return the singleton instance for settings
 */
+ (PPLAuthenticationSettings *)loadSettings
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
      shareInstance = [[self alloc] init];

    });
    return shareInstance;
}
/**
 *  Initializaiton function for the class, this loads values from the plist
 * for the project like client id etc needed for connection to Microsoft Active
 * Directory services and authenticating
 *
 *  @return intiated instance of the class
 */
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

        // Load the token from Keychain if it was saved there
        _userItem = [FDKeychain itemForKey:kAuthCasheKey
                                forService:kServiceName
                                     error:&error];
    }
    return self;
}
/**
 *  Check if the settings are already loaded or not
 *
 *  @return true if settings are loaded false otherwise
 */
- (BOOL)checkIfSettingsLoaded { return (shareInstance != nil); }

/**
 *  Getter function for the first name of logged in user
 *
 *  @return First name of the user returned from Active Directory
 */
- (NSString *)getFirstName
{
    return self.userItem.userInformation.getGivenName;
}
/**
 *  Getter function for last name of the user, returns the last name returned by
 * Active directory
 *
 *  @return <#return value description#>
 */
- (NSString *)getLastName
{
    return self.userItem.userInformation.getFamilyName;
}

- (NSString *)getEmailAddress { return self.userItem.userInformation.getEMail; }
- (NSString *)getUserId { return self.userItem.userInformation.userId; }

/**
 *  Setter function to save the token retreived during login, the token is
 * saved to the instance variable as well as the keychain access.
 *
 *  @param userItem token cache to save in keyChain access
 */
- (void)setCache:(ADTokenCacheStoreItem *)userItem
{

    NSError *error = nil;

    // Save the token in the keychain access
    [FDKeychain saveItem:userItem
                  forKey:kAuthCasheKey
              forService:kServiceName
                   error:&error];

    _userItem = userItem;
}
@end
