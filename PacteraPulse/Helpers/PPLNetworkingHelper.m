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
#import "PPLNetworkingHelper.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "PPLUtils.h"

#ifdef DEBUG
static NSString *kServerBaseURL =
    @"http://pacterapulse-dev.elasticbeanstalk.com/";
#else
static NSString *kServerBaseURL =
    @"http://pacterapulse-sit.elasticbeanstalk.com/";
#endif

@interface PPLNetworkingHelper ()

/**
 *  httpManager will be used for HTTP Communincations will be initialized once
 *  with base url
 */
@property(nonatomic, strong) AFHTTPRequestOperationManager *httpManager;

@end

@implementation PPLNetworkingHelper

/**
 *  Returns the signletone instance of this class
 *
 *  @return creates and returns the instance or returns the already created
 * instance
 */
+ (PPLNetworkingHelper *)sharedClient {
  static PPLNetworkingHelper *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient = [[PPLNetworkingHelper alloc] init];
  });

  return _sharedClient;
}

/**
 *  Clas level initialized function
 */
+ (void)initialize {
  __unused PPLNetworkingHelper *sharedClient =
      [PPLNetworkingHelper sharedClient];
}

/**
 *  Instance level initialization woud create and initialize httpManager based
 *  on the base URL
 *
 *  @return returns the class instance
 */
- (id)init {
  if (self = [super init]) {
    NSURL *baseURL = [NSURL URLWithString:kServerBaseURL];
    self.httpManager =
        [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    self.httpManager.operationQueue.maxConcurrentOperationCount = 2;
    self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.httpManager.reachabilityManager startMonitoring];
    self.httpManager.requestSerializer.timeoutInterval = DEFAULT_TIMEOUT;
    [self.httpManager.requestSerializer
        setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
  }
  return self;
}

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
   failure:(void (^)(NSString *responseString, NSError *error))failure {
  AFHTTPRequestOperation *op = [self.httpManager GET:relativeURL
      parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation.responseString, responseObject);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation.responseString, error);
      }];
  return op;
}
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
   failure:(void (^)(NSString *responseString, NSError *error))failure {
  AFHTTPRequestOperation *op = [self.httpManager POST:relativeURL
      parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation.responseString, responseObject);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation.responseString, error);
      }];

  return op;
}

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
   failure:(void (^)(NSString *responseString, NSError *error))failure {
  AFHTTPRequestOperation *op = [self.httpManager PUT:relativeURL
      parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation.responseString, responseObject);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation.responseString, error);
      }];

  return op;
}
@end
