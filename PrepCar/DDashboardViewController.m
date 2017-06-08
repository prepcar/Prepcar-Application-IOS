//
//  DDashboardViewController.m
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "DDashboardViewController.h"
#import "BuyerdetailViewController.h"
#import "TopbardealerViewController.h"
#import "UIImageView+WebCache.h"
#import "Haneke.h"
@interface DDashboardViewController ()
{
    NSMutableArray *ary_Name;
    NSString *selectedcarplansId;
}

@end

@implementation DDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    //_tbl_BuyerList.contentInset = UIEdgeInsetsZero;
    self.tbl_BuyerList.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

     self.automaticallyAdjustsScrollViewInsets = NO;
   
    
    self.navigationItem.title = @"ACTIVE LEADS";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    NSString *countID=[[NSUserDefaults standardUserDefaults] objectForKey:@"count"];
    [[self.tabBarController.tabBar.items objectAtIndex:3] setBadgeValue:countID];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
 
    [self buyerlistmethod];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return ary_Name.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"dealerCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = (UILabel *)[cell viewWithTag:22];
    //label.text= [[ary_Name objectAtIndex:indexPath.row]valueForKey:@"first_name"];
    
    label.text=[NSString stringWithFormat:@"%@ %@",[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"first_name"],[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"last_name"]];
    UILabel *label1 = (UILabel *)[cell viewWithTag:24];
    label1.text= [NSString stringWithFormat:@"%@ %@",[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"city"],[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"state"] ];
    
    
    UIImageView *imageplan = (UIImageView *)[cell viewWithTag:25];
    strplan=[[ary_Name objectAtIndex:indexPath.row] valueForKey:@"carplan_status"];
     value = [strplan intValue];
    if (value==0) {
        imageplan.image = [UIImage imageNamed:@"new@"];
    }
    else{
       imageplan.image = [UIImage imageNamed:@"accepted@"];
    }
   
    /////////////////////
    
    UIImageView*carimg = (UIImageView *)[cell viewWithTag:23];
    carimg.layer.cornerRadius = carimg.frame.size.width / 2;
    carimg.layer.borderWidth = 1.0f;
    carimg.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    carimg.clipsToBounds = YES;
    NSString*strimage=[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"profile_picture"];
    NSURL*url=[NSURL URLWithString:strimage];
    if ([strimage isEqualToString:@""]) {
        carimg.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        
        [carimg hnk_setImageFromURL:url];
    }
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"])
    {
        BuyerdetailViewController *dest = (BuyerdetailViewController *)[segue destinationViewController];
        dest.carplansId =selectedcarplansId;
        
    }
    if ([segue.identifier isEqualToString:@"activetopbar"])
    {
        TopbardealerViewController *dest = (TopbardealerViewController *)[segue destinationViewController];
        dest.carplansId =selectedcarplansId;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*buyerid=[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"buyer_id"];
    [[NSUserDefaults standardUserDefaults]setObject:buyerid forKey:@"id"];
    NSString*carid=[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"car_id"];
    [[NSUserDefaults standardUserDefaults]setObject:carid forKey:@"idcar"];
    title = [[ary_Name objectAtIndex:indexPath.row]valueForKey:@"carplan_status"];
    value = [title intValue];
    selectedcarplansId =[[ary_Name objectAtIndex:indexPath.row]valueForKey:@"carplan_id"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedcarplansId forKey:@"selectedcar"];
   
    if (value==0) {
       [self performSegueWithIdentifier:@"detail" sender:nil];
        
    }
    else{
       [self performSegueWithIdentifier:@"activetopbar" sender:nil];
    }
}



-(void)buyerlistmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"dealer_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@buyer_list",kURl];
    ASIFormDataRequest*  request101=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:strUrl]];
    NSLog(@"Print WebServiceUrl : %@",strUrl);
    [request101 addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    NSMutableString *body = [NSMutableString string];
    [request101 setRequestMethod:@"Post"];
    
    for (NSString *key in postDictionary) {
        NSString *val = [postDictionary objectForKey:key];
        if ([body length])
            [body appendString:@"&"];
        [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String],
         [[val description] urlEncodedUTF8String]];
    }
    
    [request101 appendPostData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request101 setTimeOutSeconds:6000];
    [request101 setDelegate:self];
    [request101 startAsynchronous];
    [request101 setCompletionBlock:^{
        
        NSString*responseSting=[request101 responseString];
        NSMutableDictionary *responseArray=[responseSting JSONValue];
        NSLog(@"%@",responseArray);
        
        if ([[[responseArray valueForKey:@"status"] description] isEqualToString:@"1"]) {
            int status = [responseArray[@"dataFlow"] intValue];
            NSString *IsStatus = [NSString stringWithFormat:@"%d",status];
            ary_Name =[responseArray valueForKey:@"response"];
            
            if (status==0) {
                    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tbl_BuyerList.bounds.size.width,_tbl_BuyerList.bounds.size.height)];
                    noDataLabel.text = @"You Don't Have Any Active Leads";
                    noDataLabel.textColor = [UIColor lightGrayColor];
                    noDataLabel.textAlignment = NSTextAlignmentCenter;
                    _tbl_BuyerList.backgroundView = noDataLabel;
                     [[AppManager sharedManager] removeLoadingWindow];
                     return ;
                }
            else{
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
            _tbl_BuyerList.backgroundView = nil;
            [_tbl_BuyerList reloadData];
            NSLog(@"%@",ary_Name);
            }
        }
        else {
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
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
