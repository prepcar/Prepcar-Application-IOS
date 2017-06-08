//
//  CarplanViewController.m
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "CarplanViewController.h"
#import "Haneke.h"

#define MAXIMUM_SCALE 5.0
#define MINIMUM_SCALE    1.0

@interface CarplanViewController ()


@end

@implementation CarplanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    image=[[NSMutableArray alloc]init];
    self.view1.allowsSelection = YES;
    showimageview.hidden=YES;
    btnmore.hidden=YES;
    detailreadmore.hidden=YES;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
    finalimage.gestureRecognizers = @[pinch];
    finalimage.userInteractionEnabled = YES;
    self.scrollerimage.delegate = self;
    [self carplanedetailmethod];
}
-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    _scroller.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+1520);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return image.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"imagecell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:88];
    NSString*ImageURL=[image objectAtIndex:indexPath.row];
    NSURL*url1=[NSURL URLWithString:ImageURL];
    [recipeImageView hnk_setImageFromURL:url1];
    recipeImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    
    [recipeImageView addGestureRecognizer:tapGesture1];
    
    
    
    return cell;
}


- (void) tapGesture: (UIGestureRecognizer*)sender
{
        UIImageView *imgview=(UIImageView*)sender.view;
        CGPoint buttonPosition = [imgview convertPoint:CGPointZero toView:self.view1];
        NSIndexPath *myindexPath = [self.view1 indexPathForItemAtPoint:buttonPosition];
         NSString*ImageURL=[image objectAtIndex:myindexPath.row];
        NSURL*url=[NSURL URLWithString:ImageURL];
        if ([ImageURL isEqualToString:@""])
            return;
        else{
            HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
            if (!format)
            {
                format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
                format.size = CGSizeMake(320, 320);
                format.scaleMode = HNKScaleModeAspectFill;
                format.compressionQuality = 0.5;
                format.diskCapacity = 1 * 1024 * 1024; // 1MB
                format.preloadPolicy = HNKPreloadPolicyLastSession;
            }
            finalimage.hnk_cacheFormat = format;

            [finalimage hnk_setImageFromURL:url];
            showimageview.hidden=NO;
            UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
            [mainWindow addSubview: showimageview];

  }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return finalimage;
}

//-----------------------------------------------------------------------

#pragma mark - Custom Methods

- (void)zoomImage:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded
        || gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"gesture.scale = %f", gesture.scale);
        
        CGFloat currentScale = finalimage.frame.size.width / finalimage.bounds.size.width;
        CGFloat newScale = currentScale * gesture.scale;
        
        if (newScale < MINIMUM_SCALE) {
            newScale = MINIMUM_SCALE;
        }
        if (newScale > MAXIMUM_SCALE) {
            newScale = MAXIMUM_SCALE;
        }
        
        CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
        finalimage.transform = transform;
        _scrollerimage.contentSize = finalimage.frame.size;
        
    }
    
}
-(IBAction)readmore:(id)sender{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    [alert showNotice:self title:@"What's your goal" subTitle:discriptionstr closeButtonTitle:@"OK" duration:0.0f];
}

-(IBAction)readmoredetail:(id)sender{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    [alert showNotice:self title:@"DETAIL" subTitle:strreadmore closeButtonTitle:@"OK" duration:0.0f];
}


-(IBAction)hideviewsmethod:(id)sender{
    
    showimageview.hidden=YES;
}

-(IBAction)sendmatchesmethod:(id)sender{
   
    [self performSegueWithIdentifier:@"pushmatch" sender:nil];
   }

-(void)carplanedetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *carplan=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedcar"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:buyerID,@"buyer_id",userstr,@"dealer_id",carplan,@"carplan_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@car_plan_detail",kURl];
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
            
            NSMutableDictionary*discoverydict=[[responsedict valueForKey:@"response"]valueForKey:@"discoveryData"];
            lblidentity.text=[[discoverydict valueForKey:@"identify"]objectAtIndex:0];
            lblfirstcar.text=[[discoverydict valueForKey:@"first_car"]objectAtIndex:0];
            
            NSString*strmain =[[discoverydict valueForKey:@"main_use"]objectAtIndex:0];
            NSCharacterSet *unwantedChars = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString11 = [[strmain componentsSeparatedByCharactersInSet:unwantedChars] componentsJoinedByString: @""];
            lblmainuses.text=[NSString stringWithFormat:@"%@",resultString11];
            lblhieght.text=[[discoverydict valueForKey:@"height"]objectAtIndex:0];
        
            lblchildren.text=[[discoverydict valueForKey:@"small_children"]objectAtIndex:0];
            lbldiscount.text=[[discoverydict valueForKey:@"discount"]objectAtIndex:0];
            lblzipcode.text=[[discoverydict valueForKey:@"zipcode"]objectAtIndex:0];
            discriptionstr=[[discoverydict valueForKey:@"shopping_notes"]objectAtIndex:0];
            lblshopping.text=discriptionstr;
            if ([lblshopping.text length]<20) {
                btnmore.hidden=YES;
            }
            else{
                btnmore.hidden=NO;
            }
            /////////////////////finance
            NSMutableDictionary*financesdict=[[responsedict valueForKey:@"response"]valueForKey:@"financesData"];
            lblincome.text=[[financesdict valueForKey:@"est_monthly_income"]objectAtIndex:0];
            lblrent.text=[[financesdict valueForKey:@"rent"]objectAtIndex:0];
            lblamountr.text=[[financesdict valueForKey:@"rent_amount"]objectAtIndex:0];
            lblmortage.text=[[financesdict valueForKey:@"mortgage"]objectAtIndex:0];
            lblamountm.text=[[financesdict valueForKey:@"amount1"]objectAtIndex:0];
            lblstudent.text=[[financesdict valueForKey:@"student_loans"]objectAtIndex:0];
            lblamounts.text=[[financesdict valueForKey:@"amount2"]objectAtIndex:0];
            lblscore.text=[[financesdict valueForKey:@"est_credit_score"]objectAtIndex:0];
            lblpayment.text=[[financesdict valueForKey:@"suggested_monthly_payment"]objectAtIndex:0];
            lblchoose.text=[[financesdict valueForKey:@"choose_your_own"]objectAtIndex:0];
            lblbuget.text=[[financesdict valueForKey:@"budget"]objectAtIndex:0];
            lbldown.text=[[financesdict valueForKey:@"down_payment"]objectAtIndex:0];
            //////////currentcar
            NSMutableDictionary*currentdict=[[responsedict valueForKey:@"response"]valueForKey:@"current_carData"];
            lblyear.text=[[currentdict valueForKey:@"year"]objectAtIndex:0];
            lblmake.text=[[currentdict valueForKey:@"make"]objectAtIndex:0];
            lblmodel.text=[[currentdict valueForKey:@"model"]objectAtIndex:0];
            lblowed.text=[[currentdict valueForKey:@"still_owd"]objectAtIndex:0];
            lblmilage.text=[[currentdict valueForKey:@"mileage"]objectAtIndex:0];
            lblcondition.text=[[currentdict valueForKey:@"car_condition"]objectAtIndex:0];
            strreadmore =[[currentdict valueForKey:@"kbb_value_estimate"]objectAtIndex:0];
            lbldetail.text=strreadmore;
            if ([lbldetail.text length]<20) {
                detailreadmore.hidden=YES;
            }
            else{
                detailreadmore.hidden=NO;
            }
            image=[[currentdict valueForKey:@"car_photos"]objectAtIndex:0];
            if (image == nil || (image == [NSNull null])) {
                [[AppManager sharedManager] removeLoadingWindow];
                
            } else {
                for (int i=0; i<image.count; i++){
                    strimg=[image objectAtIndex:i];
                   [_view1 reloadData];
                    double delayInSeconds = 0.3;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [[AppManager sharedManager] removeLoadingWindow];
                    });
 
                }
            
            }
            /////////////////
            NSMutableDictionary*hasitentdict=[[responsedict valueForKey:@"response"]valueForKey:@"new_carData"];
            
            NSString*convert=[[hasitentdict valueForKey:@"year_range"]objectAtIndex:0];
            if (convert.length==0) {
                
            }
            else{
            NSString *result =[convert substringToIndex:4];
            lblminyear.text=[NSString stringWithFormat:@"%@",result];
            }
            NSString*convert1=[[hasitentdict valueForKey:@"year_range_max"]objectAtIndex:0];
            if (convert1.length==0) {
                
            }
            else{
            NSString *result1 =[convert1 substringToIndex:4];
            lblmaxyear.text=[NSString stringWithFormat:@"%@",result1];
            }
            NSString*str=[[hasitentdict valueForKey:@"type"]objectAtIndex:0];
            NSCharacterSet *unwantedChars1 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString = [[str componentsSeparatedByCharactersInSet:unwantedChars1] componentsJoinedByString: @""];
            lbltype.text=[NSString stringWithFormat:@"%@",resultString];
           
            
            /////////////////////
           NSString*strsty =[[hasitentdict valueForKey:@"styles"]objectAtIndex:0];
            NSCharacterSet *unwantedChars2 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString1 = [[strsty componentsSeparatedByCharactersInSet:unwantedChars2] componentsJoinedByString: @""];
            lblstyle.text=[NSString stringWithFormat:@"%@",resultString1];
            
            /////////////////////////
            lblmilag.text=[[hasitentdict valueForKey:@"mileage"]objectAtIndex:0];
            //////////////////
           NSString*strcol =[[hasitentdict valueForKey:@"color"]objectAtIndex:0];
            
            NSCharacterSet *unwantedChars3 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString2 = [[strcol componentsSeparatedByCharactersInSet:unwantedChars3] componentsJoinedByString: @""];
            lblcolor.text=[NSString stringWithFormat:@"%@",resultString2];
            
            /////////////////////////
            lbltrans.text=[[hasitentdict valueForKey:@"transmission"]objectAtIndex:0];
            ///////////////////////
            lblpower.text=[[hasitentdict valueForKey:@"engine_power"]objectAtIndex:0];
            /////////////////////
            NSString*strpre=[[hasitentdict valueForKey:@"preferences"]objectAtIndex:0];
            NSCharacterSet *unwantedChars4 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString3 = [[strpre componentsSeparatedByCharactersInSet:unwantedChars4] componentsJoinedByString: @""];
            lblprefrience.text=[NSString stringWithFormat:@"%@",resultString3];
            
            //////////////////
            NSString*strameric=[[hasitentdict valueForKey:@"brand_americans"]objectAtIndex:0];
            NSCharacterSet *unwantedChars5 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString4 = [[strameric componentsSeparatedByCharactersInSet:unwantedChars5] componentsJoinedByString: @""];
            lblamerican.text=[NSString stringWithFormat:@"%@",resultString4];
           
            //////////////////////
            NSString*strasia=[[hasitentdict valueForKey:@"brand_asians"]objectAtIndex:0];
            NSCharacterSet *unwantedChars6 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString5 = [[strasia componentsSeparatedByCharactersInSet:unwantedChars6] componentsJoinedByString: @""];
            lblasian.text=[NSString stringWithFormat:@"%@",resultString5];
            
            /////////////////////
           NSString*streurop=[[hasitentdict valueForKey:@"brand_europeans"]objectAtIndex:0];
            NSCharacterSet *unwantedChars7 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString6 = [[streurop componentsSeparatedByCharactersInSet:unwantedChars7] componentsJoinedByString: @""];
            lbleurope.text=[NSString stringWithFormat:@"%@",resultString6];
           
            //////////////////////
            NSString*strnw=[[hasitentdict valueForKey:@"new"]objectAtIndex:0];
            NSCharacterSet *unwantedChars8 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString7 = [[strnw componentsSeparatedByCharactersInSet:unwantedChars8] componentsJoinedByString: @""];
            lblcartype.text=[NSString stringWithFormat:@"%@",resultString7];
            
            /////////////////
            NSString*strmak=[[hasitentdict valueForKey:@"make"]objectAtIndex:0];
            NSCharacterSet *unwantedChars9 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString8 = [[strmak componentsSeparatedByCharactersInSet:unwantedChars9] componentsJoinedByString: @""];
            lblmakewant.text=[NSString stringWithFormat:@"%@",resultString8];
           
            ////////////////
            NSString*strmod=[[hasitentdict valueForKey:@"model"]objectAtIndex:0];
            NSCharacterSet *unwantedChars10 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString9 = [[strmod componentsSeparatedByCharactersInSet:unwantedChars10] componentsJoinedByString: @""];
            lblmodelwant.text=[NSString stringWithFormat:@"%@",resultString9];
            
            ///////////////
            NSString*stryea=[[hasitentdict valueForKey:@"year"]objectAtIndex:0];
            NSCharacterSet *unwantedChars11 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString10 = [[stryea componentsSeparatedByCharactersInSet:unwantedChars11] componentsJoinedByString: @""];
            lblyearwant.text=[NSString stringWithFormat:@"%@",resultString10];
            
            /////////////////////
            NSString*strfeat=[[hasitentdict valueForKey:@"features"]objectAtIndex:0];
            NSCharacterSet *unwantedChars12 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString15 = [[strfeat componentsSeparatedByCharactersInSet:unwantedChars12] componentsJoinedByString: @""];
            lblfeature.text=[NSString stringWithFormat:@"%@",resultString15];
           
            ////////////////////////
            NSString*strcomm=[[hasitentdict valueForKey:@"comment"]objectAtIndex:0];
            NSCharacterSet *unwantedChars13 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString12 = [[strcomm componentsSeparatedByCharactersInSet:unwantedChars13] componentsJoinedByString: @""];
            lblcomment.text=[NSString stringWithFormat:@"%@",resultString12];
            
            ///////////////////////
            NSString*strcolor=[[hasitentdict valueForKey:@"color"]objectAtIndex:0];
            NSCharacterSet *unwantedChars20 = [NSCharacterSet characterSetWithCharactersInString:@"\"[]"];
            NSString *resultString21 = [[strcolor componentsSeparatedByCharactersInSet:unwantedChars20] componentsJoinedByString: @""];
            lblsearch.text=[NSString stringWithFormat:@"%@",resultString21];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
            
        }

        else {
            [KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


@end
