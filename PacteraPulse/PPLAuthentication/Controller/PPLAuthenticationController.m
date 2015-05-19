//
//  PPLAuthenticationController.m
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLAuthenticationController.h"
/**
 *  Class to manage authentication related functionality
 */

@implementation PPLAuthenticationController

/**
 *  Function to check if the session created by the user is still valid and 
 *  he can continue ahead to the main app functionality
 *
 *  @return YES if the user is logged in and session is valid otherwise
 *  return NO
 */
-(BOOL)checkIfLoggedIn
{
    return YES;
}
/**
 *  Login user will call the authentication method needed to login the user,
 *
 *  @return YES if the user logged in successfully NO if login failed
 */
-(BOOL)loginUser;

{
    //TODO: Implementation missing
    return YES;
}
/**
 *  Helper function for checking if the user is logged in, this will verify the 
 *  stored token and check its validity
 *
 *  @return return YES if the token is still valid NO if it has expired
 */
-(BOOL)isTokenValid
{
    //TODO:	Implementation missing
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
