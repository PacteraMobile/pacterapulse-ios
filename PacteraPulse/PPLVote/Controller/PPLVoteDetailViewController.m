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

#import "PPLVoteDetailViewController.h"
#import "PPLAuthenticationSettings.h"
#import "PPLVoteManagerClass.h"
#import "MBProgressHUD.h"
#import "PPLVoteData.h"
#import "PPLSummaryBarViewController.h"
#import "PPLAuthenticationController.h"
#import "PPLSummaryGenerals.h"

@interface PPLVoteDetailViewController ()
@property(nonatomic, strong) PPLVoteContentView *voteContentView;
@property(nonatomic, strong) PPLVoteData *voteData;
@end

@implementation PPLVoteDetailViewController
NSString *const kSummaryPageSegueId = @"showSummary";

- (void)viewDidLoad {
  [super viewDidLoad];
  _voteData = [PPLVoteData shareInstance];

  self.voteContentView = [[PPLVoteContentView alloc]
      initViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),
                                   (CGRectGetHeight(self.view.frame) -
                                    CGRectGetMaxY(self.navigationController
                                                      .navigationBar.frame)))];
  self.voteData.firstName =
      [[PPLAuthenticationSettings loadSettings] getFirstName];
  [self.view addSubview:self.voteContentView];
  [self.voteContentView setFeedBack:self.voteData.feedBackType];
  [self.voteContentView setUserName:self.voteData.firstName];
  [self.voteContentView.submitButton addTarget:self
                                        action:@selector(clickSubmitButton:)
                              forControlEvents:UIControlEventTouchUpInside];
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated {
  [self.voteContentView setFeedBack:self.voteData.feedBackType];
  [self setupNavigationBarButton];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma setupNavigationButton
- (void)setupNavigationBarButton {
  UIBarButtonItem *rightButton;
  rightButton =
      [[UIBarButtonItem alloc] initWithTitle:sPPLSummaryLogout
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(LogoutSession)];

  self.navigationItem.rightBarButtonItem = rightButton;
}
#pragma logout page
- (void)LogoutSession {
  PPLAuthenticationController *instance =
      [PPLAuthenticationController sharedInstance];
  if ([instance checkIfLoggedIn:nil]) {

    UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Logout operation"
                                   message:sPPLSummaryLogoutAlert
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:@"Cancel", nil];
    [alert show];
    alert = nil;
  } else {
    UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Logout operation"
                                   message:sPPLSummaryLogoutPrompts
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
    [alert show];
    alert = nil;
  }
}

- (IBAction)clickSubmitButton:(id)sender {

  PPLVoteManagerClass *voteManager = [PPLVoteManagerClass sharedInstance];
  NSString *voteID = [voteManager getVoteIDFromCache];
  NSArray *comments = [self.voteContentView fetchVoteComments];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];

  // Send the feedback via data model, we provide two callbacks one for
  // success and one for failure
  [self.voteData
      sendDetailFeedback:voteID
        feedBackComments:comments
                callBack:^(BOOL status, NSString *serverResponse,
                           NSError *error) {
                  if (status) {
                    self.voteData.feedbackSubmitted = NO;
                    NSLog(@"Vote Detail:  %@", serverResponse);
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                  } else {
                    UIAlertView *alert = [[UIAlertView alloc]
                            initWithTitle:@"Error"
                                  message:@"Issue submitting feedback to server"
                                 delegate:nil
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil];
                    [alert show];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                  }

                }];
}

#pragma mark alertViewDelegate
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    PPLAuthenticationController *instance =
        [PPLAuthenticationController sharedInstance];
    [instance logoutUser];
    [[PPLUtils sharedInstance] showLaunch:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
  }
}

@end
