//
//  TopbarprofileViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "TopbarprofileViewController.h"
#import "ChangeViewController.h"
#import "ProfiledealerViewController.h"
#import "Car'sViewController.h"

@interface TopbarprofileViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation TopbarprofileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage*newimage=[UIImage imageNamed:@"left_arrow"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:newimage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    //self.navigationItem.hidesBackButton=YES;

    UIStoryboard *storyBoard=[[UIStoryboard alloc]init];
    
    UIStoryboard * Board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    storyBoard=Board;
    
    
    Car_sViewController *precautionsview = [storyBoard instantiateViewControllerWithIdentifier:@"carview"];
    precautionsview.title = @"Cars";

    
    ProfiledealerViewController *benefitview = [storyBoard instantiateViewControllerWithIdentifier:@"pro"];
    benefitview.title = @"Profile";
    
       ChangeViewController *stepsview = [storyBoard instantiateViewControllerWithIdentifier:@"chan"];
    stepsview.title = @"Password";
    
    
    
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.containerVC1 = [[YSLContainerViewController alloc]initWithControllers:@[precautionsview,benefitview,stepsview]
                                                                  topBarHeight:statusHeight + navigationHeight
                                                          parentViewController:self];
    self. containerVC1.delegate = self;
    self .containerVC1.menuItemFont = [UIFont fontWithName:@"MyriadPro-Regular" size:16];
    
    [self.view addSubview:self.containerVC1.view];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
