//
//  PPLUtils.m
//  PacteraPulse
//
//  Created by Qazi.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLUtils.h"
#import <UIKit/UIKit.h>
#import "PPLVoteViewController.h"
#import "AppDelegate.h"
@implementation PPLUtils

/**
 *  Method to get singleton instance for PPUtils class
 *
 *  @return a new created instance or an existing one
 */
+ (PPLUtils *)sharedInstance
{
    static PPLUtils *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
        _sharedClient = [[PPLUtils alloc] init];
    });
    
    return _sharedClient;
}

/**
 *  Function to get unique ID for this device, this is used for submitting feedback to the server
 *
 *  @return unique ID for this device
 */
- (NSString*)getUniqueId
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

-(PPLUtils *)sharedInstance
{
    return [PPLUtils sharedInstance];
}

-(NSUserDefaults *)getStandardUserDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

/**
 *  This function shows the launch screen which has instructions
 *
 *  @param sender Initiator for this function
 */
- (void)showLaunch:(UIViewController*)sender
{
    // Get all the View Controllers from this Navigation Controllers
    NSArray *navigationViews = sender.navigationController.viewControllers;
    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:kStoryboardId bundle:nil];
    // First of all check if Voting screen is the first view controller or not
    // because if Vote controller is the root view controller it means the
    // application
    // was not launched for the rist time and at initialization the voting
    // screen
    // became the root controller for this view.
    if ([navigationViews[0] isKindOfClass:[PPLVoteViewController class]])
    {
        // Initialise the launch view controller, this will be inserted in the
        // navigation controller
        UIViewController *initViewController =
        [storyboard instantiateViewControllerWithIdentifier:kLaunchScreen];
        // Initialize a temporary array with all view controllers
        NSMutableArray *tempArray =
        [[NSMutableArray alloc] initWithArray:navigationViews];
        // Insert the newly created controller as the first element of array of
        // view controllers
        [tempArray insertObject:initViewController atIndex:0];
        // Set this newly arranged Array of view controllers as the views
        // managed
        // by the current navigation controller, which means the newly created
        // launch controller is at the root now.
        [sender.navigationController setViewControllers:tempArray];
    }
    
    // After all the modifications (if done) go to the root controller
    [sender.navigationController popToRootViewControllerAnimated:YES];
}

@end
