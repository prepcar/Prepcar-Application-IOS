//
//  ChangePasswordViewController.m
//  PrepCar
//
//  Created by Devendra on 12/28/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"CHANGE PASSWORD";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    
    [[AppManager sharedManager] changeTextFieldDesign:_txt_newPassword Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_Password Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:_txt_Conformpassword Image:[UIImage imageNamed:@"user-password"]];

}

-(BOOL)checkValidation{
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
    if (_txt_newPassword.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter  new  password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if (_txt_Conformpassword.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please re-enter new password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if ((_txt_newPassword.text != _txt_Conformpassword.text)){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Password and re-enter password not match"
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"Working!!!");
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)changepassword{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"userId",_txt_Password.text,@"oldPassword",_txt_newPassword.text,@"newPassword",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@changePassword",kURl];
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
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"]  duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            //[self performSegueWithIdentifier:@"FbLogin" sender:nil];
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

- (IBAction)btn_SubmitAction:(id)sender {
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        [self changepassword];
    }
    
}
@end
