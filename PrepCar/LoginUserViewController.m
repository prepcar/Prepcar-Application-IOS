//
//  LoginUserViewController.m
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "LoginUserViewController.h"
@interface LoginUserViewController ()
{
    NSString *strMessage,*str_USERID,*rollid;
}
@end

@implementation LoginUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[self navigationController]
     setNavigationBarHidden:NO];

    [_txt_Email setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_Password setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    UIColor *emailcolor = [UIColor whiteColor];
    _txt_Email.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Email address"
     attributes:@{NSForegroundColorAttributeName:emailcolor}];
    
    UIColor *Passwordcolor = [UIColor whiteColor];
    _txt_Password.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:Passwordcolor}];

    
    [[AppManager sharedManager] changeTextFieldDesign:_txt_Email Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_Password Image:[UIImage imageNamed:@"user-password"]];
    
     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.RollID isEqualToString:@"3"]) {
        self.txt_screenTitle.text =@"DEALER LOGIN";
        [self.btnsignup setTitle: @"Start matching people with cars!" forState: UIControlStateNormal];
    }
    else
    {
        self.txt_screenTitle.text =@"BUYER LOGIN";
         [self.btnsignup setTitle: @"Let's find you a nice car!" forState: UIControlStateNormal];

    }

    // Do any additional setup after loading the view.
    
    //[self Space:_txt_Password];
   // [self Space:_txt_Email];
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(BOOL)checkValidation{
    if (_txt_Email.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Email id"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    if (_txt_Password.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    
    if (![[AppManager sharedManager] validateEmailWithString:_txt_Email.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter valid email id"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    
    return YES;
}

-(void)LoginMethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     NSString *tokenid=[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenname"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:_txt_Email.text,@"email",_txt_Password.text,@"password",appDelegate.RollID,@"role_id",tokenid,@"deviceId",DEVICETYPE,@"deviceType" ,nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@login",kURl];
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
           // NSMutableDictionary *arrayDetail=[responseArray valueForKey:@"response"];
           // NSLog(@"%@",arrayDetail);
            NSMutableArray * UserInfo =[responseArray valueForKey:@"response"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:UserInfo forKey:@"UserDetails"];
            [defaults synchronize];
            str_USERID   = [responseArray valueForKey:@"userId"];
            [[NSUserDefaults standardUserDefaults]setObject:str_USERID forKey:@"user_id"];
            rollid = [[responseArray valueForKey:@"role_id"]stringValue];
            [[NSUserDefaults standardUserDefaults]setObject:rollid forKey:kLoggedInUserRollID];
            [[AppManager sharedManager] removeLoadingWindow];
            if ([rollid isEqualToString:@"4"]) {
                [self performSegueWithIdentifier:@"BLogin" sender:nil];
               
        
            }
            else{
                [self performSegueWithIdentifier:@"DLogin" sender:nil];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kISLoggedIn];

           // [self performSegueWithIdentifier:@"loginvideo" sender:self];
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

- (IBAction)btn_LoginAction:(id)sender {
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        [self LoginMethod];
        
    }
   
}

@end
