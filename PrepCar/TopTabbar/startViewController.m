//
//  startViewController.m
//  Pranayama
//
//  Created by Manish Kumar on 6/15/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//

#import "startViewController.h"
#import "MainViewController.h"
#import "FavoriateViewController.h"
#import "TabbarViewController.h"

@interface startViewController () <YSLContainerViewControllerDelegate>
@end
@implementation startViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO];
      self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    UIImage *image = [UIImage imageNamed:@"icon_logo@1x"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    
 // SetUp ViewControllers
    UIStoryboard *storyBoard=[[UIStoryboard alloc]init];

        UIStoryboard * Board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        storyBoard=Board;
    
    MainViewController *stepsview = [storyBoard instantiateViewControllerWithIdentifier:@"first"];
    stepsview.title = @"New Matches";
    
    
   FavoriateViewController *benefitview = [storyBoard instantiateViewControllerWithIdentifier:@"second"];
    benefitview.title = @"Favorites";
    
    
    

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


-(void)HomeBtnPressed
{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TabbarViewController class]] ) {
            TabbarViewController *groupViewController = (TabbarViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
        }
    }
}


#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

-(IBAction)backbutton:(id)sender
{
    [[self navigationController] popViewControllerAnimated: YES];
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
