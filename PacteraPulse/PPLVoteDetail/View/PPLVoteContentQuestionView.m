//
//  PPLVoteContentQuestionView.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteContentQuestionView.h"
@interface PPLVoteContentQuestionView ()
@property(nonatomic, strong)NSString *labelContet;
@end

@implementation PPLVoteContentQuestionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initContentQuestionViewWithFrame:(CGRect)frame withLabelContent:(NSString*)content
{
  self = [super initWithFrame:frame];
  if (self) {
    self.labelContet = content;
    [self initVoteContentView:frame];
  }
  return self;
}

- (void)initVoteContentView:(CGRect)frame
{
  CGFloat frameHeight = CGRectGetHeight(frame);
  CGFloat frameWidth = CGRectGetWidth(frame);
  CGFloat paddingLeft = 10.0f;
  CGFloat paddingTop = 5.0f;
  CGFloat itemHeight = frameHeight/3;
  CGFloat labelWidth = frameWidth - paddingLeft*2;
  UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(paddingLeft, 0, labelWidth, itemHeight)];
  [contentLabel setText:self.labelContet];
  
  CGFloat processPaddingLeft = 15.0f;
  UISlider *contentSilderView = [[UISlider alloc] initWithFrame:CGRectMake(processPaddingLeft, itemHeight+paddingTop, (frameWidth - paddingLeft*2), 12.0f)];
  
  
  CGFloat badGoodLabelWidth = 45.0f;
  CGFloat badGoodLabelHeigth = 25.0f;
  UILabel *badLabel = [[UILabel alloc]initWithFrame:CGRectMake(processPaddingLeft, itemHeight+paddingTop, badGoodLabelWidth, badGoodLabelHeigth)];
  [badLabel setText:@"Bad"];
  
  UILabel *goodLabel = [[UILabel alloc]initWithFrame:CGRectMake((frameWidth -badGoodLabelWidth -processPaddingLeft), itemHeight+paddingTop, badGoodLabelWidth, badGoodLabelHeigth)];
  [goodLabel setText:@"Good"];

  [self addSubview:contentLabel];
  [self addSubview:contentSilderView];
  [self addSubview:badLabel];
  [self addSubview:goodLabel];
}
@end
