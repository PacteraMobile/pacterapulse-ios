//
//  PPLVoteContentView.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteContentView.h"
#import "PPLVoteContentQuestionView.h"
@interface PPLVoteContentView (){
  CGFloat emotionMaxY;
}
@property(nonatomic,strong)NSString *feedback;

@end


@implementation PPLVoteContentView

CGFloat const kPaddingTen = 10.0f;
CGFloat const kPaddingFifteen = 15.0f;
CGFloat const kPaddingTwenty = 20.0f;
CGFloat const kEmotionWidth = 70.0f;
CGFloat const kEmotionHeigth = 70.0f;
CGFloat const kSubmitButtonHeigth = 34.0f;
CGFloat const kSubmitButtonPaddingButton = 15.0f;

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
    self.feedback = feedback;
    self.frame = frame;
    [self initViewContent:frame];
  }
  return self;
};



/**
 *  Spereate the whole view into three parts, the head part include emotion image, emotion string
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

- (void)contentWithEmotionGreeting
{
  UIImageView *emotionView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"happyIcon"]];
  emotionView.contentMode = UIViewContentModeScaleAspectFit;
  emotionView.clipsToBounds = YES;
  CGFloat emotionPaddingTop = kPaddingTen;
  CGFloat emotionPaddingLeft = kPaddingFifteen;
  emotionView.frame = CGRectMake(emotionPaddingLeft, emotionPaddingTop, kEmotionWidth, kEmotionHeigth);
  [self addSubview:emotionView];
  
  UILabel *greetingLalel = [[UILabel alloc]init];
  [greetingLalel setText:@"Thank you Dan!"];
  CGFloat emotionGreetingGap = kPaddingTen;
  CGFloat emotionGreetingTop = kPaddingTen;
  CGFloat greetingPaddingLeft = emotionPaddingLeft + kEmotionWidth + emotionGreetingGap;
  CGFloat greetingPaddingRight = kPaddingFifteen;
  CGFloat greetingWidth = CGRectGetWidth(self.frame) - greetingPaddingLeft - greetingPaddingRight;
  CGFloat greetingHeight = kEmotionHeigth;
  greetingLalel.frame = CGRectMake(greetingPaddingLeft, emotionGreetingTop, greetingWidth, greetingHeight);
  greetingLalel.textAlignment = NSTextAlignmentRight;
  [self addSubview:greetingLalel];
  emotionMaxY = CGRectGetMaxY(emotionView.frame);
}

- (void)contentWithVotingDetail
{
  CGFloat mainTitleY = emotionMaxY + kPaddingTen;
  CGFloat contentpaddingLeftRight = kPaddingTen;
  CGFloat mainTitleWidth = CGRectGetWidth(self.frame) - contentpaddingLeftRight*2;
  CGFloat mainTitleHeight =15.0f;

  UILabel *mainTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(contentpaddingLeftRight, mainTitleY, mainTitleWidth, mainTitleHeight)];
  [mainTitleLabel setText:@"We would love to hear more"];
  [self addSubview:mainTitleLabel];
  
  CGFloat heightForEachQueation = (CGRectGetHeight(self.frame)-CGRectGetMaxY(mainTitleLabel.frame) - kSubmitButtonHeigth - kSubmitButtonPaddingButton)/3;

  CGFloat mainTitleMaxY = CGRectGetMaxY(mainTitleLabel.frame);
  PPLVoteContentQuestionView *workQuestionView = [[PPLVoteContentQuestionView alloc]initContentQuestionViewWithFrame:CGRectMake(0, mainTitleMaxY, CGRectGetWidth(self.frame) , heightForEachQueation) withLabelContent:@"Work overload-"];
  [self addSubview:workQuestionView];
  
  CGFloat workQueationViewMaxY = CGRectGetMaxY(workQuestionView.frame);
  PPLVoteContentQuestionView *communicationQuestionView = [[PPLVoteContentQuestionView alloc]initContentQuestionViewWithFrame:CGRectMake(0, workQueationViewMaxY, CGRectGetWidth(self.frame) , heightForEachQueation) withLabelContent:@"Communication with colleague-"];
  [self addSubview:communicationQuestionView];
 
  CGFloat communicationQueationViewMaxY = CGRectGetMaxY(communicationQuestionView.frame);
  PPLVoteContentQuestionView *projectQuestionView = [[PPLVoteContentQuestionView alloc]initContentQuestionViewWithFrame:CGRectMake(0, communicationQueationViewMaxY, CGRectGetWidth(self.frame) , heightForEachQueation) withLabelContent:@"Project feedback and accomplishment-"];
  [self addSubview:projectQuestionView];

}

- (void)contentWithSubmitButton
{
  CGFloat submitButtonPaddingLeftRight = kPaddingFifteen;
  CGFloat submitButtonWidth = CGRectGetWidth(self.frame) - submitButtonPaddingLeftRight*2;
  CGFloat submitButtonY = CGRectGetHeight(self.frame) - kSubmitButtonPaddingButton-kSubmitButtonHeigth;
  CGRect submitButtonFrame = CGRectMake(submitButtonPaddingLeftRight, submitButtonY, submitButtonWidth, kSubmitButtonHeigth);
  UIButton *submitButton = [[UIButton alloc]initWithFrame:submitButtonFrame];
  [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
  submitButton.backgroundColor = [UIColor redColor];
  [self addSubview:submitButton];
  NSLog(@"%f",CGRectGetMinY(submitButton.frame));
  NSLog(@"%f",CGRectGetHeight(self.frame));
}

@end
