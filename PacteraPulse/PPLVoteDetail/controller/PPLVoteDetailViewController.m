//
//  PPLVoteDetailViewController.m
//  PacteraPulse
//
//  Created by jin on 19/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteDetailViewController.h"
@interface PPLVoteDetailViewController ()

@end

@implementation PPLVoteDetailViewController
NSString *const kSummaryPageSegueId = @"showSummary";


- (void)viewDidLoad {
    [super viewDidLoad];
  
  PPLVoteContentView *voteContentView = [[PPLVoteContentView alloc]initViewWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), (CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.navigationController.navigationBar.frame)))];
  [self.view addSubview:voteContentView];
  [voteContentView setFeedBack:self.feedBack];
  self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)clickSubmitButton:(id)sender {
  
  [self performSegueWithIdentifier:kSummaryPageSegueId sender:nil];
}

@end
