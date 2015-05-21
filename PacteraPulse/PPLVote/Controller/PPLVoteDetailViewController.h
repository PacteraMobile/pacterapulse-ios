//
//  PPLVoteDetailViewController.h
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLVoteContentView.h"
#import "PPLVoteMainViewController.h"

@interface PPLVoteDetailViewController : UIViewController
@property(nonatomic, assign) FeedBackType feedBack;

@property (strong, nonatomic)  PPLVoteMainViewController *pageController;

@end
