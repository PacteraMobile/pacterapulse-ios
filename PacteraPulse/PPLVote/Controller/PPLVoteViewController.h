//
//  PPLVoteViewController.h
//  PacteraPulse
//
//  Created by Qazi.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLVoteMainViewController.h"

@interface PPLVoteViewController : UIViewController <UITableViewDelegate,
                                                     UITableViewDataSource,
                                                     UIAlertViewDelegate>
@property (strong, nonatomic)  PPLVoteMainViewController *pageController;

@end
