//
//  PPLAuthenticationController.m
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLAuthenticationController.h"
#import "PPLAuthenticationSettings.h"
#import "ADAuthenticationError.h"
#import "ADAuthenticationContext.h"
#import "ADAuthenticationSettings.h"
/**
 *  Class to manage authentication related functionality
 */

@implementation PPLAuthenticationController
ADAuthenticationContext *context;
ADPromptBehavior promptBehavior = AD_PROMPT_AUTO;

/**
 *  Create a singleton instans
 *
 *  @return return the signleton instans
 */
+ (PPLAuthenticationController *)sharedInstance
{
    static PPLAuthenticationController *shareInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}
/**
 *  Function to check if the session created by the user is still valid and 
 *  he can continue ahead to the main app functionality
 *
 *  @return YES if the user is logged in and session is valid otherwise
 *  return NO
 */
-(BOOL)checkIfLoggedIn:(UIViewController*)viewController;
{
    return [self isTokenValid:viewController];
}
/**
 *  Login user will call the authentication method needed to login the user,
 *
 *  @return YES if the user logged in successfully NO if login failed
 */
-(BOOL)loginUser:(UIViewController*)viewController
{
    
    //TODO: Implementation missing
    PPLAuthenticationSettings *settings =
                                    [PPLAuthenticationSettings loadSettings];
    
    
    if([settings checkIfSettingsLoaded])
    {
        ADAuthenticationError *error;
     context = [ADAuthenticationContext
                                            authenticationContextWithAuthority:settings.authority
                                            error:&error];
        
        context.parentController = viewController;
        NSURL *redirectURL =
                    [[NSURL alloc] initWithString:settings.redirectUriString];
        
        if(!settings.correlationId ||
           [[settings.correlationId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        {
            context.correlationId = [[NSUUID alloc] initWithUUIDString:settings.correlationId];
        }
        
        [ADAuthenticationSettings sharedInstance].enableFullScreen = settings.fullScreen;
        [context acquireTokenWithResource:settings.resourceId
                                     clientId:settings.clientId
                                  redirectUri:redirectURL
                               promptBehavior:AD_PROMPT_ALWAYS
                                       userId:nil
         // if this strikes you as strange it was legacy to display the correct mobile UX. You most likely won't need it in your code.
         
                         extraQueryParameters: @"nux=1"
                              completionBlock:^(ADAuthenticationResult *result) {
                                  
                                  if (result.status != AD_SUCCEEDED)
                                  {
                                      //completionBlock(nil, result.error);
                                      NSLog(@"Failure");
                                  }
                                  else
                                  {
                                      settings.userItem = result.tokenCacheStoreItem;
                                      NSLog(@"Success");

                                      //completionBlock(result.tokenCacheStoreItem.userInformation, nil);
                                  }
                              }];

        
    }

    return YES;
}
/**
 *  Helper function for checking if the user is logged in, this will verify the 
 *  stored token and check its validity
 *
 *  @return return YES if the token is still valid NO if it has expired
 */
-(BOOL)isTokenValid:(UIViewController*)viewController
{
    PPLAuthenticationSettings* data = [PPLAuthenticationSettings loadSettings];
    if(data.userItem){
        return YES;
    }
    
    ADAuthenticationError *error;
    context = [ADAuthenticationContext authenticationContextWithAuthority:data.authority error:&error];
    context.parentController = viewController;
    NSURL *redirectUri = [[NSURL alloc]initWithString:data.redirectUriString];
    
    if(!data.correlationId ||
       [[data.correlationId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        context.correlationId = [[NSUUID alloc] initWithUUIDString:data.correlationId];
    }
    
    [ADAuthenticationSettings sharedInstance].enableFullScreen = data.fullScreen;
    [context acquireTokenWithResource:data.resourceId
                                 clientId:data.clientId
                              redirectUri:redirectUri
                           promptBehavior:AD_PROMPT_AUTO
                                   userId:data.userItem.userInformation.userId
                     extraQueryParameters: @"nux=1" // if this strikes you as strange it was legacy to display the correct mobile UX. You most likely won't need it in your code.
                          completionBlock:^(ADAuthenticationResult *result) {
                              
                              if (result.status != AD_SUCCEEDED)
                              {
                                  NSLog(@"Did not find the token");
                                  //completionBlock(nil, result.error);
                              }
                              else
                              {
                                  NSLog(@"Token found or refreshed");
                                  data.userItem = result.tokenCacheStoreItem;
                                  //completionBlock(result.tokenCacheStoreItem.accessToken, nil);
                              }
                          }];
    
    return YES;
}
/**
 *  Helper function to remove the token from the system and device, this will be
 * used by the lgout functionality
 */
-(void)inValidateToken
{
    //TODO: Implementation missing
}
/**
 *  Log the current user out of the system
 *
 *  @return YES if the logout process was successful NO otherwise
 */
-(BOOL)logoutUser
{
    //TODO: Implementation missing
    return YES;
}
@end
