//
//  SentViewController.m
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "SentViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SentViewController ()

@end

@implementation SentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    arrayimg=[[NSMutableArray alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self senddetailmethod];
}

-(void)senddetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*strdetail=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedcar"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:userstr,@"dealer_id",strdetail,@"carplan_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@sent",kURl];
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
            arraysend=[responsedict valueForKey:@"data"];
            [_Table_view reloadData];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
                //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            });
            
            
        }
        else {
           // [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return arraysend.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SentCell";
    
    UITableViewCell*cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UIButton* btnexpired = (UIButton *)[cell viewWithTag:380];
    //[btnexpired setBackgroundImage:[UIImage imageNamed:@"box"] forState:UIControlStateNormal];
    [btnexpired addTarget:self action:@selector(expiredBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* lblexpired = (UILabel *)[cell viewWithTag:2000];
    lblexpired.text=@"Available";
    lblexpired.layer.borderWidth=1.0;
    lblexpired.layer.cornerRadius=2.0;
    lblexpired.layer.backgroundColor=[UIColor lightGrayColor].CGColor;
    lblexpired.layer.masksToBounds=YES;
    
    UILabel* label = (UILabel *)[cell viewWithTag:333];
    NSString*strname=[[arraysend objectAtIndex:indexPath.row]valueForKey:@"first_name"];
    label.text=[NSString stringWithFormat:@"%@",strname];
    /////////////////////
    UILabel *label1 = (UILabel *)[cell viewWithTag:334];
    NSString*strmake=[[arraysend objectAtIndex:indexPath.row]valueForKey:@"make"];
    
    NSString*stryear=[[arraysend objectAtIndex:indexPath.row]valueForKey:@"model_year"];
    
    NSString*strmodel=[[arraysend objectAtIndex:indexPath.row]valueForKey:@"model_type"];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: stryear,strmake,strmodel, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    label1.text=[NSString stringWithFormat:@"%@",trimmedString];
    ///////////////////
    UILabel *label2 = (UILabel *)[cell viewWithTag:335];
    NSString*strnickname=[[arraysend objectAtIndex:indexPath.row]valueForKey:@"nickname"];
    if ([strnickname isEqualToString:@""]) {
        label2.text=@"N/A";
    }
    else{
    label2.text=[NSString stringWithFormat:@"%@",strnickname];
    }
    //////////////
    UILabel *label3 = (UILabel *)[cell viewWithTag:336];
    NSString*strmonthly=[[arraysend objectAtIndex:indexPath.row ]valueForKey:@"monthly_payment"];
    if ([strmonthly isEqualToString:@""]) {
        label3.text=@"N/A";
    }
    else{
    label3.text=[NSString stringWithFormat:@"$%@",strmonthly];
    }
    ///////////////////
    UILabel *label4 = (UILabel *)[cell viewWithTag:337];
    NSString*strprice=[[arraysend objectAtIndex:indexPath.row ]valueForKey:@"price"];
    if ([strprice isEqualToString:@""]) {
        label4.text=@"N/A";
    }
    else{
    label4.text=[NSString stringWithFormat:@"$%@",strprice];
    }
    //////////////////
    UILabel *label5 = (UILabel *)[cell viewWithTag:338];
    NSString*strcol=[[arraysend objectAtIndex:indexPath.row ]valueForKey:@"description"];
    if ([strcol isEqualToString:@""]) {
        label5.text=@"N/A";
    }
    else{
    label5.text=[NSString stringWithFormat:@"%@",strcol];
    }
    
    
    NSString*strdeal=[[[arraysend objectAtIndex:indexPath.row ]valueForKey:@"deal_expire"]stringValue];
    if ([strdeal isEqualToString:@"0"]) {
          UIImage *btnImage1 = [UIImage imageNamed:@"box"];
         [btnexpired setBackgroundImage:btnImage1 forState:UIControlStateNormal];
        lblexpired.text=@"Available";
        
    }
    
    else{
        UIImage *btnImage1 = [UIImage imageNamed:@"box fill"];
        [btnexpired setBackgroundImage:btnImage1 forState:UIControlStateNormal];
        lblexpired.text=@"Sold";
       
        
    }
    
    
    ////////////////////
    UIImageView *img =(UIImageView *)[cell viewWithTag:111];
    img.layer.cornerRadius = img.frame.size.width / 2;
    img.layer.borderWidth = 2;
    img.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    img.clipsToBounds = YES;
    NSURL *url_Img2 = [[arraysend objectAtIndex:indexPath.row]valueForKey:@"profile_picture"];
    NSString*imagestr1=[NSString stringWithFormat:@"%@",url_Img2];
    if (url_Img2 == nil || [url_Img2 isEqual:[NSNull null]]) {
        
        
    } else {
        [img sd_setImageWithURL:[NSURL URLWithString:imagestr1]
                  placeholderImage:[UIImage imageNamed:@""]];
    }

        ///////////
    UIImageView *imgcar =(UIImageView *)[cell viewWithTag:112];
    NSURL *url_Img1 = [[arraysend objectAtIndex:indexPath.row]valueForKey:@"single_car_pic"];
    NSString*imagestr=[NSString stringWithFormat:@"%@",url_Img1];
    if (url_Img1 == nil || [url_Img1 isEqual:[NSNull null]]) {
        
        
    } else {
        
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [imgcar sd_setImageWithURL:[NSURL URLWithString:imagestr]
                     placeholderImage:[UIImage imageNamed:@""]
                              options:SDWebImageRefreshCached];
            });
    }

    return cell;
}


-(void)expiredBtnPressed:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.Table_view];
    selectedindexPath = [self.Table_view indexPathForRowAtPoint:buttonPosition];
    UITableViewCell *Cell = [self.Table_view cellForRowAtIndexPath:selectedindexPath];
    detailstr=[[arraysend objectAtIndex:selectedindexPath.row]valueForKey:@"deal_id"];
    UIButton* btnexpired = (UIButton *)[Cell viewWithTag:380];
    UILabel* lblexpired = (UILabel *)[Cell viewWithTag:2000];
    if ([[btnexpired backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"box"]])
    {
        [btnexpired setBackgroundImage:[UIImage imageNamed:@"box fill"] forState:UIControlStateNormal];
        lblexpired.text=@"Sold";
        [ self Expiredsendmethod ];
    }
    else
    {
        [btnexpired setBackgroundImage:[UIImage imageNamed:@"box"] forState:UIControlStateNormal];
         lblexpired.text=@"Available";
         [self Expiredsenddetailmethod];
    }
   

}

-(void)Expiredsenddetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstauts=@"0";
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:detailstr,@"deal_id",strstauts,@"status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@deal_expire",kURl];
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
                [[AppManager sharedManager] removeLoadingWindow];
                [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
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



-(void)Expiredsendmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstauts=@"1";
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:detailstr,@"deal_id",strstauts,@"status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@deal_expire",kURl];
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
            [[AppManager sharedManager] removeLoadingWindow];
            [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
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
