//
//  PPLVoteMainViewController.m
//  PacteraPulse
//
//  Created by Qazi on 21/05/2015.
//  Copyright (c) 2015 Pactera. All rights reserved.
//

#import "PPLVoteMainViewController.h"
#import "PPLVoteDetailViewController.h"
#import "PPLVoteViewController.h"

@interface PPLVoteMainViewController ()

@end
NSString *const kNavigationButtonTitle = @"Info";
NSString *const kSummarySegueId = @"toSummary";
NSUInteger currentIndex = 0;
@implementation PPLVoteMainViewController
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    
    PPLVoteViewController *p1 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"voteController"];
    
    p1.pageController = self;
    
    PPLVoteDetailViewController *p2 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"VoteDetailView"];
    p2.pageController = self;
    
    _myViewControllers = [[NSArray alloc] initWithObjects:p1,p2, nil];
    
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


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *temp = [[NSArray alloc] initWithObjects:self.myViewControllers.firstObject, nil];
    [self setViewControllers:temp direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -mark UIPageViewController datasource

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    return self.myViewControllers[index];
}

//-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
//     viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    currentIndex = [self.myViewControllers indexOfObject:viewController];
//    
//    --currentIndex;
//    currentIndex = currentIndex % (self.myViewControllers.count);
//    return [self.myViewControllers objectAtIndex:currentIndex];
//}
//
//-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
//      viewControllerAfterViewController:(UIViewController *)viewController
//{
//    currentIndex = [self.myViewControllers indexOfObject:viewController];
//    
//    ++currentIndex;
//    
//    
//    currentIndex = currentIndex % (self.myViewControllers.count);
//    return [self.myViewControllers objectAtIndex:currentIndex];
//}
//
//-(NSInteger)presentationCountForPageViewController:
//(UIPageViewController *)pageViewController
//{
//    return self.myViewControllers.count;
//}
//
//-(NSInteger)presentationIndexForPageViewController:
//(UIPageViewController *)pageViewController
//{
//    return currentIndex;
//}
//

#pragma -mark Navigation
- (void)showResult:(id)sender
{
    [self performSegueWithIdentifier:kSummarySegueId sender:nil];
}

- (void)showLaunch:(id)sender
{
    [[PPLUtils sharedInstance] showLaunch:self];
}

@end
