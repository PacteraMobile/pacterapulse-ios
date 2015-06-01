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

#import "PPLVoteContentView.h"

@interface PPLVoteContentView () {
  CGFloat emotionMaxY;
  NSArray *questionList;
}
@property(nonatomic, strong) UILabel *greetingLalel;
@property(nonatomic, strong) UIImageView *emotionView;
@property(nonatomic, strong) PPLVoteContentQuestionView *workQuestionView;
@property(nonatomic, strong)
    PPLVoteContentQuestionView *communicationQuestionView;
@property(nonatomic, strong) PPLVoteContentQuestionView *projectQuestionView;

@end

@implementation PPLVoteContentView

CGFloat const kPaddingTen = 10.0f;
CGFloat const kPaddingFifteen = 15.0f;
CGFloat const kPaddingTwenty = 20.0f;
CGFloat const kEmotionWidth = 70.0f;
CGFloat const kEmotionHeigth = 70.0f;
CGFloat const kSubmitButtonHeigth = 34.0f;
CGFloat const kSubmitButtonPaddingButton = 15.0f;
NSString *const kSubmitButton = @"Submit";
NSString *const kMainTitleContent = @"We would love to hear more";

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
*  Initilize the view
*
*  @param feedback 1,2,3 represent the happy soso unhappy
*  @param frame    the frame of the parentViewController
*
*  @return self
*/

- (instancetype)initViewWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.frame = frame;
    questionList = [NSArray
        arrayWithObjects:@"Work overload", @"We would love to hear more",
                         @"Project feedback and accomplishment", nil];
    [self initViewContent:frame];
  }
  return self;
};

/**
 *  Spereate the whole view into three parts, the head part include emotion
 * image, emotion string
 *  The middle part include the vote detail content
 *  The foot part include the submit button
 *  @param frame frame of the mainView
 */
- (void)initViewContent:(CGRect)frame;
{
  [self contentWithEmotionGreeting];
  [self contentWithVotingDetail];
  [self contentWithSubmitButton];
}

- (void)contentWithEmotionGreeting {
  self.emotionView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"happyIcon"]];
  self.emotionView.contentMode = UIViewContentModeScaleAspectFit;
  self.emotionView.clipsToBounds = YES;
  CGFloat emotionPaddingTop = kPaddingTen;
  CGFloat emotionPaddingLeft = kPaddingFifteen;
  self.emotionView.frame = CGRectMake(emotionPaddingLeft, emotionPaddingTop,
                                      kEmotionWidth, kEmotionHeigth);
  [self addSubview:self.emotionView];

  self.greetingLalel = [[UILabel alloc] init];
  [self.greetingLalel setText:@"Thank you"];
  CGFloat emotionGreetingGap = kPaddingTen;
  CGFloat emotionGreetingTop = kPaddingTen;
  CGFloat greetingPaddingLeft =
      emotionPaddingLeft + kEmotionWidth + emotionGreetingGap;
  CGFloat greetingPaddingRight = kPaddingFifteen;
  CGFloat greetingWidth =
      CGRectGetWidth(self.frame) - greetingPaddingLeft - greetingPaddingRight;
  CGFloat greetingHeight = kEmotionHeigth;
  self.greetingLalel.frame = CGRectMake(greetingPaddingLeft, emotionGreetingTop,
                                        greetingWidth, greetingHeight);
  self.greetingLalel.textAlignment = NSTextAlignmentRight;
  [self addSubview:self.greetingLalel];
  emotionMaxY = CGRectGetMaxY(self.emotionView.frame);
}

- (void)contentWithVotingDetail {
  CGFloat mainTitleY = emotionMaxY + kPaddingTen;
  CGFloat contentpaddingLeftRight = kPaddingTen;
  CGFloat mainTitleWidth =
      CGRectGetWidth(self.frame) - contentpaddingLeftRight * 2;
  CGFloat mainTitleHeight = 15.0f;

  UILabel *mainTitleLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(contentpaddingLeftRight, mainTitleY,
                               mainTitleWidth, mainTitleHeight)];
  [mainTitleLabel setText:kMainTitleContent];
  [mainTitleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
  [self addSubview:mainTitleLabel];

  CGFloat heightForEachQueation =
      (CGRectGetHeight(self.frame) - CGRectGetMaxY(mainTitleLabel.frame) -
       kSubmitButtonHeigth - kSubmitButtonPaddingButton) /
      3;

  CGFloat mainTitleMaxY = CGRectGetMaxY(mainTitleLabel.frame);
  self.workQuestionView = [[PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, mainTitleMaxY,
                                                  CGRectGetWidth(self.frame),
                                                  heightForEachQueation)
                      withLabelContent:questionList[0]];
  [self addSubview:self.workQuestionView];

  CGFloat workQueationViewMaxY = CGRectGetMaxY(self.workQuestionView.frame);
  self.communicationQuestionView = [[PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, workQueationViewMaxY,
                                                  CGRectGetWidth(self.frame),
                                                  heightForEachQueation)
                      withLabelContent:questionList[1]];
  [self addSubview:self.communicationQuestionView];

  CGFloat communicationQueationViewMaxY =
      CGRectGetMaxY(self.communicationQuestionView.frame);
  self.projectQuestionView = [[PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0,
                                                  communicationQueationViewMaxY,
                                                  CGRectGetWidth(self.frame),
                                                  heightForEachQueation)
                      withLabelContent:questionList[2]];
  [self addSubview:self.projectQuestionView];
}

- (void)contentWithSubmitButton {
  CGFloat submitButtonPaddingLeftRight = kPaddingFifteen;
  CGFloat submitButtonWidth =
      CGRectGetWidth(self.frame) - submitButtonPaddingLeftRight * 2;
  CGFloat submitButtonY = CGRectGetHeight(self.frame) -
                          kSubmitButtonPaddingButton - kSubmitButtonHeigth;
  CGRect submitButtonFrame =
      CGRectMake(submitButtonPaddingLeftRight, submitButtonY, submitButtonWidth,
                 kSubmitButtonHeigth);
  self.submitButton = [[UIButton alloc] initWithFrame:submitButtonFrame];
  [self.submitButton setTitle:kSubmitButton forState:UIControlStateNormal];
  self.submitButton.backgroundColor = [UIColor redColor];
  [self addSubview:self.submitButton];
}

- (void)setUserName:(NSString *)userName {
  [self.greetingLalel
      setText:[NSString stringWithFormat:@"Thank you %@", userName]];
}

- (void)setFeedBack:(FeedBackType)feedBack {
  NSString *imageName = @"";
  switch (feedBack) {
  case kHappy:
    imageName = @"happyIcon";
    [self.submitButton setBackgroundColor:HAPPY_COLOR];
    [self.submitButton setTitleColor:HAPPY_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kHappy;
    self.communicationQuestionView.feedBack = kHappy;
    self.workQuestionView.feedBack = kHappy;
    break;
  case kSoso:
    imageName = @"sosoIcon";
    [self.submitButton setBackgroundColor:SOSO_COLOR];
    [self.submitButton setTitleColor:SOSO_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kSoso;
    self.communicationQuestionView.feedBack = kSoso;
    self.workQuestionView.feedBack = kSoso;
    break;
  case kUnHappy:
    imageName = @"unhappyIcon";
    [self.submitButton setBackgroundColor:UNHAPPY_COLOR];
    [self.submitButton setTitleColor:UNHAPPY_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kUnHappy;
    self.communicationQuestionView.feedBack = kUnHappy;
    self.workQuestionView.feedBack = kUnHappy;
    break;
  }
  [self.emotionView setImage:[UIImage imageNamed:imageName]];
}

- (NSArray *)fetchVoteComments {
  NSString *workValue =
      [NSString stringWithFormat:@"%d%%", (int)(self.workQuestionView
                                                    .contentSilderView.value *
                                                100)];
  NSDictionary *workComment =
      [NSDictionary dictionaryWithObjects:@[ workValue, questionList[0] ]
                                  forKeys:@[ @"comment", @"commentCategory" ]];

  NSString *commValue =
      [NSString stringWithFormat:@"%d%%", (int)(self.communicationQuestionView
                                                    .contentSilderView.value *
                                                100)];
  NSDictionary *communicationComment =
      [NSDictionary dictionaryWithObjects:@[ commValue, questionList[1] ]
                                  forKeys:@[ @"comment", @"commentCategory" ]];

  NSString *projectValue =
      [NSString stringWithFormat:@"%d%%", (int)(self.projectQuestionView
                                                    .contentSilderView.value *
                                                100)];
  NSDictionary *projectComment =
      [NSDictionary dictionaryWithObjects:@[ projectValue, questionList[2] ]
                                  forKeys:@[ @"comment", @"commentCategory" ]];

  NSArray *voteComments = [NSArray
      arrayWithObjects:workComment, communicationComment, projectComment, nil];

  return voteComments;
}

@end
