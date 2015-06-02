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

#import "PPLVoteData.h"
#import "PPLUtils.h"
#import "PPLNetworkingHelper.h"
#import "PPLAuthenticationSettings.h"
@implementation PPLVoteData
/**
 *  Single instance for PPLVode data
 *
 *  @return will return the singleton for this class
 */
+ (PPLVoteData *)shareInstance {
  static PPLVoteData *shareInstance;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    shareInstance = [[self alloc] init];
  });

  return shareInstance;
}

/**
 *  This method is called from the Viewcontroller to send the selected
 *  emotion to the server, it also gets the unique id of the device
 *  and submits with the emotion
 *
 *  @param feedBackValue Feedback value can be 1,2,3 which is Happy,
 *                       Neutral and Sad, it is converted to string to
 *                       send as parameter
 *  @param callback      This is the call back function which would allow
 *Controller to perform UI Actions on return
 */
- (void)sendFeedback:(void (^)(BOOL status, NSString *serverResponse,
                               NSError *error))callback {
  PPLNetworkingHelper *client = [PPLNetworkingHelper sharedClient];
  self.deviceID = [[PPLUtils sharedInstance] getUniqueId];
  NSString *postURL =
      [NSString stringWithFormat:@"%@/%@/%@/%d", kVoteUrl, self.userID,
                                 self.deviceID, self.feedBackType];
  // Call the post function of the network hepler and process callbacks
  [client POST:postURL
      parameters:nil
      success:^(NSString *responseString, id responseObject) {
        if (callback) {
          self.feedbackSubmitted = YES;
          callback(YES, responseString, nil);
        }

      }
      failure:^(NSString *responseString, NSError *error) {
        if (callback) {
          self.feedbackSubmitted = NO;
          callback(NO, responseString, error);
        }
      }];
}

/**
 *  This method is called from the MoreInfo Viewcontroller to send the feedback
 *  to the server, it also gets the voteId from previous submission
 *  and submits with the more detail inforamtion
 *
 *  @param voteID        voteID is from previous vote
 *  @param callback      This is the call back function which would allow
 *Controller to perform UI Actions on return
 */
- (void)sendDetailFeedback:(NSString *)voteID
          feedBackComments:(NSArray *)comments
                  callBack:(void (^)(BOOL status, NSString *serverResponse,
                                     NSError *error))callback {
  PPLNetworkingHelper *client = [PPLNetworkingHelper sharedClient];
  self.deviceID = [[PPLUtils sharedInstance] getUniqueId];
  NSString *postURL = [NSString stringWithFormat:@"%@/%@", kVoteUrl, voteID];
  [client PUT:postURL
      parameters:comments
      success:^(NSString *responseString, id responseObject) {
        if (callback) {
          self.feedbackSubmitted = YES;
          callback(YES, responseString, nil);
        }

      }
      failure:^(NSString *responseString, NSError *error) {
        if (callback) {
          self.feedbackSubmitted = NO;
          callback(NO, responseString, error);
        }
      }];
}

@end
