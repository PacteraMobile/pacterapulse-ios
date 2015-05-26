//
//  PPLVoteData.h
//  PacteraPulse
//
//  Created by Qazi.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLUtils.h"
@interface PPLVoteData : NSObject
@property(nonatomic, copy) NSString *userID;
@property(nonatomic, copy) NSString *firstName;
@property(nonatomic, copy) NSString *lastName;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *deviceID;
@property(nonatomic, assign) FeedBackType feedBackType;
@property(nonatomic, copy) NSArray *comments;
@property(nonatomic, assign) BOOL feedbackSubmitted;
+ (PPLVoteData *)shareInstance;
- (void)sendFeedback:(void (^)(BOOL status, NSString *serverResponse,
                               NSError *error))callback;
@end
