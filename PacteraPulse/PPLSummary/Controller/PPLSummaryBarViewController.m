//
//  PPLSummaryBarViewController.m
//  PacPulse
//
//  Created by Randy.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLSummaryBarViewController.h"
#import "PPLColoredBarChart.h"
#import "PPLSummaryData.h"
#import "PPLSummaryGenerals.h"
#import "PPLAuthenticationController.h"
#import "MBProgressHUD.h"
#import "CSNotificationView.h"
#import "PPLUtils.h"

@interface PPLSummaryBarViewController ()

@property(nonatomic, strong) CPTGraphHostingView *hostingView;
@property(nonatomic, strong) PPLColoredBarChart *barItem;
@property(nonatomic, strong) NSArray *summaryData;
@property(nonatomic, strong) CSNotificationView *alertView;
@property(nonatomic, strong) UISegmentedControl *segmentControlView;

@end

@implementation PPLSummaryBarViewController

#pragma View controller handlers
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitViewSetting];
    [self fetchRemoteData:sResultPeriodDay];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hideVotedNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma View init setting
- (void)InitViewSetting
{
    self.barItem = [[PPLColoredBarChart alloc] init];
    self.alertView = nil;
    [self configureHost];
    [self setTitle:[NSString stringWithFormat:@"%@ %@",sResultPeriodDayTitle,sPPLSummaryTilte]];
    UIBarButtonItem *rightButton =
    [[UIBarButtonItem alloc] initWithTitle:sPPLSummaryLogout
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(LogoutSession)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self addSegmentControlOfPeriod];
    [self showVotedNotification];
}

#pragma logout page
- (void)LogoutSession
{
    PPLAuthenticationController* instance = [PPLAuthenticationController sharedInstance];
    if([instance checkIfLoggedIn:nil])
    {
        [instance logoutUser];
        [[PPLUtils sharedInstance] showLaunch:self];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Logout operation."
                              message:sPPLSummaryLogoutAlert
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        //[alert show];
        alert = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Logout operation."
                              message:sPPLSummaryLogoutPrompts
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
}

#pragma Voted Notification View
- (void)showVotedNotification
{
    if (self.shouldShowAlert)
    {
        self.alertView = [CSNotificationView
            notificationViewWithParentViewController:self
                                           tintColor:[UIColor redColor]
                                               image:nil
                                             message:sPPLSummaryVoteAgainAlert];
        self.alertView.showingActivity = YES;
        [self.alertView setVisible:YES animated:YES completion:nil];
        [self.alertView dismissWithStyle:CSNotificationViewStyleError
                                 message:sPPLSummaryVoteAgainAlert
                                duration:0.1
                                animated:YES];
    }
}

- (void)hideVotedNotification
{
    if (self.shouldShowAlert && self.alertView != nil)
    {
        self.alertView.showingActivity = NO;
        [self.alertView setVisible:NO animated:YES completion:nil];
        self.alertView = nil;
    }
}


#pragma Segment Control View
- (void)addSegmentControlOfPeriod
{
    CGRect parentRect = self.view.bounds;
    self.segmentControlView = [[UISegmentedControl alloc]
        initWithItems:[NSArray arrayWithObjects:sResultPeriodDayTitle,
                                                sResultPeriodWeekTitle,
                                                sResultPeriodMonthTitle, nil]];
    [self.segmentControlView addTarget:self
                                action:@selector(ShowBarChartInPeriod:)
                      forControlEvents:UIControlEventValueChanged];
    self.segmentControlView.frame =
        CGRectMake(0, parentRect.size.height - iTitleSpace,
                   parentRect.size.width, iTitleSpace);//bottom position
    self.segmentControlView.momentary = NO;
    [self.segmentControlView setTintColor:[UIColor blackColor]];
    self.segmentControlView.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentControlView];
}

- (void)ShowBarChartInPeriod:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControlView])
    {
        NSString *period = sResultPeriodDay;
        NSString *title = sResultPeriodDayTitle;
        switch (paramSender.selectedSegmentIndex)
        {
        case 0:
            period = sResultPeriodDay;
            title = sResultPeriodDayTitle;
            break;
        case 1:
            period = sResultPeriodWeek;
            title = sResultPeriodWeekTitle;
            break;
        case 2:
            period = sResultPeriodMonth;
            title = sResultPeriodMonthTitle;
            break;
        default:
            break;
        }
        [self fetchRemoteData:period];
        [self setTitle:[NSString stringWithFormat:@"%@ %@",period,sPPLSummaryTilte]];
    }
}

#pragma Bar Chart View
- (void)configureHost
{
    CGRect parentRect = self.view.bounds;
    parentRect.origin.y += iTitleSpace;
    parentRect.size.height -= 2 * iTitleSpace; // One for lable space in top,
                                               // one for segment control space
                                               // in bottom
    self.hostingView = [(CPTGraphHostingView *)[CPTGraphHostingView alloc]
        initWithFrame:parentRect];
    self.hostingView.allowPinchScaling = YES;
    [self.view addSubview:self.hostingView];
    self.hostingView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
}

- (void)configureBarView:(NSArray *)fetchedData
{
    self.summaryData = fetchedData;
    self.barItem.summaryData = self.summaryData;
    [self.barItem renderInView:self.hostingView withTheme:nil animated:YES];
}

#pragma Network requests
- (void)fetchRemoteData:(NSString *)period
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[PPLSummaryData shareInstance]
        emotionValues:period
             callBack:^(BOOL status, NSArray *graphValues, NSError *error) {
               if (status && error == nil && graphValues != nil &&
                   [graphValues count] > 0)
               {

                   NSMutableArray *updatedData =
                       [NSMutableArray arrayWithArray:graphValues];
                   float totalCount = 0;
                   // Calculating total count
                   NSInteger arrCount = [graphValues count];
                   for (int i = 0; i < arrCount; i++)
                   {
                       totalCount += [[[updatedData objectAtIndex:i]
                           valueForKey:kEmotionValue] integerValue];
                   }

                   // Calculating percentage from each emotion
                   for (int i = 0; i < arrCount; i++)
                   {
                       float percentage = 0;
                       if (totalCount != 0)
                       {
                           percentage =
                               [[[updatedData objectAtIndex:i]
                                   valueForKey:kEmotionValue] floatValue] *
                               iMaxPercent / totalCount;
                       }
                       [[updatedData objectAtIndex:i]
                           setObject:[NSNumber numberWithFloat:percentage]
                              forKey:kEmotionValue];
                   }
                   dispatch_async(dispatch_get_main_queue(), ^{
                     [self configureBarView:updatedData];
                   });
               }
               else
               {
                   UIAlertView *alert = [[UIAlertView alloc]
                           initWithTitle:@"Error"
                                 message:sPPLSummaryFetchDataFailed
                                delegate:self
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil];
                   [alert show];
                   alert = nil;
               }
               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             }];
}


@end
