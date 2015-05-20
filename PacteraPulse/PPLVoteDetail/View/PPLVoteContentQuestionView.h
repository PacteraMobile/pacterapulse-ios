//
//  PPLVoteContentQuestionView.h
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  kHappyIcon,
  kSosoIcon,
  kUnHappyIcon
} FeedBackType;

@interface PPLVoteContentQuestionView : UIView
@property(nonatomic, strong) UISlider *contentSilderView;

- (instancetype)initContentQuestionViewWithFrame:(CGRect)frame withLabelContent:(NSString*)content withFeedBackType:(FeedBackType)feedback;

@end
