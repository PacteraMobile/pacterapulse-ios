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

#import <UIKit/UIKit.h>
#import "PPLUtils.h"
#define UNHAPPY_COLOR                                                          \
    [UIColor colorWithRed:199.0f / 255.0f                                      \
                    green:241.0f / 255.0f                                      \
                     blue:255.0f / 255.0f                                      \
                    alpha:1.0f]
#define UNHAPPY_FONT_COLOR                                                     \
    [UIColor colorWithRed:83.0f / 255.0f                                       \
                    green:193.0f / 255.0f                                      \
                     blue:112.0f / 255.0f                                      \
                    alpha:1.0f]
#define SOSO_COLOR                                                             \
    [UIColor colorWithRed:221.0f / 255.0f                                      \
                    green:213.0f / 255.0f                                      \
                     blue:255.0f / 255.0f                                      \
                    alpha:1.0f]
#define SOSO_FONT_COLOR                                                        \
    [UIColor colorWithRed:141.0f / 255.0f                                      \
                    green:177.0f / 255.0f                                      \
                     blue:255.0f / 255.0f                                      \
                    alpha:1.0f]
#define HAPPY_COLOR                                                            \
    [UIColor colorWithRed:255.0f / 255.0f                                      \
                    green:239.0f / 255.0f                                      \
                     blue:198.0f / 255.0f                                      \
                    alpha:1.0f]
#define HAPPY_FONT_COLOR                                                       \
    [UIColor colorWithRed:255.0f / 255.0f                                      \
                    green:108.0f / 255.0f                                      \
                     blue:97.0f / 255.0f                                       \
                    alpha:1.0f]

@interface PPLVoteContentQuestionView : UIView
@property(nonatomic, strong) UISlider *contentSilderView;
@property(nonatomic, assign) FeedBackType feedBack;
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
                                withLabelContent:(NSString *)content;

@end
