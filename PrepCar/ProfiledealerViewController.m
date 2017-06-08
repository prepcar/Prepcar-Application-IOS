
//
//  ProfiledealerViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "ProfiledealerViewController.h"
#import "TGCameraViewController.h"

@interface ProfiledealerViewController ()<UITextFieldDelegate,TGCameraDelegate>
{
    NSString * strMessage;
    NSString *imageString;
    NSData * imageDataa;
    NSArray *menuItems;
}


@end

@implementation ProfiledealerViewController

- (void)viewDidLoad {
    [[self navigationController] setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"EDIT PROFILE";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    
    [[AppManager sharedManager] changeTextFieldDesign:txt_City Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_state Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_Address Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_emailID Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_phoneNo Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_LastName Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_FirstName Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_zipcode Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtdealername Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtdealershipcode Image:[UIImage imageNamed:@"user-password"]];
    self.img_ProfilePic.layer.cornerRadius = self.img_ProfilePic.frame.size.height /2;
    self.img_ProfilePic.layer.masksToBounds = YES;
    self.img_ProfilePic.layer.borderWidth = 5;
    self.img_ProfilePic.layer.borderColor=[UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    txtdealername.userInteractionEnabled = NO;
    txtdealershipcode.userInteractionEnabled = NO;
    
    
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:@YES];
    
    // use the original image aspect instead of square
    [TGCamera setOption:kTGCameraOptionUseOriginalAspect value:@YES];

    [self UserProfile];
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    scroller1.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+180);
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UserProfile{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"userId",appDelegate.Devise_ID,@"deviceId",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@profile",kURl];
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
            txt_FirstName.text=[responseArray valueForKey:@"firstName"];
            txt_LastName.text=[responseArray valueForKey:@"lastName"];
            txt_City.text=[responseArray valueForKey:@"city"];
            txt_emailID.text=[responseArray valueForKey:@"email"];
            txt_phoneNo.text=[responseArray valueForKey:@"phone"];
            txt_state.text=[responseArray valueForKey:@"state"];
            txtdealername.text=[responseArray valueForKey:@"dealer_name"];
            txtdealershipcode.text=[responseArray valueForKey:@"unicode"];
            
            self.img_ProfilePic.layer.backgroundColor=[[UIColor clearColor] CGColor];
            self.img_ProfilePic.layer.cornerRadius = self.img_ProfilePic.frame.size.height/2;
            self.img_ProfilePic.layer.masksToBounds = YES;
            self.img_ProfilePic.layer.borderWidth=1;
            [self.img_ProfilePic.layer setBorderColor :[[UIColor whiteColor] CGColor]];
            
            NSString *urlstring =[responseArray valueForKey:@"profilePicture"];
            if (urlstring) {
                NSString *urlstring =[responseArray valueForKey:@"profilePicture"];
                NSString *imgURL = urlstring;
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
                [self.img_ProfilePic  setImage:[UIImage imageWithData:data]];
                if (data)
                {
                }else{
                    self.img_ProfilePic.image = [UIImage imageNamed:@"logo.png"];
                }
            }
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
- (BOOL)validateEmailWithString:(NSString*)email1
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email1];
}


-(BOOL)checkValidation{
    if (txt_FirstName.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter First Name"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    if (txt_LastName.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter Last Name"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if (txt_City.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the City"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if (txt_state.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the State"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if (txt_emailID.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the Email Id"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if (txt_phoneNo.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the Phone Number"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if (![[AppManager sharedManager] validateEmailWithString:txt_emailID.text]) {
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

- (IBAction)btn_UpdateAction:(id)sender {
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        [self processUpdateProfile];
    }
}
-(void)processUpdateProfile{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *roll=[[NSUserDefaults standardUserDefaults] objectForKey:kLoggedInUserRollID];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:txt_FirstName.text,@"first_name",txt_LastName.text,@"last_name",txt_emailID.text,@"email",txt_phoneNo.text,@"phone",txt_state.text,@"state",txt_City.text,@"city",roll,@"role_id",user,@"userId",imageString,@"image",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@editProfile",kURl];
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
            [[AppManager sharedManager] removeLoadingWindow];
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
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

- (IBAction)btn_OnclickChangeProfilePic:(id)sender {
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}


- (void)cameraDidTakePhoto:(UIImage *)image
{
    CGSize sacleSize = CGSizeMake(150, 150);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.img_ProfilePic.image = resizedImage;
    imageDataa = UIImagePNGRepresentation(resizedImage);
    imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"%@", imageDataa);
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    CGSize sacleSize = CGSizeMake(150, 150);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.img_ProfilePic.image = resizedImage;
    imageDataa = UIImagePNGRepresentation(resizedImage);
    imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"%@", imageDataa);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL
{
    NSLog(@"%s album path: %@", __PRETTY_FUNCTION__, assetURL);
}

- (void)cameraDidSavePhotoWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __PRETTY_FUNCTION__, error);
}




@end
