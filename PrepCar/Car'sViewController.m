//
//  Car'sViewController.m
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "Car'sViewController.h"
#import "CarTableViewCell.h"
#import "UploadcarViewController.h"
#import "Haneke.h"
//#import "UIImageView+WebCache.h"

@interface Car_sViewController ()

@end

@implementation Car_sViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    UIImage*newimage=[UIImage imageNamed:@"left_arrow"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:newimage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"CARS";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [self carlist];
    
    
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return arrayDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CarCell";
    
    CarTableViewCell *cell = (CarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    [cell bringSubviewToFront:cell.btn_delete];
    [cell bringSubviewToFront:cell.btn_edit];
    
    [cell.btn_delete addTarget:self action:@selector(alertshow:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_edit addTarget:self action:@selector(editbtnmethod:) forControlEvents:UIControlEventTouchUpInside];
    NSString*strmak= [[arrayDetail objectAtIndex:indexPath.row]valueForKey:@"make"];
    NSString*strmod= [[arrayDetail objectAtIndex:indexPath.row]valueForKey:@"model_type"];
    NSString *combined = [NSString stringWithFormat:@"%@  %@", strmak, strmod];
    cell.lbl_title.text=[NSString stringWithFormat:@"%@",combined];
    /////////////////////
    cell.lbl_year.text =[[arrayDetail objectAtIndex:indexPath.row]valueForKey:@"model_year"];
    
    cell.img_car.layer.cornerRadius = cell.img_car.frame.size.width / 2;
    cell.img_car.layer.borderWidth = 2;
    cell.img_car.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    cell.img_car.clipsToBounds = YES;
    NSString *url1=[[arrayDetail objectAtIndex:indexPath.row]valueForKey:@"single_car_pic"];
    NSURL*url=[NSURL URLWithString:url1];
    [cell.img_car hnk_setImageFromURL:url];
    return cell;
}

-(void)editbtnmethod:(UIButton*)sender{
    CGPoint buttonPosition=[sender convertPoint:CGPointZero toView:self.cartbl];
    _strunique=@"past";
    myindexpath =[self.cartbl indexPathForRowAtPoint:buttonPosition];
    NSString *car=[carid objectAtIndex:myindexpath.row];
    [[NSUserDefaults standardUserDefaults]setObject:car forKey:@"carsave"];
     [self performSegueWithIdentifier:@"editcar" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)carlist{
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
    NSString *strUrl=[NSString stringWithFormat:@"%@car_list",kURl];
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
        NSDictionary *dict_response=[responseSting JSONValue];
        NSLog(@"%@",dict_response);
        
        if ([[[dict_response valueForKey:@"status"] description] isEqualToString:@"1"]) {
            int status = [dict_response[@"dataFlow"] intValue];
            NSString *IsStatus = [NSString stringWithFormat:@"%d",status];
            arrayDetail=[dict_response objectForKey:@"response"];
            if (status==0) {
                [KSToastView ks_showToast:[dict_response objectForKey:@"message"] duration:2.0f];
                [[AppManager sharedManager] removeLoadingWindow];
                return ;
            }
            NSLog(@"%@",arrayDetail);
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
                carid=[arrayDetail valueForKey:@"car_id"];
                [_cartbl reloadData];
            
            }
        else {
            //[KSToastView ks_showToast:[dict_response objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}

-(IBAction)addnewlist:(id)sender{
    _strunique=@"new";
   [self performSegueWithIdentifier:@"editcar" sender:nil];
}

-(void)alertshow:(UIButton*)sender{
    CGPoint buttonPosition=[sender convertPoint:CGPointZero toView:self.cartbl];
    selectedindexPath =[self.cartbl indexPathForRowAtPoint:buttonPosition];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Car List"
                                                    message:@"Do you want to delete this car"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:@"Cancel",nil];
    alert.tag=1000;
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (alertView.tag==1000) {
        if (buttonIndex == 0) {
            [self deletecarlist];
        }
    }
}

-(void)deletecarlist{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *car=[carid objectAtIndex:selectedindexPath.row];

    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:car,@"car_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@car_delete",kURl];
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
            NSMutableDictionary *array=[responseArray valueForKey:@"response"];
            NSLog(@"%@",array);
            [arrayDetail removeObjectAtIndex:selectedindexPath.row];
            [self.cartbl reloadData];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editcar"]) {
        UploadcarViewController *container = (UploadcarViewController *)[segue destinationViewController];
        container.strpast = _strunique;
        
    }

}


@end
