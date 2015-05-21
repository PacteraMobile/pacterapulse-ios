//
//  PPLVoteContentView.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
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
        arrayWithObjects:@"Work overload-", @"We would love to hear more",
                         @"Project feedback and accomplishment-", nil];
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
  case kHappyIcon:
    imageName = @"happyIcon";
    [self.submitButton setBackgroundColor:HAPPY_COLOR];
    [self.submitButton setTitleColor:HAPPY_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kHappyIcon;
    self.communicationQuestionView.feedBack = kHappyIcon;
    self.workQuestionView.feedBack = kHappyIcon;
    break;
  case kSosoIcon:
    imageName = @"sosoIcon";
    [self.submitButton setBackgroundColor:SOSO_COLOR];
    [self.submitButton setTitleColor:SOSO_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kSosoIcon;
    self.communicationQuestionView.feedBack = kSosoIcon;
    self.workQuestionView.feedBack = kSosoIcon;
    break;
  case kUnHappyIcon:
    imageName = @"unhappyIcon";
    [self.submitButton setBackgroundColor:UNHAPPY_COLOR];
    [self.submitButton setTitleColor:UNHAPPY_FONT_COLOR
                            forState:UIControlStateNormal];
    self.projectQuestionView.feedBack = kUnHappyIcon;
    self.communicationQuestionView.feedBack = kUnHappyIcon;
    self.workQuestionView.feedBack = kUnHappyIcon;
    break;
  }
  [self.emotionView setImage:[UIImage imageNamed:imageName]];
}

- (NSArray *)fetchVoteComments {
  NSMutableArray *voteComments = [NSMutableArray array];
  [voteComments
      addObject:[NSString
                    stringWithFormat:@"%f", self.workQuestionView
                                                .contentSilderView.value]];
  [voteComments
      addObject:[NSString
                    stringWithFormat:@"%f", self.communicationQuestionView
                                                .contentSilderView.value]];
  [voteComments
      addObject:[NSString
                    stringWithFormat:@"%f", self.projectQuestionView
                                                .contentSilderView.value]];

  return voteComments;
}

@end
