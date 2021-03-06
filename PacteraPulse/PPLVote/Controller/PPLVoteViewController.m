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

#import "PPLVoteViewController.h"
#import "PPLVoteTableViewCell.h"
#import "PPLNetworkingHelper.h"
#import "MBProgressHUD.h"
#import "PPLLaunchViewController.h"
#import "PPLVoteRow.h"
#import "AppDelegate.h"
#import "PPLVoteManagerClass.h"
#import "PPLSummaryBarViewController.h"
#import "PPLAuthenticationController.h"
#import "PPLVoteDetailViewController.h"
#import "PPLUtils.h"
#import "PPLAuthenticationSettings.h"
static NSString *kViewTitle = @"How Do You Feel Today?";
static NSString *kLoginError = @"Could not authenticate you";

NSString *const kSummarySegueId = @"toSummary";
NSString *const kNavigationButtonTitle = @"Info";
enum voteAction
{
    VOTE_NOT_SUBMITTED,
    VOTE_SUBMITTED,
    VOTE_NO_ACTION
} voteState;
@interface PPLVoteViewController ()


@end

@implementation PPLVoteViewController

NSString *const kCellId = @"voteCell";
NSInteger const kPadding = 10;
FeedBackType currentFeedback = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [PPLVoteRow initObjects];
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.title = kViewTitle;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                             target:self
                             action:@selector(showResult:)];
    UIBarButtonItem *leftButton =
        [[UIBarButtonItem alloc] initWithTitle:kNavigationButtonTitle
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(showLaunch:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;

    [self initPPLVoteData];
    [self loadToken];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    voteState = VOTE_NO_ACTION;
    [self.voteData setFeedbackSubmitted:NO];
}
/**
 *  This function checks for a valid token and shows a login page if it can not
 * find the token
 */
- (void)loadToken
{
    PPLAuthenticationController *auth =
        [PPLAuthenticationController sharedInstance];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [auth getToken:self
        completionHandler:^(NSString *accessToken, NSError *error) {

          if (accessToken == nil)
          {
              UIAlertView *alert =
                  [[UIAlertView alloc] initWithTitle:nil
                                             message:kLoginError
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];

              [alert setDelegate:self];

              dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                [alert show];

              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{

                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              });
          }
        }];
}

- (void)initPPLVoteData
{
    self.voteData = [PPLVoteData shareInstance];
    PPLAuthenticationSettings *authentication =
        [PPLAuthenticationSettings loadSettings];
    [self.voteData setUserID:authentication.getUserId];
    [self.voteData setFirstName:authentication.getFirstName];
    [self.voteData setLastName:authentication.getLastName];
    [self.voteData setEmail:authentication.getEmailAddress];
}
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

/**
 *  Tap gesture to submit the feedback to the server and go to summary screen on
 *success
 *
 *  @param recognizer singleTao gesture
 */
- (void)handleClick:(id)sender
{
    UIView *senderView = (UIView *)sender;

    __block FeedBackType currentFeedback = (FeedBackType)senderView.tag;

    [self.voteData setFeedBackType:currentFeedback];

    PPLVoteManagerClass *voteManager = [PPLVoteManagerClass sharedInstance];

    if ([voteManager checkIfVoteSubmittedToday])
    {
        voteState = VOTE_NOT_SUBMITTED;
        [self performSegueWithIdentifier:kSummarySegueId sender:nil];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        // Send the feedback via data model, we provide two callbacks one for
        // success and one for failure
        [self.voteData sendFeedback:^(BOOL status, NSString *serverResponse,
                                      NSError *error) {
          if (status)
          {
              voteState = VOTE_SUBMITTED;
              NSData *response =
                  [serverResponse dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary *jsonData = [NSJSONSerialization
                  JSONObjectWithData:response
                             options:NSJSONReadingMutableContainers
                               error:&error];
              NSString *voteID = [[jsonData objectForKey:@"emotionVote"]
                  objectForKey:@"voteId"];
              [voteManager recordVoteIDIntoCache:voteID];
              [voteManager
                  recordVoteSubmission:
                      [NSString
                          stringWithFormat:@"%ld", (long)currentFeedback]];
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [self performSegueWithIdentifier:kSummarySegueId sender:nil];
          }
          else
          {
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
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // count number of row from counting array here category is An Array
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPLVoteTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:kCellId];

    PPLVoteRow *item = self.data[indexPath.row];
    [cell setUpRow:item];
    [cell.emotionButton addTarget:self
                           action:@selector(handleClick:)
                 forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark -TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

/**
 *  We need to create the row sizes so we only show the required options on the
 * screens
 *  we calculate dynamically the size based on total images we have
 */
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    screenHeight -= self.navigationController.navigationBar.frame.size.height;
    return (screenHeight / self.data.count - kPadding);
}

#pragma mark - Navigation

#pragma - mark UIAllertViewDelegate
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{

    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    [[PPLUtils sharedInstance] showLaunch:self];
}
#pragma - mark Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSummarySegueId])
    {
        PPLSummaryBarViewController *destinationController =
            (PPLSummaryBarViewController *)segue.destinationViewController;

        // Check the current vote state and set the variable for destination
        switch (voteState)
        {
        case VOTE_NOT_SUBMITTED:
            destinationController.shouldShowAlert = YES;
            break;
        case VOTE_NO_ACTION:
        case VOTE_SUBMITTED:
            destinationController.shouldShowAlert = NO;
            break;
        }
    }
}
- (void)showResult:(id)sender
{
    [self performSegueWithIdentifier:kSummarySegueId sender:nil];
}

- (void)showLaunch:(id)sender { [[PPLUtils sharedInstance] showLaunch:self]; }
@end
