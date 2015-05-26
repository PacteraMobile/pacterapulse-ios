//
//  PPLVoteDetailViewController.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
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
  [self.view addSubview:self.voteContentView];
  [self.voteContentView setFeedBack:self.voteData.feedBackType];
  [self.voteContentView setUserName:self.voteData.firstName];
  [self.voteContentView.submitButton addTarget:self
                                        action:@selector(clickSubmitButton:)
                              forControlEvents:UIControlEventTouchUpInside];
  self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.voteContentView setFeedBack:self.voteData.feedBackType];
    [self setupNavigationBarButton];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma setupNavigationButton
-(void)setupNavigationBarButton
{
    UIBarButtonItem *rightButton;
          rightButton = [[UIBarButtonItem alloc] initWithTitle:sPPLSummaryLogout
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(LogoutSession)];
        
    self.navigationItem.rightBarButtonItem = rightButton;
    
}
#pragma logout page
- (void)LogoutSession
{
    PPLAuthenticationController* instance = [PPLAuthenticationController sharedInstance];
    if([instance checkIfLoggedIn:nil])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Logout operation"
                              message:sPPLSummaryLogoutAlert
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:@"Cancel",nil];
        [alert show];
        alert = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Logout operation"
                              message:sPPLSummaryLogoutPrompts
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
}



- (IBAction)clickSubmitButton:(id)sender {
    
    //TODO: Need to submit data to server here before going back
    [self.navigationController popViewControllerAnimated:YES];
    self.voteData.feedbackSubmitted = NO;
    
    //TODO: Modify this old code to send new data to the server
    //  PPLVoteManagerClass *voteManager = [PPLVoteManagerClass sharedInstance];
    //  NSArray *comments = [self.voteContentView fetchVoteComments];
    //  [self.voteData setComments:comments];
    //  [self.voteData setFeedBackType:self.feedBack];
    //  if ([voteManager checkIfVoteSubmittedToday]) {
    //    voteState = VOTE_NOT_SUBMITTED;
    //    [self performSegueWithIdentifier:kSummaryPageSegueId sender:nil];
    //  } else {
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //
    //    // Send the feedback via data model, we provide two callbacks one for
    //    // success and one for failure
    //    [self.voteData
    //        sendFeedback:^(BOOL status, NSString *serverResponse, NSError *error) {
    //          if (status) {
    //            voteState = VOTE_SUBMITTED;
    //            [voteManager
    //                recordVoteSubmission:
    //                    [NSString stringWithFormat:@"%ld", (long)self.feedBack]];
    //            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //            [self performSegueWithIdentifier:kSummaryPageSegueId sender:nil];
    //          } else {
    //            UIAlertView *alert = [[UIAlertView alloc]
    //                    initWithTitle:@"Error"
    //                          message:@"Issue submitting feedback to server"
    //                         delegate:nil
    //                cancelButtonTitle:@"OK"
    //                otherButtonTitles:nil];
    //            [alert show];
    //            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //          }
    //
    //        }];
    //  }
    
}

#pragma mark alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        PPLAuthenticationController* instance = [PPLAuthenticationController sharedInstance];
        [instance logoutUser];
        [[PPLUtils sharedInstance] showLaunch:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



@end
