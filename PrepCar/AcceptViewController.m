//
//  AcceptViewController.m
//  PrepCar
//
//  Created by anil on 24/04/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "AcceptViewController.h"
#import "UIImageView+WebCache.h"
#import "Haneke.h"

@interface AcceptViewController ()

@end

@implementation AcceptViewController
@synthesize dataString;

- (void)viewDidLoad {
    [super viewDidLoad];
    view3.layer.borderWidth=2.0f;
    view3.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view3.layer.cornerRadius=5.0f;
    
    btnaccept.layer.borderWidth=1.0f;
    btnaccept.layer.borderColor=[UIColor lightGrayColor].CGColor;
    btnaccept.layer.cornerRadius=5.0f;
    btnaccept.clipsToBounds =YES;
    
    btnresudel.layer.borderWidth=1.0f;
    btnresudel.layer.borderColor=[UIColor lightGrayColor].CGColor;
    btnresudel.layer.cornerRadius=5.0f;
    btnresudel.clipsToBounds =YES;
   
    
    view1.hidden=YES;
    view2.hidden=YES;
    
    NSMutableArray*arrydetail=[[NSUserDefaults standardUserDefaults] objectForKey:@"cardetail"];
    dealstr=[arrydetail valueForKey:@"deal_id"];
    
    NSString*strname=[arrydetail valueForKey:@"make"];
    
    NSString*strvicle=[arrydetail valueForKey:@"model_year"];
    
    NSString*stryear=[arrydetail valueForKey:@"model_type"];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: strvicle, strname,stryear, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    lblcar.text=[NSString stringWithFormat:@"%@",trimmedString];
    lblname.text=[arrydetail valueForKey:@"buyer_name"];
    lbldate.text=[arrydetail valueForKey:@"date"];
    lbltime.text=[arrydetail valueForKey:@"time"];
    strappintment=[[arrydetail valueForKey:@"appointment_status"]stringValue];
    strconfirm=[[arrydetail valueForKey:@"confirm_status"]stringValue];
    
    if ([strappintment isEqualToString:@"1"]) {
        [btnsold setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
        if ([strconfirm isEqualToString:@"0"]) {
            view1.hidden=NO;
            
        }
        if ([strconfirm isEqualToString:@"1"]){
            view2.hidden=NO;
        }
        if ([strconfirm isEqualToString:@"2"]){
            view1.hidden=NO;
            
        }
    }
     if ([strappintment isEqualToString:@"2"]){
        [btnpending setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
         if ([strconfirm isEqualToString:@"0"]) {
             view1.hidden=NO;
             
         }
         if ([strconfirm isEqualToString:@"1"]){
             view2.hidden=NO;
         }
         if ([strconfirm isEqualToString:@"2"]){
             view1.hidden=NO;
             
         }
    }
    if([strappintment isEqualToString:@"3"]){
       [btnlost setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
        if ([strconfirm isEqualToString:@"0"]) {
            view1.hidden=NO;
            
        }
        if ([strconfirm isEqualToString:@"1"]){
            view2.hidden=NO;
        }
        if ([strconfirm isEqualToString:@"2"]){
            view1.hidden=NO;
            
        }

    }
    

    NSString*strimage=[arrydetail valueForKey:@"single_car_pic"];
    //NSURL*url=[NSURL URLWithString:strimage];
    if ([strimage isEqualToString:@""]) {
        imgcar.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [imgcar sd_setImageWithURL:[NSURL URLWithString:strimage]
                         placeholderImage:[UIImage imageNamed:@""]
                                  options:SDWebImageRefreshCached];
    });
    }

   
 }


-(IBAction)cardetailmethod:(UIButton*)sender;

{
    if(sender.tag==1001)
    {
        [btnsold setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
        [btnpending setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [btnlost setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [self carsoldtmethod];
        
    }
    if (sender.tag==1002)
    {
        [btnsold setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [btnpending setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
        [btnlost setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [self cardetailpandingmethod];
        
        
    }
    if (sender.tag==1003)
    {
        [btnsold setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [btnpending setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
        [btnlost setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
         [self carlostmethod];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)acceptmethod:(id)sender{
    [self acceptlistmethod];
}

-(IBAction)reshudelemethod:(id)sender{
    [self reshudlelistmethod];
}

-(void)acceptlistmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    NSString*strstatus=@"1";
    NSString *testid=[[NSUserDefaults standardUserDefaults] objectForKey:@"testdrive"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:testid,@"testdrive_id",strstatus,@"status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@testdrive_request",kURl];
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
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
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


-(void)reshudlelistmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstatus=@"2";
    NSString *testid=[[NSUserDefaults standardUserDefaults] objectForKey:@"testdrive"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:testid,@"testdrive_id",strstatus,@"status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@testdrive_request",kURl];
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
    
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
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

-(void)carsoldtmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstatus=@"1";
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dealstr,@"deal_id",strstatus,@"appointment_status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@appointment_status",kURl];
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
            
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
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


-(void)cardetailpandingmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstatus=@"2";
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dealstr,@"deal_id",strstatus,@"appointment_status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@appointment_status",kURl];
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
            
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
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


-(void)carlostmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*strstatus=@"3";
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dealstr,@"deal_id",strstatus,@"appointment_status", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@appointment_status",kURl];
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
            
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
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
