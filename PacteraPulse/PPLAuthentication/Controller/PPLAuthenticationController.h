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

-(void)loginUser:(UIViewController*)viewController  completionHandler:
( void (^) (NSString*, NSError*))completionblock;

-(void)getToken:(UIViewController*)viewController completionHandler:
                                (void (^) (NSString*, NSError*))completionBlock;

- (void)inValidateToken;

- (BOOL)logoutUser;
@end
