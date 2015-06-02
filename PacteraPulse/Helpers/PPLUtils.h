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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPLUtils : NSObject
/**
 *  Method to get singleton instance for PPUtils class
 *
 *  @return a new created instance or an existing one
 */
+ (PPLUtils *)sharedInstance;
/**
 *  Function to get unique ID for this device, this is used for submitting
 *feedback to the server
 *
 *  @return unique ID for this device
 */
- (NSString *)getUniqueId;

- (NSUserDefaults *)getStandardUserDefaults;

- (void)showLaunch:(UIViewController *)sender;

typedef enum
{
    kHappy,
    kSoso,
    kUnHappy
} FeedBackType;

@end
