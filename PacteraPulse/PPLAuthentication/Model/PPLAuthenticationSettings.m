//
//  PPLAuthenticationSettings.m
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLAuthenticationSettings.h"
#import "ADUserInformation.h"

@implementation PPLAuthenticationSettings

static PPLAuthenticationSettings *shareInstance;

+ (PPLAuthenticationSettings *)loadSettings
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AuthenticationSettings" ofType:@"plist"]];
        
        NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"AuthenticationSettings" ofType:@"plist"]);
        
        NSString* va = [dictionary objectForKey:@"fullScreen"];

        shareInstance.clientId = [dictionary objectForKey:@"clientId"];
        shareInstance.authority = [dictionary objectForKey:@"authority"];
        shareInstance.resourceId = [dictionary objectForKey:@"resourceString"];
        shareInstance.redirectUriString = [dictionary objectForKey:@"redirectUri"];
        shareInstance.taskWebApiUrlString = [dictionary objectForKey:@"taskWebAPI"];
        shareInstance.fullScreen = [va boolValue];
        

    });
    return shareInstance;
}

-(BOOL)checkIfSettingsLoaded
{
    return (shareInstance != nil);
}

-(NSString*)getFirstName
{
    return self.userItem.userInformation.getGivenName;
}
-(NSString*)getLastName
{
    return self.userItem.userInformation.getFamilyName;
}
-(NSString*)getEmailAddress
{
    return self.userItem.userInformation.getEMail;
}

@end
