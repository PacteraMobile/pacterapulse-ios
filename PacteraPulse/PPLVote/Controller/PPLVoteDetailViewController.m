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
@interface PPLVoteDetailViewController ()
@property(nonatomic, strong) PPLVoteContentView *voteContentView;
@property(nonatomic, strong) PPLVoteData *voteData;
@end

@implementation PPLVoteDetailViewController
NSString *const kSummaryPageSegueId = @"showSummary";


- (void)viewDidLoad {
  [super viewDidLoad];
  self.voteContentView = [[PPLVoteContentView alloc]
      initViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),
                                   (CGRectGetHeight(self.view.frame) -
                                    CGRectGetMaxY(self.navigationController
                                                      .navigationBar.frame)))];
  [self.view addSubview:self.voteContentView];
  [self.voteContentView setFeedBack:self.feedBack];
  [self.voteContentView setUserName:self.voteData.firstName];
  [self.voteContentView.submitButton addTarget:self
                                        action:@selector(clickSubmitButton:)
                              forControlEvents:UIControlEventTouchUpInside];
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.voteContentView setFeedBack:self.feedBack];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



- (IBAction)clickSubmitButton:(id)sender {
    
    //TODO:udate this to take vote id from previous submmsion and add details
    

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



@end
