//
//  UploadcarViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "UploadcarViewController.h"
#import "ELCImagePickerDemoViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Haneke.h"
#import "TGCameraViewController.h"

@interface UploadcarViewController ()<TGCameraDelegate>
- (void)clearTapped;
@end

@implementation UploadcarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage*newimage=[UIImage imageNamed:@"left_arrow"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:newimage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.title = @"NEW CAR";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    arraycolor=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
    
    arrayfeature =[[NSMutableArray alloc]initWithObjects:@"Sunroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay",@"Bluetooth",@"Heated seats",@"Disability equiped",@"Premium audio",@"3rd row seat", nil];
     selectcolor=[[NSMutableArray alloc]init];
    fraturearray=[[NSMutableArray alloc]init];
    arry_feature=[[NSMutableArray alloc]init];
    urlarray=[[NSMutableArray alloc]init];
    
    // set custom tint color
    //[TGCameraColor setTintColor: [UIColor greenColor]];
    
    // save image to album
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:@YES];
    
    // use the original image aspect instead of square
    [TGCamera setOption:kTGCameraOptionUseOriginalAspect value:@YES];
    
    // hide switch camera button
    //[TGCamera setOption:kTGCameraOptionHiddenToggleButton value:@YES];
    
    // hide album button
    //[TGCamera setOption:kTGCameraOptionHiddenAlbumButton value:@YES;
    
    // hide filter button
    //[TGCamera setOption:kTGCameraOptionHiddenFilterButton value:@YES];
    
    
    //_photoView.clipsToBounds = YES;
    
//    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
//                                                                                 target:self
//                                                                                 action:@selector(clearTapped)];
//    
//    self.navigationItem.rightBarButtonItem = clearButton;
    
     btncolor.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btnfeature.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    //imgarray=[[NSMutableArray alloc]init];
    addImages=[[NSMutableArray alloc]init];
    convertimage=[[NSMutableArray alloc]init];
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    imagesArray=[[NSMutableArray alloc]init];
    stocktxt.delegate=self;
    [[AppManager sharedManager] changeTextFieldDesign:stocktxt Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtyear Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtmake Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtmodel Image:[UIImage imageNamed:@"user-email"]];
     str1=@"yes";
    if ([_strpast isEqualToString:@"new"]) {
    }
    else{
        [self Editcarmethod];
    }
   
}


-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    uploadscroll.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+80);
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:41.0 G:58.0 B:146.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    NSString*single=[arraycolor objectAtIndex:anIndex];
    NSString*space=[NSString stringWithFormat:@"%@",single];
    [btncolor setTitle:space forState:UIControlStateNormal];
    /*----------------Get Selected Value[Single selection]-----------------*/
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    if (ArryData.count>0) {
    for (int i=0; i<ArryData.count; i++) {
        //NSString*str=[ArryData objectAtIndex:i];
        featuredata= [ArryData componentsJoinedByString:@","];
    }
    [btnfeature setTitle:featuredata forState:UIControlStateNormal];
    [arry_feature addObject:featuredata];
    fraturearray = [arry_feature copy];
}
    else {
        //_lblSelectedCountryNames.text=@"";
    }
}


- (void)DropDownListViewDidCancel{
    
}


-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else{
        
        
        size = [lbl.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}

-(IBAction)featurebutton:(UIButton*)sender;

{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"FEATURES" withOption:arrayfeature xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES];
}



-(IBAction)colorBtnPressed:(id)sender{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"EXTERIOR COLOR" withOption:arraycolor xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:NO];
}


-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)checkValidation{
    if (txtyear.text.length==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the year"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    
    if (txtmake.text.length==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the make"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if (txtmodel.text.length==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the model type"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if ([btncolor.currentTitle isEqualToString:@"SELECT COLOR"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please select the exterior color"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if ([btnfeature.currentTitle isEqualToString:@"SELECT FEATURES"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please select the exterior color"
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)transmission:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        transmissionyes.backgroundColor= RGB(0, 17, 111);
        transmissionno.backgroundColor=[UIColor whiteColor];
        str1=@"yes";
    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        transmissionyes.backgroundColor=[UIColor whiteColor];
        transmissionno.backgroundColor = RGB(0, 17, 111);
        str1=@"no";
    }
    
    
}
-(IBAction)browseBtnPressed:(id)sender{
TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
[self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)uploadthenewcar:(id)sender {
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        if (carID==nil) {
           [self uploadnewcar];
        }
        else{
            [self uploadeditcar];
        }
    }
}
- (void)uploadeditcar{
        if (!isWifiAvailable)
        {
            [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [[AppManager sharedManager] removeLoadingWindow];
            return;
        }
        NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        caridsecond=[[NSUserDefaults standardUserDefaults] objectForKey:@"carsave"];
        NSData *jsonDataimage1 = [NSJSONSerialization dataWithJSONObject:fraturearray options:0 error:nil];
        jsonStringfeature1 = [[NSString alloc] initWithData:jsonDataimage1 encoding:NSUTF8StringEncoding];
        NSString *joinedComponents = [urlarray componentsJoinedByString:@","];
    
        NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
        [_params setObject:[NSString stringWithFormat:@"%@",txtyear.text] forKey:@"model_year"];
        [_params setObject:[NSString stringWithFormat:@"%@", txtmake.text] forKey:@"make"];
        [_params setObject:[NSString stringWithFormat:@"%@",txtmodel.text] forKey:@"model_type"];
        [_params setObject:[NSString stringWithFormat:@"%@",btncolor.titleLabel.text] forKey:@"exterior_color"];
        [_params setObject:[NSString stringWithFormat:@"%@",stocktxt.text] forKey:@"stock_number"];
        [_params setObject:user forKey:@"dealer_id"];
        [_params setObject:joinedComponents forKey:@"temp_old_url"];
        [_params setObject:str1 forKey:@"transmission"];
        [_params setObject:caridsecond forKey:@"car_id"];
        [_params setObject:jsonStringfeature1 forKey:@"features"];
        [[AppManager sharedManager] addLoadingWindow];
        NSURL *url1 = [NSURL URLWithString:kURlEdit_car];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *bodyData = [NSMutableData data];
        for (NSString *parameter in _params) {
            [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameter] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:parameter]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    
        for (int i=0; i<convertimage.count; i++) {
            webdata=UIImageJPEGRepresentation([convertimage objectAtIndex:i], 1.0);
            [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"car_pic[]\"; filename=\"upload.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[NSData dataWithData:webdata]];
            
            [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:bodyData];
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data,
                                                   NSError *error)
         {
             NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             NSLog(@"%@",responseArray);
             if ([[[responseArray valueForKey:@"status"] description] isEqualToString:@"1"]) {
                 [[AppManager sharedManager] removeLoadingWindow];
                 
                 [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
             }
             
             
             else {
                 [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
                 
             }
             [[AppManager sharedManager] removeLoadingWindow];
         }];
}


/////////////////
-(void)Editcarmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
     carID=[[NSUserDefaults standardUserDefaults] objectForKey:@"carsave"];
    
    
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:carID,@"car_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@car_detail",kURl];
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
            NSString*strmodel=[[arrayDetail valueForKey:@"model_type"]objectAtIndex:0];
            txtmodel.text=[NSString stringWithFormat:@"%@",strmodel];
            
            NSString*strmake=[[arrayDetail valueForKey:@"make"]objectAtIndex:0];
           txtmake.text=[NSString stringWithFormat:@"%@",strmake];
            
            NSString*stryear=[[arrayDetail valueForKey:@"model_year"]objectAtIndex:0];
            txtyear.text=[NSString stringWithFormat:@"%@",stryear];
           
            
             NSString*strcol=[[arrayDetail valueForKey:@"exterior_color"]objectAtIndex:0];
              [btncolor setTitle:strcol forState:UIControlStateNormal];
            
            fraturearray = [arrayDetail valueForKey:@"features"];
            if([fraturearray isKindOfClass:[NSNull class]]) {
                [[AppManager sharedManager] removeLoadingWindow];
                // return ;
            }
            else{
                for (int i=0; i<fraturearray.count; i++){
                    NSMutableArray*commstr1=[fraturearray objectAtIndex:i];
                    NSString*strtitle=[NSString stringWithFormat:@"%@",commstr1];
                    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString = [[strtitle componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
                    [btnfeature setTitle:newReplacedString forState:UIControlStateNormal];
                }
            }
            
            stocktxt.text=[[arrayDetail valueForKey:@"stock_number"]objectAtIndex:0];
            
            NSString* financestr = [[arrayDetail valueForKey:@"transmission"]objectAtIndex:0];
            if ([financestr isEqualToString:@"yes"]) {
                [self transmission:transmissionyes];
            }
            else{
                [self transmission:transmissionno];
                
            }

            addImages = [[arrayDetail valueForKey:@"car_pic"]objectAtIndex:0];
            if (addImages == nil || (addImages .count<=0)) {
                [[AppManager sharedManager] removeLoadingWindow];
                return ;
                
            } else {
                for (int i=0; i<addImages.count; i++){
                    commstr=[addImages objectAtIndex:i];
                    [self.uploadview reloadData];
                    [urlarray addObject:commstr];
                    
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
- (void)uploadnewcar{
    if (!convertimage ||!convertimage.count) {
        [KSToastView ks_showToast:@"Please upload car pic" duration:2.0f];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    else{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSData *jsonDataimage1 = [NSJSONSerialization dataWithJSONObject:fraturearray options:0 error:nil];
    jsonStringfeature1 = [[NSString alloc] initWithData:jsonDataimage1 encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:[NSString stringWithFormat:@"%@",txtyear.text] forKey:@"model_year"];
    [_params setObject:[NSString stringWithFormat:@"%@", txtmake.text] forKey:@"make"];
    [_params setObject:[NSString stringWithFormat:@"%@",txtmodel.text] forKey:@"model_type"];
    [_params setObject:[NSString stringWithFormat:@"%@",btncolor.titleLabel.text] forKey:@"exterior_color"];
    [_params setObject:[NSString stringWithFormat:@"%@",stocktxt.text] forKey:@"stock_number"];
    [_params setObject:user forKey:@"dealer_id"];
    [_params setObject:str1 forKey:@"transmission"];
    [_params setObject:jsonStringfeature1 forKey:@"features"];
    [[AppManager sharedManager] addLoadingWindow];
    NSURL *url1 = [NSURL URLWithString:kURl1];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSMutableData *bodyData = [NSMutableData data];
    for (NSString *parameter in _params) {
        [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameter] dataUsingEncoding:NSUTF8StringEncoding]];
        [bodyData appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:parameter]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    for (int i=0; i<convertimage.count; i++) {
        webdata=UIImageJPEGRepresentation([convertimage objectAtIndex:i], 1.0);
        [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"car_pic[]\"; filename=\"upload.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [bodyData appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [bodyData appendData:[NSData dataWithData:webdata]];
        
        [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:bodyData];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSLog(@"%@",responseArray);
         if ([[[responseArray valueForKey:@"status"] description] isEqualToString:@"1"]) {
             [[AppManager sharedManager] removeLoadingWindow];
             
             [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
            }
     
     
         else {
              [[AppManager sharedManager] removeLoadingWindow];
             [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
             
         }
         [[AppManager sharedManager] removeLoadingWindow];
     }];
 }
    
    
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
   
    img=image;
    imageDataa = UIImagePNGRepresentation(image);
    //imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [convertimage addObject:image];
    [addImages addObject:[image copy]];
    [self.uploadview reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    img=image;
    imageDataa = UIImagePNGRepresentation(image);
    //imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [convertimage addObject:image];
    [addImages addObject:[image copy]];
    [self.uploadview reloadData];

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


- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return addImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"uploadimage";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIButton *btndelete = (UIButton *)[cell viewWithTag:40];
    [btndelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    if([[addImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]])
    {
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:800];
        recipeImageView.image=[addImages objectAtIndex:indexPath.row];
        
        
    }
    else{
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:800];
        NSString*ImageURL=[addImages objectAtIndex:indexPath.row];
        NSURL*url=[NSURL URLWithString:ImageURL];
        
        [recipeImageView hnk_setImageFromURL:url];
        
    }
    return cell;
}



-(void)deleteBtnPressed:(UIButton*)sender{
    UICollectionViewCell*cell;
    UIButton *btndelete = (UIButton *)[cell viewWithTag:40];
    myindexpath = [self.uploadview indexPathForItemAtPoint:[self.uploadview convertPoint:sender.center fromView:sender.superview]];
    [addImages removeObjectAtIndex:myindexpath.row];
    [urlarray removeObjectAtIndex:myindexpath.row];
    [btndelete removeFromSuperview];
    [self.uploadview reloadData];
}


@end
