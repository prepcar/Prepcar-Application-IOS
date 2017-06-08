//
//  FavoriteViewController.m
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "FavoriteViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];

}
-(void)viewWillAppear:(BOOL)animated{
     [self delerfavirotemethod];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return favarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FavCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UILabel* label = (UILabel *)[cell viewWithTag:2];
    NSString*strmake= [[favarray objectAtIndex:indexPath.row]valueForKey:@"make"];
    if ([strmake isEqualToString:@""]) {
        label.text=@"N/A";
    }
    else{
    label.text=[NSString stringWithFormat:@"%@",strmake];
    }
  
    UILabel *label1 = (UILabel *)[cell viewWithTag:3];
    NSString*strcity=[[favarray objectAtIndex:indexPath.row]valueForKey:@"city"];
    if ([strcity isEqualToString:@""]) {
        label1.text=@"N/A";
    }
    else{
    label1.text=[NSString stringWithFormat:@"%@",strcity];
    }
    
    UILabel *label2 = (UILabel *)[cell viewWithTag:4];
    NSString*strmodel=[[favarray objectAtIndex:indexPath.row]valueForKey:@"model_year"];
    if ([strmodel isEqualToString:@""]) {
        label2.text=@"N/A";
    }
    else{
    label2.text=[NSString stringWithFormat:@"%@",strmodel];
    }
    
    UILabel *label3 = (UILabel *)[cell viewWithTag:5];
    NSString*strdate=[[favarray objectAtIndex:indexPath.row]valueForKey:@"date"];
    if ([strdate isEqualToString:@""]) {
        label3.text=@"N/A";
    }
    else{
    label3.text=[NSString stringWithFormat:@"%@",strdate];
    }
    
    UILabel *label4 = (UILabel *)[cell viewWithTag:6];
    NSString*strprice=[[favarray objectAtIndex:indexPath.row]valueForKey:@"price"];
    if ([strprice isEqualToString:@""]) {
        label4.text=@"N/A";
    }
    else{
        label4.text=[NSString stringWithFormat:@"$%@",strprice];
    }
    
    
    UIImageView *img =(UIImageView *)[cell viewWithTag:1];
    img.layer.cornerRadius = img.frame.size.width / 2;
    img.layer.borderWidth = 2;
    img.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    img.clipsToBounds = YES;
    NSURL *url_Img1 = [[favarray objectAtIndex:indexPath.row]valueForKey:@"single_car_pic"];
    NSString*imagestr=[NSString stringWithFormat:@"%@",url_Img1];
    if (url_Img1 == nil || [url_Img1 isEqual:[NSNull null]]) {
        
        
    } else {
        [img sd_setImageWithURL:[NSURL URLWithString:imagestr]
               placeholderImage:[UIImage imageNamed:@""]
                        options:SDWebImageRefreshCached];
    }

    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delerfavirotemethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*strbuyerid=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userstr,@"dealer_id",strbuyerid,@"buyer_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@dealer_favorites",kURl];
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
        NSMutableDictionary *responsedict=[responseSting JSONValue];
        NSLog(@"%@",responsedict);
        
        if ([[[responsedict valueForKey:@"status"] description] isEqualToString:@"1"]) {
            
            favarray=[responsedict valueForKey:@"data"];
            [_tblfav reloadData];
            NSLog(@"%@",favarray);
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
            
        }
        else {
            [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
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
