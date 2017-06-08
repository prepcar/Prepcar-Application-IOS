//
//  SignUpViewController.m
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "SignUpViewController.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController
{
    NSString * strMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_txt_Email setValue:[UIColor colorWithRed:41.0/255.0 green:91.0/255.0 blue:106.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
   [_txt_DelearShipCode setValue:[UIColor colorWithRed:41.0/255.0 green:91.0/255.0 blue:106.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_ZipCode setValue:[UIColor colorWithRed:41.0/255.0 green:91.0/255.0 blue:106.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_Password setValue:[UIColor colorWithRed:41.0/255.0 green:91.0/255.0 blue:106.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [_txt_ConfirmPassword setValue:[UIColor colorWithRed:41.0/255.0 green:91.0/255.0 blue:106.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
 
    UIColor *emailcolor = [UIColor whiteColor];
    _txt_Email.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Email address"
     attributes:@{NSForegroundColorAttributeName:emailcolor}];
    
    UIColor *passwordcolor = [UIColor whiteColor];
    _txt_Password.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:passwordcolor}];
    
    UIColor *confrimcolor = [UIColor whiteColor];
    _txt_ConfirmPassword.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Confirm password"
     attributes:@{NSForegroundColorAttributeName:confrimcolor}];
    
    UIColor *zipcodecolor = [UIColor whiteColor];
    _txt_ZipCode.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Zip code"
     attributes:@{NSForegroundColorAttributeName:zipcodecolor}];
    
    UIColor *DelearShipCodecolor = [UIColor whiteColor];
    _txt_DelearShipCode.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Dealership code"
     attributes:@{NSForegroundColorAttributeName:DelearShipCodecolor}];
    

    [[AppManager sharedManager] changeTextFieldDesign:_txt_Email Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_Password Image:[UIImage imageNamed:@"user-password"]];
    
    [[AppManager sharedManager] changeTextFieldDesign:_txt_ZipCode Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_DelearShipCode Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_ConfirmPassword Image:[UIImage imageNamed:@"user-email"]];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    if ([appDelegate.RollID isEqualToString:@"4"]) {
        _txt_DelearShipCode.hidden=YES;
        _txt_ZipCode.hidden=NO;
        
    }else
    {
        _txt_DelearShipCode.hidden=NO;
        _txt_ZipCode.hidden=YES;
        [_txt_DelearShipCode  setFrame:CGRectMake(self.view.frame.origin.x+38, _txt_ConfirmPassword.frame.origin.y+66, self.view.frame.size.width-75, 44)];

    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)validateEmailWithString:(NSString*)email1
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email1];
}

-(BOOL)checkValidation{
    if (_txt_Email.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Email Id"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.RollID isEqualToString:@"4"]) {
    if (_txt_ZipCode.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Zip Code"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
}
    if ([appDelegate.RollID isEqualToString:@"4"]) {
    if (_txt_ZipCode.text.length<5) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter 5 number Zip Code"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
}
    
    if ([appDelegate.RollID isEqualToString:@"3"]) {
        if (_txt_DelearShipCode.text.length==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:@"Please enter Dealership code"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return NO;
        }
    }
    
    if (_txt_Password.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    
    if (_txt_ConfirmPassword.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Confirm Password"
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
    
    if ((_txt_Password.text != _txt_ConfirmPassword.text)){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter correct password"
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


-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btn_SignUpAction:(id)sender {
    
    if([self checkValidation]) {
        [self.view endEditing:YES];
        [self processSignUpUser];
        
    }
}

-(void)processSignUpUser{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *tokenid=[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenname"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:_txt_Email.text,@"email",_txt_ZipCode.text,@"zip",_txt_DelearShipCode.text,@"uniquecode",_txt_Password.text,@"password",appDelegate.RollID,@"role_id", DEVICETYPE,@"deviceType",tokenid,@"deviceId",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@register",kURl];
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
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
            [[AppManager sharedManager] removeLoadingWindow];
            [self performSegueWithIdentifier:@"DSignupLoginView" sender:nil];
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
