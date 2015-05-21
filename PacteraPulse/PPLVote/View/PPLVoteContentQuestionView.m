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
@end

@implementation PPLVoteContentQuestionView
CGFloat const paddingLeft = 10.0f;
CGFloat const paddingTop = 5.0f;
CGFloat const processPaddingLeft = 15.0f;
CGFloat const badGoodLabelWidth = 45.0f;
CGFloat const badGoodLabelHeigth = 25.0f;
NSString *const goodLabelString = @"Good";
NSString *const badLabelString = @"Bad";
/**
 *  Initialize each question view,it includes question describe words, slide
 *  view, bad-good label
 *
 *  @param frame   set frame for the view
 *  @param content set question content
 *
 *  @return PPLVoteContentQuestionView object
 */
- (instancetype)initContentQuestionViewWithFrame:(CGRect)frame
                                withLabelContent:(NSString *)content {
  self = [super initWithFrame:frame];
  if (self) {
    self.labelContent = content;
    [self initVoteContentView:frame];
  }
  return self;
}
/**
 *  Add Question Label, the font is SYSTEM with 14.0f size, font color is
 *  default black
 *  Add Slider View, the MinTrackTinkColor is the same as the UnHappy button
 *  Color, the MaxTrackTinkColor is the same as the Happy button Color
 *  Add good label ,add bad label, the font is SYSTEM with 11.of size,font color
 *  is default black
 *  @param frame
 */
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
  [self.contentSilderView setMaximumTrackTintColor:HAPPY_COLOR];
  [self.contentSilderView setMinimumTrackTintColor:UNHAPPY_COLOR];

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
                        CGRectGetMaxY(self.contentSilderView.frame) +
                            paddingTop,
                        badGoodLabelWidth, badGoodLabelHeigth)];
  [goodLabel setText:goodLabelString];
  [goodLabel setTextAlignment:NSTextAlignmentRight];
  [goodLabel setFont:GOOD_BAD_LABEL_FONT];

  [self addSubview:contentLabel];
  [self addSubview:self.contentSilderView];
  [self addSubview:badLabel];
  [self addSubview:goodLabel];
}
/**
 *  Set default Slider Value for each feedback status
 *  0.2 for unHappy status
 *  0.5 for soso status
 *  0.7 for happy status
 *  @param feedBack FeedBackType
 */
- (void)setFeedBack:(FeedBackType)feedBack {
  switch (feedBack) {
  case kHappy:
    self.contentSilderView.value = 0.7;
    break;
  case kSoso:
    self.contentSilderView.value = 0.5;
    break;
  case kUnHappy:
    self.contentSilderView.value = 0.2;
    break;
  }
}

@end
