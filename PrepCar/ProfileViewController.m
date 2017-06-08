//
//  ProfileViewController.m
//  PrepCar
//
//  Created by Devendra on 12/26/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "ProfileViewController.h"
#import "TGCameraViewController.h"


@interface ProfileViewController ()<UITextFieldDelegate,TGCameraDelegate>
{
    NSString * strMessage;
    NSString *imageString;
    NSData * imageDataa;
    NSArray *menuItems;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"PROFILE";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    UIColor *borderColor = [UIColor colorWithRed:182 green:10 blue:96 alpha:1.0];
    [self.img_ProfilePic.layer setBorderColor:borderColor.CGColor];
    [self.img_ProfilePic.layer setBorderWidth:3.0];
    self.img_ProfilePic.layer.cornerRadius = self.img_ProfilePic.frame.size.height /2;
    self.img_ProfilePic.layer.masksToBounds = YES;
    

     [self UserProfile];
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:@YES];
    
    // use the original image aspect instead of square
    [TGCamera setOption:kTGCameraOptionUseOriginalAspect value:@YES];
    [[AppManager sharedManager] changeTextFieldDesign:txt_City Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_state Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_Address Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_emailID Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_phoneNo Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_LastName Image:[UIImage imageNamed:@"user-password"]];
    [[AppManager sharedManager] changeTextFieldDesign:txt_FirstName Image:[UIImage imageNamed:@"user-password"]];
     [[AppManager sharedManager] changeTextFieldDesign:txt_zipcode Image:[UIImage imageNamed:@"user-password"]];
   
}

-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    scroller1.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+150);
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


//-(IBAction)pushback:(id)sender{
//    [self performSegueWithIdentifier:@"lognpush" sender:nil];
//}


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
            //NSMutableDictionary *arrayDetail=[responseArray valueForKey:@"response"];
            //NSLog(@"%@",arrayDetail);
            txt_FirstName.text=[responseArray valueForKey:@"firstName"];
            txt_LastName.text=[responseArray valueForKey:@"lastName"];
            txt_Address.text=[responseArray valueForKey:@"address"];
            txt_City.text=[responseArray valueForKey:@"city"];
            txt_emailID.text=[responseArray valueForKey:@"email"];
            txt_phoneNo.text=[responseArray valueForKey:@"phone"];
            txt_state.text=[responseArray valueForKey:@"state"];
            txt_zipcode.text=[responseArray valueForKey:@"zip"];
            
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
    
    if (txt_Address.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the Address"
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
    
    if (txt_zipcode.text.length==0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the Zip code"
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
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:txt_FirstName.text,@"first_name",txt_LastName.text,@"last_name",txt_emailID.text,@"email",txt_phoneNo.text,@"phone",txt_state.text,@"state",txt_City.text,@"city",txt_Address.text,@"address",txt_zipcode.text,@"zip",roll,@"role_id",user,@"userId",imageString,@"image",nil];
    
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
