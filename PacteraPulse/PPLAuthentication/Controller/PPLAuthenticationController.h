//
//  PPLAuthenticationController.h
//  PacteraPulse
//
//  Created by Qazi on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPLAuthenticationController : NSObject

+ (PPLAuthenticationController *)sharedInstance;

- (BOOL)checkIfLoggedIn:(UIViewController *)viewController;

- (BOOL)loginUser:(UIViewController *)viewController;

- (BOOL)checkTokenValid:(UIViewController *)viewController;

- (void)inValidateToken;

- (BOOL)logoutUser;
@end
