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
#import <AFNetworking/AFNetworking.h>

#define kVoteUrl @"emotions"

#define FEEDBACK_EMOTION_PARAM_KEY @"emotionId"
#define FEEDBACK_DEVICE_PARAM_KEY @"deviceId"

// Defauld timeout value in seconds
#define DEFAULT_TIMEOUT 10
/**
 *  PPLNetworkingHelper provides generic functions for network communications
 */
@interface PPLNetworkingHelper : NSObject
/**
 *  Singleton class
 *
 *  @return returns the singleton instance for PPLNetworkingHelper
 */
+ (PPLNetworkingHelper *)sharedClient;

/**
 *  Function to do GET HTTP request
 *
 *  @param relativeURL URL which is relative to the base URL
 *  @param parameters  Parameters to pass to the server for URL call
 *  @param success     callback function to be called incase of a successfull
 *HTTP Request
 *  @param failure     callback function to be called if the HTTP request fails
 *for any reason
 *
 *  @return return the created Request operation
 */
- (AFHTTPRequestOperation *)
       GET:(NSString *)relativeURL
parameters:(NSDictionary *)parameters
   success:(void (^)(NSString *responseString, id responseObject))success
   failure:(void (^)(NSString *responseString, NSError *error))failure;

/**
 *  Function to do Post HTTP request
 *
 *  @param relativeURL URL relative to the base URL
 *  @param parameters  Parameters to pass to the POST request
 *  @param success     callback function to be called is the HTTP Request is
 *successful
 *  @param failure     callback function to be called if the HTTP Request fails
 *
 *  @return returns the created HTTP Request operation
 */
- (AFHTTPRequestOperation *)
      POST:(NSString *)relativeURL
parameters:(NSDictionary *)parameters
   success:(void (^)(NSString *responseString, id responseObject))success
   failure:(void (^)(NSString *responseString, NSError *error))failure;

/**
 *  Function to do Put HTTP request
 *
 *  @param relativeURL URL relative to the base URL
 *  @param parameters  Parameters to pass to the PUT request
 *  @param success     callback function to be called is the HTTP Request is
 *successful
 *  @param failure     callback function to be called if the HTTP Request fails
 *
 *  @return returns the created HTTP Request operation
 */
- (AFHTTPRequestOperation *)
       PUT:(NSString *)relativeURL
parameters:(id)parameters
   success:(void (^)(NSString *responseString, id responseObject))success
   failure:(void (^)(NSString *responseString, NSError *error))failure;

@end
