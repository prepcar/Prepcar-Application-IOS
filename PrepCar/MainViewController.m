
//
//  MainViewController.m
//  PrepCar
//
//  Created by anil on 10/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "MainViewController.h"
#import "CardView.h"
#import "TabbarViewController.h"
#import "Haneke.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MainViewController ()<DraggableCardViewDelegate,SDWebImageManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *cardViewPlaceholder;
@property (nonatomic, strong) NSMutableArray *cardViews;


@end

@implementation MainViewController
@synthesize dealerarray;
@synthesize delegate;

- (void)viewDidLoad {
     [super viewDidLoad];
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[AppManager sharedManager] removeLoadingWindow];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"left_arrow"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"left_arrow"]];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    featurearray=[[NSMutableArray alloc]init];

    self.cardViews = [NSMutableArray array];
    self.cardViewPlaceholder.hidden = NO;
    _cardViewPlaceholder.layer.shadowColor = [UIColor grayColor].CGColor;
    _cardViewPlaceholder.layer.shadowOffset = CGSizeMake(0, 5);
    _cardViewPlaceholder.layer.shadowOpacity = 1;
    _cardViewPlaceholder.layer.shadowRadius = 1.0;
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"RateViewValue"
                                               object:nil];
    });
    
 
}

- (void) receiveNotification:(NSNotification *) notification
{
    
    NSDictionary *newdict=[notification object];
    NSDictionary *dict=notification.userInfo;
    NSString *rating=[dict valueForKey:@"Rating"];
    NSLog(@"Current rating: %d",rating.intValue);
    ratestr=[NSString stringWithFormat:@"%d",rating.intValue];
    if (rating.intValue>=3) {
        [KSToastView ks_showToast:@"Added to favorites" duration:2.0f];
    }
    [self ratingdetail:newdict];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        [self initCardViews];
     
}

- (void)initCardViews
{
    
    for (int i = 0; i <dealerarray.count; i++)
    {
        CardView *cardView  = [[[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil] firstObject];
        
        cardView.tag=i+1000;
        cardView.frame = self.cardViewPlaceholder.frame;
        cardView.delegateOfDragging = self;
        cardView.rightOverlayImage = [UIImage imageNamed:@"no.jpg"];
        cardView.leftOverlayImage = [UIImage imageNamed:@"yes.png"];
        
        NSString*strname=[[dealerarray objectAtIndex:i]valueForKey:@"dealership_name"];
        if ([strname isEqualToString:@""]) {
            cardView.lblname.text=@"N/A";
        }
        else{
        cardView.lblname.text=[NSString stringWithFormat:@"@%@",strname];
        }
        
        carplane=[[dealerarray objectAtIndex:i]valueForKey:@"carplan_id"];
        [[NSUserDefaults standardUserDefaults]setObject:carplane forKey:@"car-planeid"];
        NSString*strdetail=[[dealerarray objectAtIndex:i]valueForKey:@"first_name"];
        if ([strdetail isEqualToString:@""]) {
            cardView.lbldealername.text=@"N/A";
        }
        else{
        cardView.lbldealername.text=strdetail;
        }
        ///////////
        NSString*strmake=[[dealerarray objectAtIndex:i]valueForKey:@"make"];
        
        NSString*stryear=[[dealerarray objectAtIndex:i]valueForKey:@"model_year"];
        
        NSString*strmodel=[[dealerarray objectAtIndex:i]valueForKey:@"model_type"];
        NSArray *myStrings = [[NSArray alloc] initWithObjects: stryear,strmake,strmodel, nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@" "];
        NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
        NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
        cardView.lbldetail.text=[NSString stringWithFormat:@"%@",trimmedString];
        //////////////////
        NSString*strprice=[[dealerarray objectAtIndex:i]valueForKey:@"price"];
        if ([strprice isEqualToString:@""]) {
            cardView.lblCount.text=@"$N/A";
        }
        else{
            cardView.lblCount.text=[NSString stringWithFormat:@"$%@",strprice];
        }
        
        NSString*strnick=[[dealerarray objectAtIndex:i]valueForKey:@"nickname"];
        if ([strnick isEqualToString:@""]) {
            cardView.lblnickname.text=@"N/A";
        }
        else{
            cardView.lblnickname.text=strnick;
        }
        
        NSString*strpay=[[dealerarray objectAtIndex:i]valueForKey:@"monthly_payment"];
        if ([strpay isEqualToString:@""]) {
            cardView.lblpayment.text=@"$N/A";
        }
        else{
            cardView.lblpayment.text=[NSString stringWithFormat:@"$%@",strpay];
        }
         NSString*strdescription=[[dealerarray objectAtIndex:i]valueForKey:@"description"];
        if ([strdescription isEqualToString:@""]) {
            cardView.lblcomment.text=@"N/A";
        }
        else{
            cardView.lblcomment.text=strdescription;
        }
        dealerstr=[[dealerarray objectAtIndex:i]valueForKey:@"dealer_id"];
        carstr=[[dealerarray objectAtIndex:i]valueForKey:@"car_id"];
       
        /////////////////
        
        ////////////////
        NSString*imagestr= [[dealerarray objectAtIndex:i]valueForKey:@"single_car_pic"];
         NSURL *url_Img1  =[NSURL URLWithString:imagestr];
               if (url_Img1 == nil || [url_Img1 isEqual:[NSNull null]]) {
                    cardView.swipeimg.image = [UIImage imageNamed:@"no-image"];
        
                } else
                {
                    [cardView.swipeimg sd_setImageWithURL:[NSURL URLWithString:imagestr]
                                 placeholderImage:[UIImage imageNamed:@""]];
                }
        ///////////////////
        NSString*imagestr1 = [[dealerarray objectAtIndex:i]valueForKey:@"profile_picture"];
        NSURL *url_Img2=[NSURL URLWithString:imagestr1];
        if ([imagestr1 isEqualToString:@""]) {
                cardView.ProImg.image = [UIImage imageNamed:@"no-image"];
          
        } else {
            
            [cardView.ProImg hnk_setImageFromURL:url_Img2];
        }
        
        [self.cardViews addObject:cardView];
    }
    
    for (CardView *cardView in self.cardViews.reverseObjectEnumerator)
    {
        
        [self.view addSubview:cardView];
    }
    //NSLog([self.view.subviews description]);
    
}

- (void)layoutCardViews
{
    for (CardView *i in self.cardViews)
    {
        i.frame = self.cardViewPlaceholder.frame;
    }
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
-(void)viewWillAppear:(BOOL)animated{    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CardView class]]) {
            [view removeFromSuperview];
            
        }
    }
    self.cardViews=[[NSMutableArray alloc]init];
   
        [self newmatchesdetail];
     
    
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark RSTapRateViewDelegate

//- (void)tapDidRateView:(RSTapRateView*)view rating:(NSInteger)rating {
//    NSLog(@"Current rating: %li", (long)rating);
//    ratestr=[NSString stringWithFormat:@"%ld",(long)rating];
//    if (rating>=3) {
//        [KSToastView ks_showToast:@"Add to Favorites" duration:2.0f];
//    }
//
//}

#pragma mark -
#pragma mark private

//- (void)send:(id)object {
//    UIAlertView *alertResult = [[UIAlertView alloc] initWithTitle:@"Thanks" message:[NSString stringWithFormat:@"You gave it %i-Stars rating!", self.tapRateView.rating] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//    [alertResult show];
//
//}
//
//#pragma mark -
//#pragma mark UIAlertViewDelegate
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [self.tapRateView clean];
//}
//

-(void)newmatchesdetail{
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
    NSString *strUrl=[NSString stringWithFormat:@"%@new_matches",kURl];
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
            dealerarray=[responseArray valueForKey:@"data"];
                [self initCardViews];
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
/////////



-(void)ratingdetail:(NSDictionary *)dic{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *str= [NSString stringWithFormat:@"%@",[dic objectForKey:@"tag"] ];
    dealerstr=[[dealerarray objectAtIndex:[str  intValue]-1000] valueForKey:@"dealer_id"];
    carstr=[[dealerarray objectAtIndex:[str  intValue]-1000]valueForKey:@"car_id"];
    dealid=[[dealerarray objectAtIndex:[str  intValue]-1000]valueForKey:@"deal_id"];
    NSMutableDictionary*postDictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",ratestr,@"rating",dealerstr,@"dealer_id",carstr,@"car_id",carplane,@"carplan_id",dealid,@"deal_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@rating",kURl];
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
            for (UIView *view in self.view.subviews) {
                if ([view isKindOfClass:[CardView class]]) {
                    [view removeFromSuperview];
                    
                }
            }
            self.cardViews=[[NSMutableArray alloc]init];
            
            [self newmatchesdetail];
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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
