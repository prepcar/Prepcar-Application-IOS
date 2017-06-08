//
//  LoginViewController.m
//  PrepCar
//
//  Created by Devendra on 12/20/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface LoginViewController ()
{
     NSString *strMessage,*str_USERID,*FB_id,*FB_ProfileURL,*Name,*emailaddress;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:YES];
    self.navigationItem.hidesBackButton=YES;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController]
     setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)FacebookLoginBtnAction:(id)sender
{
    // CheckType=2;
    [FBSession.activeSession closeAndClearTokenInformation];
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        
    } else {
        
        [self FBLogin ];
        
    }
    
    /// [self LoginServiceFunction];
}
- (void)FBLogin {
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info",@"user_photos",@"email",@"user_birthday",@"user_hometown",@"user_about_me"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         
         // Retrieve the app delegate
         AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
         // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
         [appDelegate sessionStateChanged:session state:state error:error];
         if (FBSession.activeSession.state == FBSessionStateOpen
             || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
             [self FaceBookRequest];
         }
         else{
             
         }
         
     }];
}
-(void)FaceBookRequest
{
    
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 
                 //NSLog(@"%@",user.email);
                 
                 [self SetUserValue:user];
             }
             else
             {
                 
                 NSLog(@"Fb request error in FaceBookRequest method : %@",error);
             }
         }];
    }
    else
    {
        
        NSLog(@"Fb session close on logout in FacebookRequest Method");
    }
}
-(void)SetUserValue:(NSDictionary<FBGraphUser> *)user
{
    NSLog(@"user FB data :: %@",user);
    NSString *tocken=[[FBSession activeSession] accessToken] ;
    NSLog(@"tocken %@",tocken);
    NSString* Userprofilepicture=@"https://graph.facebook.com/me/?access_token=%@&fields=picture";
    NSString *UserprofilepictureUrlStr=[NSString stringWithFormat:Userprofilepicture,tocken];
    [self retreiveUserLoginData:UserprofilepictureUrlStr];
}
-(void)retreiveUserLoginData:(NSString *)passURL
{
    dispatch_async( kBgQueue, ^{
        NSURL *url=[NSURL URLWithString:[passURL  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Retreive url FB : %@",url);
        NSData *data=[NSData dataWithContentsOfURL:url];
        if (data!=NULL)
        {
            [self performSelectorOnMainThread:@selector(fetchcallUserprofilepicture:)
                                   withObject:data waitUntilDone:YES];
        }
        else
        {
            
        }
    });
}
- (void)fetchcallUserprofilepicture:(NSData *)responseData
{
    NSError* error;
    NSDictionary* jsonProfile = [NSJSONSerialization
                                 JSONObjectWithData:responseData
                                 options:kNilOptions
                                 error:&error];
    
    NSLog(@"json FB User Profile :: %@",jsonProfile);
    [FBRequestConnection startWithGraphPath:@"me?fields=id,name,first_name,gender,last_name,email,picture.type(large)"
                          completionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                              if (!error)
                              {
                                  Name = [user objectForKey:@"first_name"];
                                  FB_id  = [user objectForKey:@"id"];
                                  FB_ProfileURL = [[[user valueForKey:@"picture" ]valueForKey:@"data"] valueForKey:@"url"];
                                  
                                  [self FBLoginAction];
                              }
                              else
                              {
                                  
                              }
                          }];
}

-(void)FBLoginAction{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:appDelegate.RollID,@"role_id",Name,@"name",FB_id,@"fb_id",FB_ProfileURL,@"imageURL",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@fblogin",kURl];
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
            NSMutableDictionary *arrayDetail=[responseArray valueForKey:@"response"];
            NSLog(@"%@",arrayDetail);
            str_USERID   = [arrayDetail valueForKey:@"userId"];
            appDelegate.str_USERID =str_USERID;
            strMessage= [responseArray objectForKey:@"message"];
            [KSToastView ks_showToast:strMessage duration:0.5f];
            [[AppManager sharedManager] removeLoadingWindow];
            [self performSegueWithIdentifier:@"FbLogin" sender:nil];
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CouponDiscriptionViewController"])
        [KSToastView ks_showToast:strMessage duration:0.5f];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_BuyerLoginAction:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.RollID =@"4";
    
    [self performSegueWithIdentifier:@"LoginScreen" sender:nil];
}

- (IBAction)btn_dealerLoginAction:(id)sender
{
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.RollID =@"3";
    [self performSegueWithIdentifier:@"LoginScreen" sender:nil];

}


@end
