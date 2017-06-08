//
//  TopbarchangeViewController.m
//  PrepCar
//
//  Created by anil on 17/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "TopbarchangeViewController.h"
#import "ProfileViewController.h"
#import "ChangePasswordViewController.h"

@interface TopbarchangeViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation TopbarchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"left_arrow"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"left_arrow"]];
    
    // SetUp ViewControllers
    UIStoryboard *storyBoard=[[UIStoryboard alloc]init];
    
    UIStoryboard * Board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    storyBoard=Board;
    
   ProfileViewController *stepsview = [storyBoard instantiateViewControllerWithIdentifier:@"PROFILE"];
    stepsview.title = @"Profile";
    
    
    ChangePasswordViewController *benefitview = [storyBoard instantiateViewControllerWithIdentifier:@"CHANGE"];
    benefitview.title = @"Password";
    
//    FeedViewController *precautionsview = [storyBoard instantiateViewControllerWithIdentifier:@"third"];
//    precautionsview.title = @"Feed";
    
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.containerVC = [[YSLContainerViewController alloc]initWithControllers:@[stepsview,benefitview]
                                                                 topBarHeight:statusHeight + navigationHeight
                                                         parentViewController:self];
    self. containerVC.delegate = self;
    self .containerVC.menuItemFont = [UIFont fontWithName:@"MyriadPro-Regular" size:16];
    
    [self.view addSubview:self.containerVC.view];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
