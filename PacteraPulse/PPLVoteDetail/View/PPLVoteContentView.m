//
//  PPLVoteContentView.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteContentView.h"
#import "PPLVoteContentQuestionView.h"
@interface PPLVoteContentView () {
  CGFloat emotionMaxY;
  NSArray *questionList;
}
@property(nonatomic, strong) UILabel *greetingLalel;
@property(nonatomic, strong) UIImageView *emotionView;
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

- (instancetype)initViewWithFeedBack:(NSString *)feedback
                           withFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.feedBack = feedback;
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
  self.emotionView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"happyIcon"]];
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
  PPLVoteContentQuestionView *workQuestionView = [
      [PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, mainTitleMaxY,
                                                  CGRectGetWidth(self.frame),
                                                  heightForEachQueation)
                      withLabelContent:questionList[0] withFeedBackType:kUnHappyIcon];
  [self addSubview:workQuestionView];

  CGFloat workQueationViewMaxY = CGRectGetMaxY(workQuestionView.frame);
  PPLVoteContentQuestionView *communicationQuestionView = [
      [PPLVoteContentQuestionView alloc]
      initContentQuestionViewWithFrame:CGRectMake(0, workQueationViewMaxY,
                                                  CGRectGetWidth(self.frame),
                                                  heightForEachQueation)
                      withLabelContent:questionList[1] withFeedBackType:kUnHappyIcon];
  [self addSubview:communicationQuestionView];

  CGFloat communicationQueationViewMaxY =
      CGRectGetMaxY(communicationQuestionView.frame);
  PPLVoteContentQuestionView *projectQuestionView =
      [[PPLVoteContentQuestionView alloc]
          initContentQuestionViewWithFrame:CGRectMake(
                                               0, communicationQueationViewMaxY,
                                               CGRectGetWidth(self.frame),
                                               heightForEachQueation)
                          withLabelContent:questionList[2] withFeedBackType:kUnHappyIcon];
  [self addSubview:projectQuestionView];
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
  UIButton *submitButton = [[UIButton alloc] initWithFrame:submitButtonFrame];
  [submitButton setTitle:kSubmitButton forState:UIControlStateNormal];
  submitButton.backgroundColor = [UIColor redColor];
  [self addSubview:submitButton];
}

- (void)setUserName:(NSString *)userName {
  [self.greetingLalel
      setText:[NSString stringWithFormat:@"Thank you %@", userName]];
}

- (void)setFeedBack:(NSString *)feedBack {
  NSString *imageName = @"";
  switch ([feedBack integerValue]) {
  case 1:
    imageName = @"happyIcon";
    break;
  case 2:
    imageName = @"sosIcon";
    break;
  case 3:
    imageName = @"unhappyIcon";
    break;
  default:
    imageName = @"happyIcon";
    break;
  }
  [self.emotionView setImage:[UIImage imageNamed:imageName]];
}

@end
