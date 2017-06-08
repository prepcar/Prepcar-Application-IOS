//
//  SearchViewController.m
//  PrepCar
//
//  Created by Devendra on 1/9/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
@interface SearchViewController ()

{
    NSString *  str_Lat;
    NSString *  str_Long;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    [self.navigationItem.backBarButtonItem setTitle:@"Back"];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    [[AppManager sharedManager] changeTextFieldDesign:txtdreamcar Image:[UIImage imageNamed:@"user-email"]];


     txtdreamcar.delegate=self;

     btncount1.layer.cornerRadius = btncount1.bounds.size.width/2;
     btncount2.layer.cornerRadius = btncount2.bounds.size.width/2;
     btncount3.layer.cornerRadius = btncount3.bounds.size.width/2;
     btncount4.layer.cornerRadius = btncount4.bounds.size.width/2;
     btncount5.layer.cornerRadius = btncount5.bounds.size.width/2;
     btnnumbercount.layer.cornerRadius = btnnumbercount.bounds.size.width/2;
     btnnumbercount.backgroundColor=RGB(47, 129, 63);
    _location.placeSearchDelegate                 = self;
    _location.strApiKey                           = @"AIzaSyCoIiBVYyUntKhoIKgK-mIlPwiQF6IPQfE";
    _location.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    _location.autoCompleteShouldHideOnSelection   = YES;
    _location.maximumNumberOfAutoCompleteRows     = 5;
    [_location setDelegate:self];
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    [self clickcountbtn:btncount3];

}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
}

-(void)HomeBtnPressed
{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TabbarViewController class]] ) {
            TabbarViewController *groupViewController = (TabbarViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
        }
    }
}
-(IBAction)clickcountbtn:(UIButton*)sender{
    if(sender.tag==501)
    {
        btncount1.backgroundColor=RGB(133, 210, 229);
        btncount2.backgroundColor=[UIColor whiteColor];
        btncount3.backgroundColor=[UIColor whiteColor];
        btncount4.backgroundColor=[UIColor whiteColor];
        btncount5.backgroundColor=[UIColor whiteColor];
        counting=@"5";
        [self btnmilescount];
    }
    if (sender.tag==502)
    {
        btncount1.backgroundColor=[UIColor whiteColor];
        btncount2.backgroundColor=RGB(133, 210, 229);
        btncount3.backgroundColor=[UIColor whiteColor];
        btncount4.backgroundColor=[UIColor whiteColor];
        btncount5.backgroundColor=[UIColor whiteColor];
        counting=@"15";
        [self btnmilescount];
    }
    if (sender.tag==503)
    {
        btncount1.backgroundColor=[UIColor whiteColor];
        btncount2.backgroundColor=[UIColor whiteColor];
        btncount3.backgroundColor=RGB(133, 210, 229);
        btncount4.backgroundColor=[UIColor whiteColor];
        btncount5.backgroundColor=[UIColor whiteColor];
        counting=@"25";
        [self btnmilescount];
    }
    if (sender.tag==504)
    {
        btncount1.backgroundColor=[UIColor whiteColor];
        btncount2.backgroundColor=[UIColor whiteColor];
        btncount3.backgroundColor=[UIColor whiteColor];
        btncount4.backgroundColor=RGB(133, 210, 229);
        btncount5.backgroundColor=[UIColor whiteColor];
        counting=@"35";
        [self btnmilescount];

    }
    
    if (sender.tag==505)
    {
        btncount1.backgroundColor=[UIColor whiteColor];
        btncount2.backgroundColor=[UIColor whiteColor];
        btncount3.backgroundColor=[UIColor whiteColor];
        btncount4.backgroundColor=[UIColor whiteColor];
        btncount5.backgroundColor=RGB(133, 210, 229);
        counting=@"50";
        [self btnmilescount];

    }
}

-(void)viewDidAppear:(BOOL)animated{
    //Optional Properties
    _location.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _location.autoCompleteBoldFontName = @"HelveticaNeue";
    _location.autoCompleteTableCornerRadius=0.0;
    _location.autoCompleteRowHeight=35;
    _location.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    _location.autoCompleteFontSize=14;
    _location.autoCompleteTableBorderWidth=1.0;
    _location.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    _location.autoCompleteShouldHideOnSelection=YES;
    _location.autoCompleteShouldHideClosingKeyboard=YES;
    _location.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    _location.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_location.frame.size.width)*0.5, _location.frame.size.height+100.0, _location.frame.size.width, 200.0);
}



#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
}
-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField
{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [txtdreamcar resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)findmatchesbtn:(id)sender{
    
       [self findmatches];
}

-(void)findmatches{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",counting,@"miles",txtdreamcar.text,@"address", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@find_my_matches",kURl];
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
            arraysearch=[responseArray valueForKey:@"data"];
            NSLog(@"%@",arraysearch);
            [self performSegueWithIdentifier:@"backtomatches" sender:nil];
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        
            
            
        }
        else {
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
        

    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}



-(void)btnmilescount{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",counting,@"miles",txtdreamcar.text,@"address", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@count_my_matches",kURl];
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
            NSString*countarray=[responseArray valueForKey:@"count"];
            NSString*countstr=[NSString stringWithFormat:@"%@",countarray];
            [btnnumbercount setTitle:countstr forState:UIControlStateNormal];
            [[AppManager sharedManager] removeLoadingWindow];
            
            
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
        }
        else {
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
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
//    if ([segue.identifier isEqualToString:@"backtomatches"]) {
//        MainViewController *container = (MainViewController *)[segue destinationViewController];
//        container.dealerarray = arraysearch;
//        container.isComeFromSearch=YES;
//    }

}
//locationmanager
- (void)locationManager:(CLLocationManager* )manager didFailWithError:(NSError* )error
{
    NSLog(@"locationManager:%@ didFailWithError:%@", manager, error);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    str_Lat =[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    str_Long =[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    //
    //    strLong =[NSString stringWithFormat:@"%f",responseDict.coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray* placemarks, NSError* error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       NSLog(@"placemarks=%@",[placemarks objectAtIndex:0]);
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       NSLog(@"placemark.ISOcountryCode =%@",placemark.ISOcountryCode);
                       NSLog(@"placemark.country =%@",placemark.country);
                       NSLog(@"placemark.postalCode =%@",placemark.postalCode);
                       
                       NSLog(@"placemark.administrativeArea =%@",placemark.administrativeArea);
                       NSLog(@"placemark.locality =%@",placemark.locality);
                       
                       NSArray* array = @[ placemark.locality,placemark.country];
                       NSString* Location = [array componentsJoinedByString:@", "];
                       NSLog(@"placemark.subLocality =%@",placemark.subLocality);
                       NSLog(@"placemark.subThoroughfare =%@",placemark.subThoroughfare);
                       txtdreamcar.text =Location;
                       [self clickcountbtn:btncount3];

                       //  appDelegate.str_CurrentLocation= _txtPlaceSearch.text;
                   }];
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    
    
    
}
@end
