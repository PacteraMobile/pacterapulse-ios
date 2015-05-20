//
//  PPLVoteContentQuestionView.h
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UNHAPPY_COLOR                                                          \
  [UIColor colorWithRed:199.0f / 255.0f                                        \
                  green:241.0f / 255.0f                                        \
                   blue:255.0f / 255.0f                                        \
                  alpha:1.0f]
#define UNHAPPY_FONT_COLOR                                                     \
  [UIColor colorWithRed:83.0f / 255.0f                                         \
                  green:193.0f / 255.0f                                        \
                   blue:112.0f / 255.0f                                        \
                  alpha:1.0f]
#define SOSO_COLOR                                                             \
  [UIColor colorWithRed:221.0f / 255.0f                                        \
                  green:213.0f / 255.0f                                        \
                   blue:255.0f / 255.0f                                        \
                  alpha:1.0f]
#define SOSO_FONT_COLOR                                                        \
  [UIColor colorWithRed:141.0f / 255.0f                                        \
                  green:177.0f / 255.0f                                        \
                   blue:255.0f / 255.0f                                        \
                  alpha:1.0f]
#define HAPPY_COLOR                                                            \
  [UIColor colorWithRed:255.0f / 255.0f                                        \
                  green:239.0f / 255.0f                                        \
                   blue:198.0f / 255.0f                                        \
                  alpha:1.0f]
#define HAPPY_FONT_COLOR                                                       \
  [UIColor colorWithRed:255.0f / 255.0f                                        \
                  green:108.0f / 255.0f                                        \
                   blue:97.0f / 255.0f                                         \
                  alpha:1.0f]
typedef enum { kHappyIcon, kSosoIcon, kUnHappyIcon } FeedBackType;

@interface PPLVoteContentQuestionView : UIView
@property(nonatomic, strong) UISlider *contentSilderView;
@property(nonatomic, assign) FeedBackType feedBack;

- (instancetype)initContentQuestionViewWithFrame:(CGRect)frame
                                withLabelContent:(NSString *)content;

@end
