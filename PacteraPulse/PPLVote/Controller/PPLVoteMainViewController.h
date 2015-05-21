//
//  PPLVoteMainViewController.h
//  PacteraPulse
//
//  Created by Qazi on 21/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPLVoteMainViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *myViewControllers;

- (void)showLaunch:(id)sender;

@end
