//
//  TopbardealerViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "TopbardealerViewController.h"
#import "CarplanViewController.h"
#import "SentViewController.h"
#import "FavoriteViewController.h"
#import "ActivityViewController.h"

@interface TopbardealerViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation TopbardealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"icon_logo@1x"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    UIStoryboard *storyBoard=[[UIStoryboard alloc]init];
    
    UIStoryboard * Board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    storyBoard=Board;
    
    CarplanViewController *stepsview = [storyBoard instantiateViewControllerWithIdentifier:@"car"];
    stepsview.carplanId=self.carplansId;
    stepsview.title = @"CarPlan";
    
    
    SentViewController *benefitview = [storyBoard instantiateViewControllerWithIdentifier:@"sen"];
    benefitview.title = @"Sent";
    
    FavoriteViewController *precautionsview = [storyBoard instantiateViewControllerWithIdentifier:@"fav"];
    precautionsview.title = @"Favorites";
    
    ActivityViewController *activityview = [storyBoard instantiateViewControllerWithIdentifier:@"act"];
    activityview.title = @"Activity";
    
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.containerVC1 = [[YSLContainerViewController alloc]initWithControllers:@[stepsview,benefitview,precautionsview,activityview]
                                                                 topBarHeight:statusHeight + navigationHeight
                                                         parentViewController:self];
    self. containerVC1.delegate = self;
    self .containerVC1.menuItemFont = [UIFont fontWithName:@"MyriadPro-Regular" size:16];
    
    [self.view addSubview:self.containerVC1.view];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(IBAction)backbutton:(id)sender
{
    [[self navigationController] popViewControllerAnimated: YES];
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
