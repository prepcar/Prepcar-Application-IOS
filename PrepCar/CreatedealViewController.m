//
//  CreatedealViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "CreatedealViewController.h"
#import "NYAlertViewController.h"
#import "TabViewController.h"
#import "UIImageView+WebCache.h"
#import "Haneke.h"


@interface CreatedealViewController ()

@end

@implementation CreatedealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"CREATE DEAL";
    UIImage*newimage=[UIImage imageNamed:@"left_arrow"];
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:newimage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self cardetailmethod];
    });

    
}
-(void)HomeBtnPressed
{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TabViewController class]] ) {
           TabViewController *groupViewController = (TabViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
        }
    }

}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendmatchesbtn:(id)sender{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"THANKS", nil);
    alertViewController.message = NSLocalizedString(strtitle, nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"Helvetica-Bold" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"Helvetica-Bold" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = RGB(0, 17, 111);
    alertViewController.messageColor =[UIColor blackColor];
    
    alertViewController.buttonColor = RGB(0, 17, 111);
    alertViewController.buttonTitleColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    alertViewController.cancelButtonColor = RGB(0, 17, 111);
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"MAIN MENU", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
        
          
    [alertViewController dismissViewControllerAnimated:YES completion:nil];
     [self sendmatchesmethod ];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
    if ([viewController isKindOfClass:[TabViewController class]] ) {
    TabViewController *groupViewController = (TabViewController*)viewController;
    [self.navigationController popToViewController:groupViewController animated:YES];
                                                                  }
                                                              }

                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"SEND ANOTHER DEAL", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
    [alertViewController dismissViewControllerAnimated:YES completion:nil];
    [self sendmatchesmethod ];
    [self performSegueWithIdentifier:@"PUSHSELECT" sender:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    _detailscroll.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+50);
}


-(void)cardetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *dealID=[[NSUserDefaults standardUserDefaults] objectForKey:@"deal"];
    NSString*userstr=[NSString stringWithFormat:@"%@",dealID];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userstr,@"deal_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@deal_detail",kURl];
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
        int status = [responsedict[@"dataFlow"] intValue];
        NSString *IsStatus = [NSString stringWithFormat:@"%d",status];
        if ([[[responsedict valueForKey:@"status"] description] isEqualToString:@"1"]) {
            if (status==0) {
                [[AppManager sharedManager] removeLoadingWindow];
                return;
            }
            NSMutableDictionary*discoverydict=[responsedict valueForKey:@"response"];
            NSString*strname=[[discoverydict valueForKey:@"make"]objectAtIndex:0];
            
            NSString*strvicle=[[discoverydict valueForKey:@"model_year"]objectAtIndex:0];
            
            NSString*stryear=[[discoverydict valueForKey:@"model_type"]objectAtIndex:0];
            NSArray *myStrings = [[NSArray alloc] initWithObjects: strvicle, strname,stryear, nil];
            NSString *joinedString = [myStrings componentsJoinedByString:@" "];
            NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
            lblvichel.text=[NSString stringWithFormat:@"%@",trimmedString];
            /////////
            lblname.text=[NSString stringWithFormat:@"%@",strname];
            
            
            discriptionstr=[[discoverydict valueForKey:@"description"]objectAtIndex:0];
            if ([discriptionstr isEqualToString:@""]) {
                lbldiscription.text=@"N/A";
            }
            else{
                lbldiscription.text=[NSString stringWithFormat:@"%@",discriptionstr];
                
                if ([lbldiscription.text length]<40) {
                    btnmore.hidden=YES;
                }
                else{
                    btnmore.hidden=NO;
                }
            }
            NSString*pricestr=[[discoverydict valueForKey:@"price"]objectAtIndex:0];
            if ([pricestr isEqualToString:@""]) {
                lblprice.text=@"N/A";
            }
            else{
            lblprice.text=[NSString stringWithFormat:@"%@",pricestr];
            }
            
            NSString*dealstr=[[discoverydict valueForKey:@"lease_deal_trems"]objectAtIndex:0];
            if ([dealstr isEqualToString:@""]) {
                deal.text=@"N/A";
            }
            else{
            deal.text=[NSString stringWithFormat:@"%@",dealstr];
            }
            
            NSString*strdislimer=[[discoverydict valueForKey:@"lease_deal_disclaimer"]objectAtIndex:0];
            if ([strdislimer isEqualToString:@""]) {
                dislimaer.text=@"N/A";
            }
            else{
            dislimaer.text=[NSString stringWithFormat:@"%@",strdislimer];
            }
            
            NSString*ImageURL=[[discoverydict valueForKey:@"single_car_pic"]objectAtIndex:0];
            NSURL*url=[NSURL URLWithString:ImageURL];
            if ([ImageURL isEqualToString:@""]) {
               imagecar.image = [UIImage imageNamed:@"no-image"];;
            }
            else{
                
                [imagecar hnk_setImageFromURL:url];
            }
            
            NSString*monthstr=[[discoverydict valueForKey:@"months"]objectAtIndex:0];
            if ([monthstr isEqualToString:@""]) {
                lblmonth.text=@"N/A";
            }
            else{
            lblmonth.text=[NSString stringWithFormat:@"%@",monthstr];
            }
            
            NSString*intreststr=[[discoverydict valueForKey:@"interest_rate"]objectAtIndex:0];
            if ([intreststr isEqualToString:@""]) {
                lblintrest.text=@"N/A";
            }
            else{
            lblintrest.text=[NSString stringWithFormat:@"%@%%",intreststr];
            }
            
            NSString*strdis=[[discoverydict valueForKey:@"buyername"]objectAtIndex:0];
            NSString*strnew=@"Your deal was successfully sent to ";
            strtitle=[NSString stringWithFormat:@"%@%@",strnew,strdis];
            
            NSString*salesstr=[[discoverydict valueForKey:@"nickname"]objectAtIndex:0];
            if ([salesstr isEqualToString:@""]) {
                lblsales.text=@"N/A";
            }
            else{
            lblsales.text=[NSString stringWithFormat:@"%@",salesstr];
            }
            
            NSString*downstr=[[discoverydict valueForKey:@"down_payment"]objectAtIndex:0];
            if ([downstr isEqualToString:@""]) {
                lbldown.text=@"N/A";
            }
            else{
            lbldown.text=[NSString stringWithFormat:@"%@",downstr];
            }
            
            NSString*tradestr=[[discoverydict valueForKey:@"trade_in_value"]objectAtIndex:0];
            if ([tradestr isEqualToString:@""]) {
                lbltrade.text=@"N/A";
            }
            else{
            lbltrade.text=[NSString stringWithFormat:@"%@",tradestr];
            }
            
            NSString*amountstr=[[discoverydict valueForKey:@"monthly_payment"]objectAtIndex:0];
            if ([amountstr isEqualToString:@""]) {
                lblamount.text=@"N/A";
            }
            else{
            lblamount.text=[NSString stringWithFormat:@"%@",amountstr];
            }

            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
               // [self performSegueWithIdentifier:@"pushtopbar" sender:nil];
            });
        }
        else {
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


-(IBAction)showpopup:(id)sender{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    [alert showNotice:self title:@"DISCRIPTION" subTitle:discriptionstr closeButtonTitle:@"OK"  duration:0.0f];
}



-(void)sendmatchesmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
     NSString *dealID=[[NSUserDefaults standardUserDefaults] objectForKey:@"deal"];
    NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *carplan=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedcar"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userstr,@"dealer_id",buyerID,@"buyer_id",dealID,@"deal_id",carplan,@"carplan_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@send",kURl];
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
            
            NSMutableDictionary*discoverydict=[responsedict valueForKey:@"response"];
            [[AppManager sharedManager] removeLoadingWindow];
            
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:1.0f];
            
        }
        else {
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
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
