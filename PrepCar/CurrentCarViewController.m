//
//  CurrentCarViewController.m
//  PrepCar
//
//  Created by Devendra on 1/6/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "CurrentCarViewController.h"
#import "ELCImagePickerDemoViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "TabbarViewController.h"
#import "UIImageView+WebCache.h"
#import "Haneke.h"
#import "TGCameraViewController.h"

@interface CurrentCarViewController ()<kDropDownListViewDelegate,TGCameraDelegate>
@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;
@end

@implementation CurrentCarViewController
@synthesize sliderLabel;
@synthesize slider;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    slider.minimumValue = 0;
    slider.maximumValue = 30000;
    txtdetail.delegate = self;
    urlarray=[[NSMutableArray alloc]init];

    conditionbtn.titleEdgeInsets = UIEdgeInsetsMake(-13,26, -10, 0);

    [[AppManager sharedManager] changeTextFieldDesign:yearbtn Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:makebtn Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:modelbtn Image:[UIImage imageNamed:@"user-email"]];
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:@YES];
    
    // use the original image aspect instead of square
    [TGCamera setOption:kTGCameraOptionUseOriginalAspect value:@YES];
   
    imgarray=[[NSMutableArray alloc]init];
    addImages=[[NSMutableArray alloc]init];
    convertimage=[[NSMutableArray alloc]init];
    [[AppManager sharedManager] changeTextFieldDesign:milagetxt Image:[UIImage imageNamed:@"user-email"]];
   
    self.navigationItem.title = @"CURRENT CAR";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90/255.0f green:192/255.0f blue:213/255.0f alpha:1.0f];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    conditionarray =[[NSMutableArray alloc]initWithObjects:@"New",@"Great",@"Fair",@"Poor", nil];
    imgarray=[[NSMutableArray alloc]init];
    [self savenewcardetail];
    
    
}
-(void)HomeBtnPressed
{
   [self performSegueWithIdentifier:@"go3" sender:nil];   
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90/255.0f green:192/255.0f blue:213/255.0f alpha:1.0f];
    
}


-(void) viewDidLayoutSubviews; {
    [super viewDidLayoutSubviews];
    Scroller1.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+180);
}



-(void)savenewcardetail{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@current_car",kURl];
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
            milagetxt.text=[responseArray valueForKey:@"mileage"];
            NSString*kbb=[responseArray valueForKey:@"kbb_value_estimate"];
            txtdetail.text=[NSString stringWithFormat:@"%@",kbb];
            NSString*str3=[responseArray valueForKey:@"make"];
            NSString*strm=[NSString stringWithFormat:@"%@",str3];
            makebtn.text = strm;
            //[makebtn setTitle:strm forState:UIControlStateNormal];
            NSString*str1=[responseArray valueForKey:@"model"];
            NSString*strmo=[NSString stringWithFormat:@"%@",str1];
            modelbtn.text = strmo;
           // [modelbtn setTitle:strmo forState:UIControlStateNormal];
            NSString*str2=[responseArray valueForKey:@"year"];
            NSString*stry=[NSString stringWithFormat:@"%@",str2];;
            yearbtn.text = stry;
           // [yearbtn setTitle:stry forState:UIControlStateNormal];
            NSString*str4=[responseArray valueForKey:@"car_condition"];
            NSString*strcar=[NSString stringWithFormat:@"%@",str4];
            [conditionbtn setTitle:strcar forState:UIControlStateNormal];
            
            NSString*stilltstr = [responseArray valueForKey:@"still_owd"];
            sliderLabel.text=[ NSString stringWithFormat:@"%@", stilltstr];
            self.slider.value = stilltstr.floatValue;
            str = stilltstr;
            addImages = [responseArray valueForKey:@"car_photos"];
            if (addImages == nil || (addImages .count<=0)) {
                [[AppManager sharedManager] removeLoadingWindow];
                
                
            } else {
                for (int i=0; i<addImages.count; i++){
                    commstr=[addImages objectAtIndex:i];
                    [self.viewcollection reloadData];
                    [urlarray addObject:commstr];
                }
            }
            [[AppManager sharedManager] removeLoadingWindow];
        }
        else {
            // [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            
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

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (IBAction)sliderValueChanged:(UISlider*)sender
{
    int value = (int)[self.slider value];
    int stepSize = 500;
    value = (value - value % stepSize);; // Rounds float to an integer
    str=[NSString stringWithFormat:@"%d",value];
    sliderLabel.text = [NSString stringWithFormat:@"%@",str];
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:90.0 G:192.0 B:213.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    NSString*single=[conditionarray objectAtIndex:anIndex];
    NSString*space=[NSString stringWithFormat:@"%@",single];
    [conditionbtn setTitle:space forState:UIControlStateNormal];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    if (ArryData.count>0) {
        NSString*strmain=[NSString stringWithFormat:@"%@",ArryData];
        
        
    }
    else{
        _lblSelectedCountryNames.text=@"";
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


-(IBAction)conditionbutton:(UIButton*)sender;
{
    
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CONDITION" withOption:conditionarray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 105) isMultiple:NO];
}


-(IBAction)browseBtnPressed:(id)sender{
   
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveandgonewcar:(id)sender {
    [self.view endEditing:YES];
    [self savenewcar];
}

- (void)savenewcar{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *joinedComponents = [urlarray componentsJoinedByString:@","];
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:[NSString stringWithFormat:@"%@",yearbtn.text] forKey:@"year"];
    [_params setObject:[NSString stringWithFormat:@"%@", makebtn.text] forKey:@"make"];
    [_params setObject:[NSString stringWithFormat:@"%@",modelbtn.text] forKey:@"model"];
    [_params setObject:[NSString stringWithFormat:@"%@",milagetxt.text] forKey:@"mileage"];
    [_params setObject:[NSString stringWithFormat:@"%@",conditionbtn.titleLabel.text] forKey:@"car_condition"];
    [_params setObject:[NSString stringWithFormat:@"%@",txtdetail.text] forKey:@"kbb_value_estimate"];
    [_params setObject:user forKey:@"buyer_id"];
    [_params setObject:str forKey:@"still_owd"];
    [_params setObject:joinedComponents forKey:@"temp_old_url"];
    
    
    [[AppManager sharedManager] addLoadingWindow];
    NSURL *url1 = [NSURL URLWithString:kURlcurrent_car];
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
        [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image[]\"; filename=\"upload.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
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
             double delayInSeconds = 0.3;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [[AppManager sharedManager] removeLoadingWindow];
                 [self performSegueWithIdentifier:@"go3" sender:nil];
             });
             
             //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
         }
         
         
         else {
             //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:0.5f];
             
         }
         [[AppManager sharedManager] removeLoadingWindow];
     }];
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    imageDataa = UIImagePNGRepresentation(image);
    //imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [convertimage addObject:image];
    [addImages addObject:[image copy]];
    [self.viewcollection reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    imageDataa = UIImagePNGRepresentation(image);
   // imageString = [imageDataa base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [convertimage addObject:image];
    [addImages addObject:[image copy]];
    [self.viewcollection reloadData];
    
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
    static NSString *identifier = @"cellcollection";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIButton *btndelete = (UIButton *)[cell viewWithTag:30];
    [btndelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([[addImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]])
    {
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:50];
        recipeImageView.image=[addImages objectAtIndex:indexPath.row];
        
        
    }
    else{
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:50];
        NSString*ImageURL=[addImages objectAtIndex:indexPath.row];
        NSURL*url=[NSURL URLWithString:ImageURL];
        [recipeImageView hnk_setImageFromURL:url];
        [recipeImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return cell;
}

-(void)deleteBtnPressed:(UIButton*)sender{
    UICollectionViewCell*cell;
    UIButton *btndelete = (UIButton *)[cell viewWithTag:30];
    myindexpath = [self.viewcollection indexPathForItemAtPoint:[self.viewcollection convertPoint:sender.center fromView:sender.superview]];
    [addImages removeObjectAtIndex:myindexpath.row];
    [urlarray removeObjectAtIndex:myindexpath.row];
    [btndelete removeFromSuperview];
    [self.viewcollection reloadData];
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
