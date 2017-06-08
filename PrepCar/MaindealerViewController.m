//
//  MaindealerViewController.m
//  PrepCar
//
//  Created by anil on 28/02/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "MaindealerViewController.h"

@interface MaindealerViewController ()

@end

@implementation MaindealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated{
     [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:NO];
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

@end
