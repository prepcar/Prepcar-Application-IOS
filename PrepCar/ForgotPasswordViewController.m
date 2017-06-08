//
//  ForgotPasswordViewController.m
//  PrepCar
//
//  Created by Devendra on 12/23/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
{
    NSString * strMessage;
}

@end

@implementation ForgotPasswordViewController
@synthesize txt_EmailId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [txt_EmailId setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    UIColor *emailcolor = [UIColor whiteColor];
    txt_EmailId.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Email address"
     attributes:@{NSForegroundColorAttributeName:emailcolor}];
    
    [[AppManager sharedManager] changeTextFieldDesign:txt_EmailId Image:[UIImage imageNamed:@"user-email"]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)checkValidation{
    if (txt_EmailId.text.length==0) {
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
    return YES;
}


-(void)processforgoPassword{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    //NSString *roll1=[[NSUserDefaults standardUserDefaults] objectForKey:kLoggedInUserRollID];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *roll1 =  appDelegate.RollID ;
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:txt_EmailId.text,@"email",roll1,@"role_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@forgotPassword",kURl];
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
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];

             [self performSegueWithIdentifier:@"hello" sender:nil];
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


-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btn_SubmitAction:(id)sender {
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        [self processforgoPassword];
    }
}
@end
