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

#import "PPLSummaryData.h"
#import "PPLNetworkingHelper.h"

@implementation PPLSummaryData

#pragma mark - Class method
+ (PPLSummaryData *)shareInstance
{
    static PPLSummaryData *shareInstance;

    static dispatch_once_t once;

    dispatch_once(&once, ^{
      shareInstance = [[self alloc] init];
    });

    return shareInstance;
}

/**
 * Return the emotions summary data from remote Service
 *
 *
 * @param period Choose the data from which period : '24hours' '7days' '30days'
 * @param callBack The block is called when the server return the data back to
 *the client side
 */

- (void)emotionValues:(NSString *)period
             callBack:(void (^)(BOOL status, NSArray *graphValues,
                                NSError *error))callback
{
    __block NSError *error = nil;
    __block NSArray *graphValues = [NSArray array];
    PPLNetworkingHelper *netWorkingHelper = [PPLNetworkingHelper sharedClient];
    NSString *relativeString =
        [NSString stringWithFormat:@"/%@/%@", kVoteUrl, period];
    [netWorkingHelper GET:relativeString
        parameters:nil
        success:^(NSString *responseString, id responseObject) {
          // Parse the summary data form the Server
          NSData *responseData =
              [responseString dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *summaryContent = [NSJSONSerialization
              JSONObjectWithData:responseData
                         options:NSJSONReadingMutableContainers
                           error:&error];
          if (!error)
          {
              graphValues = [summaryContent objectForKey:@"emotionVotes"];
          }
          callback(YES, graphValues, error);
        }
        failure:^(NSString *responseString, NSError *error) {
          callback(NO, graphValues, error);
        }];
}

@end
