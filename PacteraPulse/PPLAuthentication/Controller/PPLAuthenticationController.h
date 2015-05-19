//
//  PPLAuthenticationController.h
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLAuthenticationController : NSObject

-(BOOL)checkIfLoggedIn;

-(BOOL)loginUser;

-(BOOL)isTokenValid;

-(void)inValidateToken;

-(BOOL)logoutUser;
@end
