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

#import "PPLLaunchViewController.h"

@interface PPLLaunchViewController ()

@property(nonatomic, weak) IBOutlet UIImageView *launchImageView;

@end

@implementation PPLLaunchViewController

NSString *const kVoteSegueId = @"showVoteOption";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // The image would be linked with a tap gesture, so clicking anywhere on the
    // screen
    // would take you to
    // Voting screen
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]
        initWithTarget:self
                action:@selector(handleSingleTap:)];
    [self.launchImageView addGestureRecognizer:singleFingerTap];
    self.launchImageView.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTap:(id)sender
{
    [self performSegueWithIdentifier:kVoteSegueId sender:nil];
}

@end
