//
//  PPLVoteContentQuestionView.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteContentQuestionView.h"
#define CONTENT_LABEL_FONT [UIFont systemFontOfSize:14.0f]
#define GOOD_BAD_LABEL_FONT [UIFont systemFontOfSize:11.0f]
@interface PPLVoteContentQuestionView ()
@property(nonatomic, strong) NSString *labelContent;
@property(nonatomic, assign) FeedBackType feedBack;
@end

@implementation PPLVoteContentQuestionView
CGFloat const paddingLeft = 10.0f;
CGFloat const paddingTop = 5.0f;
CGFloat const processPaddingLeft = 15.0f;
CGFloat const badGoodLabelWidth = 45.0f;
CGFloat const badGoodLabelHeigth = 25.0f;
NSString *const goodLabelString = @"Good";
NSString *const badLabelString = @"Bad";

- (instancetype)initContentQuestionViewWithFrame:(CGRect)frame
                                withLabelContent:(NSString *)content withFeedBackType:(FeedBackType)feedback;{
  self = [super initWithFrame:frame];
  if (self) {
    self.labelContent = content;
    [self initVoteContentView:frame];
    [self setDefaultValueForSliderbar];
  }
  return self;
}

- (void)initVoteContentView:(CGRect)frame {
  CGFloat frameHeight = CGRectGetHeight(frame);
  CGFloat frameWidth = CGRectGetWidth(frame);

  CGFloat itemHeight = frameHeight / 3;
  CGFloat labelWidth = frameWidth - paddingLeft * 2;
  UILabel *contentLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(paddingLeft, 0, labelWidth, itemHeight)];
  [contentLabel setText:self.labelContent];
  [contentLabel setFont:CONTENT_LABEL_FONT];

  self.contentSilderView = [[UISlider alloc]
      initWithFrame:CGRectMake(processPaddingLeft,
                               CGRectGetMaxY(contentLabel.frame) + paddingTop,
                               (frameWidth - processPaddingLeft * 2), 12.0f)];

  UILabel *badLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(processPaddingLeft,
                               CGRectGetMaxY(self.contentSilderView.frame) +
                                   paddingTop,
                               badGoodLabelWidth, badGoodLabelHeigth)];
  [badLabel setText:badLabelString];
  [badLabel setFont:GOOD_BAD_LABEL_FONT];

  UILabel *goodLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(
                        (frameWidth - badGoodLabelWidth - processPaddingLeft),
                        CGRectGetMaxY(self.contentSilderView.frame) + paddingTop,
                        badGoodLabelWidth, badGoodLabelHeigth)];
  [goodLabel setText:goodLabelString];
  [goodLabel setTextAlignment:NSTextAlignmentRight];
  [goodLabel setFont:GOOD_BAD_LABEL_FONT];

  [self addSubview:contentLabel];
  [self addSubview:self.contentSilderView];
  [self addSubview:badLabel];
  [self addSubview:goodLabel];
}

- (void)setDefaultValueForSliderbar {
  switch (self.feedBack) {
    case kHappyIcon:
      self.contentSilderView.value = 0.7;
      break;
    case kSosoIcon:
      self.contentSilderView.value = 0.5;
      break;
      case kUnHappyIcon:
      self.contentSilderView.value = 0.2;
      break;
    default:
      break;
  }
}

@end
