//
//  BDashboardViewController.m
//  PrepCar
//
//  Created by Devendra on 12/23/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "BDashboardViewController.h"
#import "BDashboardTableViewCell.h"
#import "ProfileViewController.h"

@interface BDashboardViewController ()
{
    NSMutableArray *ary_Name;
    NSMutableArray *ary_images;
    NSMutableArray *ary_Disc;
    NSMutableArray *ary_BGColor;
}

@end

@implementation BDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:YES
     animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ary_Name =[[NSMutableArray alloc]initWithObjects:@"DISCOVERY",@"FINANCE",@"CURRENT CAR",@"NEW CAR", nil];
    
    ary_images =[[NSMutableArray alloc]initWithObjects:@"discovery.png",@"finances.png",@"current_car.png",@"new_car.png", nil];
    ary_Disc =[[NSMutableArray alloc]initWithObjects:@"What kind of driver are you?",@"How much are you trying to spend?",@"Do you have a trade-in?",@"Describe your next car", nil];
    ary_BGColor =[[NSMutableArray alloc]initWithObjects:@"discovery_bg.png",@"finances_bg.png",@"current_car_bg.png",@"new_car_bg.png", nil];
     NSString *countID=[[NSUserDefaults standardUserDefaults] objectForKey:@"count"];
    [[self.tabBarController.tabBar.items objectAtIndex:3] setBadgeValue:countID];
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:YES
     animated:NO];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [ary_Name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CarPlan";
    
    BDashboardTableViewCell *cell = (BDashboardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        //        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BuyerList" owner:self options:nil];
        //        cell = [nib objectAtIndex:0];
    }
    cell.lbl_disc.text = [ary_Disc objectAtIndex:indexPath.row];
    //   cell.img_Buyer.image = [UIImage imageNamed:[ary_Name objectAtIndex:indexPath.row]];
    cell.lbl_Name.text = [ary_Name objectAtIndex:indexPath.row];
    cell.img_BGColor.image = [UIImage imageNamed:[ary_BGColor objectAtIndex:indexPath.row]];
    cell.img_Icon.image = [UIImage imageNamed:[ary_images objectAtIndex:indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (indexPath.row ==0)
    {
        [self performSegueWithIdentifier:@"Discovery" sender:nil];
    }else if (indexPath.row ==1)
    {
        [self performSegueWithIdentifier:@"FinanceID" sender:nil];
    }else if (indexPath.row ==2)
    {
        [self performSegueWithIdentifier:@"CurrentID" sender:nil];
    }else if (indexPath.row ==3)
    {
        [self performSegueWithIdentifier:@"NewCarID" sender:nil];
    }
        



}
@end
