//
//  BuyerdetailViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "BuyerdetailViewController.h"
#import "TopbardealerViewController.h"
#import "Haneke.h"

@interface BuyerdetailViewController ()

@end

@implementation BuyerdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    btnaccept.hidden=NO;
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"left_arrow"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"left_arrow"]];
    self.navigationItem.title = @"NEW LEAD";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    lblcomment.layer.borderWidth=1.0f;
    lblcomment.layer.borderColor=[UIColor grayColor].CGColor;
    [self buyerdetailmethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)acceptBtnPressed:(id)sender{
    btnaccept.hidden=YES;
    [self acceptdetailmethod];
    
}
-(IBAction)declinedBtnPressed:(id)sender{
    [self declineddetailmethod];
    
}


-(void)buyerdetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
     NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.carplansId,@"carplan_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@buyer_detail",kURl];
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
           
            NSMutableDictionary*dict=[[responsedict valueForKey:@"response"]objectAtIndex:0];
            lblname.text=[dict valueForKey:@"first_name"];
            lbllocation.text=[dict valueForKey:@"city"];
            NSString*strnote=[dict valueForKey:@"shopping_notes"];
            lblcomment.text=[NSString stringWithFormat:@" %@",strnote];
            NSString*img=[dict valueForKey:@"profile_picture"];
            NSURL*url=[NSURL URLWithString:img];
            
            if ([img isEqualToString:@""]) {
               imgbuyer.image = [UIImage imageNamed:@"no-image"];
            }
            else{
                imgbuyer.clipsToBounds=YES;
                [imgbuyer setContentMode:UIViewContentModeScaleAspectFill];
                [imgbuyer hnk_setImageFromURL:url];
           
            }
           
            NSLog(@"%@",detailarray);
            [[AppManager sharedManager] removeLoadingWindow];
           // [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            
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


-(void)acceptdetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*stats=@"1";
    NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *carID=[[NSUserDefaults standardUserDefaults] objectForKey:@"idcar"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:buyerID,@"buyer_id",userstr,@"dealer_id",stats,@"status", carID ,@"car_id",self.carplansId,@"carplan_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@buyer_request",kURl];
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
            
            NSMutableDictionary*dict=[responsedict valueForKey:@"response"];
            NSLog(@"%@",dict);
            [[AppManager sharedManager] removeLoadingWindow];
            [self performSegueWithIdentifier:@"pushaccept" sender:nil];
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:1.0f];
            
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushaccept"])
    {
        TopbardealerViewController *dest = (TopbardealerViewController *)[segue destinationViewController];
        dest.carplansId =self.carplansId;
        
    }
 
}

-(void)declineddetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString*stats=@"2";
    NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *carID=[[NSUserDefaults standardUserDefaults] objectForKey:@"idcar"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userstr,@"dealer_id",stats,@"status", carID ,@"car_id",self.carplansId,@"carplan_id ", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@buyer_request",kURl];
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
            
            NSMutableDictionary*dict=[responsedict valueForKey:@"response"];
            NSLog(@"%@",dict);
            [[AppManager sharedManager] removeLoadingWindow];
            //[self performSegueWithIdentifier:@"pushaccept" sender:nil];
            [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:1.0f];
            
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
