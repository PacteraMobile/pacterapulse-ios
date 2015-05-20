//
//  PPLVoteContentView.h
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPLVoteContentView : UIView
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *feedBack;
- (instancetype)initViewWithFeedBack:(NSString*)feedback withFrame:(CGRect)frame;
@end
