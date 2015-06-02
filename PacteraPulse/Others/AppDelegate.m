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

#import "AppDelegate.h"
#import "PPLNotificationCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSString *const kLauchFirstTime = @"LauchFirstTime";
NSString *const kLaunchScreen = @"launchController";
NSString *const kVoteScreen = @"voteController";

NSString *const kStoryboardId = @"Main";


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    UINavigationController *rootViewControoler = [[UINavigationController alloc]
        initWithRootViewController:[self selectRootViewController]];
    [self markFirstLaunch];

    self.window.rootViewController = rootViewControoler;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma - mark CustomFunctions
/**
 *  Function to check the first launch of the screen
 *
 *  @return returns true if this is the first launch
 */
- (BOOL)checkFirstLaunch
{
    NSLog(@"Check Launch");
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kLauchFirstTime];
}

/**
 *  This function marks the first launch of app in user defaults
 */
- (void)markFirstLaunch
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:kLauchFirstTime];
    [prefs synchronize];
}
/**
 *  Function to decide which Viewcontroller to take on launch, this basically
 *switches
 *  the start view based on the fact if user has launched the app before or not.
 *On
 *  first launch it will show launch screen with instructions, on every next
 *launch it
 *  will directly take the user to voting screen
 *
 *  @return return the appropriate viewcontroller
 */
- (UIViewController *)selectRootViewController
{
    UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:kStoryboardId bundle:nil];

    UIViewController *initViewController = [storyboard
        instantiateViewControllerWithIdentifier:[self checkFirstLaunch]
                                                    ? kLaunchScreen
                                                    : kVoteScreen];

    return initViewController;
}


@end
