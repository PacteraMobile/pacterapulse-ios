//
//  PPLVoteContentView.h
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLVoteContentQuestionView.h"

@interface PPLVoteContentView : UIView
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, assign) FeedBackType feedBack;
@property(nonatomic, strong) UIButton *submitButton;

- (instancetype)initViewWithFrame:(CGRect)frame;
- (NSArray*)fetchVoteComments;

@end
