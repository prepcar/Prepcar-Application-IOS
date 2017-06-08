//
//  FavoriateViewController.m
//  PrepCar
//
//  Created by anil on 10/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "FavoriateViewController.h"
#import "FavoriteTableViewCell.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Haneke.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MessageUI/MessageUI.h>


@interface FavoriateViewController ()<MFMessageComposeViewControllerDelegate>
{
    UIImageView *imageView;
    FavoriteTableViewCell *cell;
}
@end

@implementation FavoriateViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    showcarpic=[[NSMutableArray alloc]init];
    finalpicarray=[[NSMutableArray alloc]init];
    featurearray=[[NSMutableArray alloc]init];
    addarray =[[NSMutableArray alloc]init];
       viewcall.hidden=YES;
        viewcomment.hidden=YES;
        textcomment.delegate=self;
        cell.btnviewmore.hidden=YES;
        viewdatetime.hidden=YES;
        cell.expiredview.hidden=YES;
        
        [txtdate setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [txttime setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        
        UIColor *emailcolor = [UIColor blackColor];
        txtdate.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:@"Date"
         attributes:@{NSForegroundColorAttributeName:emailcolor}];
        
        UIColor *Passwordcolor = [UIColor blackColor];
        txttime.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:@"Time"
         attributes:@{NSForegroundColorAttributeName:Passwordcolor}];
        

        
        datePickerStart=[[UIDatePicker alloc]init];
        datePickerStart.datePickerMode=UIDatePickerModeDate;
        [txtdate setInputView:datePickerStart];
        UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar setTintColor:[UIColor grayColor]];
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowStartDate)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [txtdate setInputAccessoryView:toolBar];
        //////////////
        TimePickerStart=[[UIDatePicker alloc]init];
        TimePickerStart.datePickerMode=UIDatePickerModeTime;
        [txttime setInputView:TimePickerStart];
        UIToolbar *toolBar2=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar2 setTintColor:[UIColor grayColor]];
        UIBarButtonItem *doneBtn2=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowStartTime)];
        UIBarButtonItem *space2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar2 setItems:[NSArray arrayWithObjects:space2,doneBtn2, nil]];
        
        [txttime setInputAccessoryView:toolBar2];
        
        [[AppManager sharedManager] changeTextFieldDesign:txttime Image:[UIImage imageNamed:@"user-email"]];
        [[AppManager sharedManager] changeTextFieldDesign:txtdate Image:[UIImage imageNamed:@"user-email"]];
        [self favoritesdetail];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    //double delayInSeconds = 0.6;
   // dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
   // dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        viewcall.hidden=YES;
        viewcomment.hidden=YES;
        [self favoritesdetail];
   // });
    }

-(void)ShowStartDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/YYYY"];
    [datePickerStart setMinimumDate: [NSDate date]];
    txtdate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePickerStart.date]];
    [txtdate resignFirstResponder];
}


-(void)ShowStartTime
{
    
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"hh:mm a"];
    //    [TimePickerEnd setMinimumDate: [NSDate date]];
    txttime.text=[NSString stringWithFormat:@"%@",[formatter2 stringFromDate:TimePickerStart.date]];
    
    [txttime resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return detailarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"detailCell";
    cell = (FavoriteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString*strmake=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"make"];
    
    NSString*stryear=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"model_year"];
    
    NSString*strmodel=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"model_type"];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: stryear,strmake,strmodel, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    cell.lblmake.text=[NSString stringWithFormat:@"%@",trimmedString];
    
    NSString*strnik=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"nickname"];
    if ([strnik isEqualToString:@""]) {
        cell.lblamount.text=@"N/A";
    }
    else{
        cell.lblamount.text=strnik;
    }
    NSString*strlase=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"lease_deal_trems"];
    if ([strlase isEqualToString:@""]) {
        cell.lbllease.text=@"N/A";
    }
    else{
        cell.lbllease.text=strlase;
    }
    NSString*strrate=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"interest_rate"];
    if ([strrate isEqualToString:@""]) {
        cell.lblrate.text=@"N/A";
    }
    else{
        cell.lblrate.text=[NSString stringWithFormat:@"%@ %%",strrate];
    }
    
    NSString*strsales=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"monthly_payment"];
    NSString*strmonth=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"months"];
    if ([strsales isEqualToString:@""]) {
        cell.lblsales.text=@"N/A";
    }
    else{
        NSString*combine= [NSString stringWithFormat:@"$%@ per month for ",strsales];
        NSString*combine1=[NSString stringWithFormat:@"%@ months",strmonth];
        cell.lblsales.text=[NSString stringWithFormat:@"%@%@", combine,combine1];
    }
    NSString*strdown=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"down_payment"];
    if ([strdown isEqualToString:@""]) {
        cell.lbldown.text=@"N/A";
    }
    else{
        cell.lbldown.text=[NSString stringWithFormat:@"$ %@" ,strdown];
    }
    
    NSString*strtrade=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"trade_in_value"];
    if ([strtrade isEqualToString:@""]) {
        cell.lbltrade.text=@"N/A";
    }
    else{
        cell.lbltrade.text=[NSString stringWithFormat:@"$ %@", strtrade ];
    }
    NSString*strdiscription=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"description"];
        if ([strdiscription isEqualToString:@""]) {
        cell.lbltext.text=@"N/A";
    }
    else{
        cell.lbltext.text=strdiscription;
    }
    
    if ([cell.lbltext.text length]<=126) {
        cell.btnviewmore.hidden=YES;
    }
    else{
        cell.btnviewmore.hidden=NO;
    }
    
     NSString*strsecond=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"price"];
    if ([strsecond isEqualToString:@""]) {
        cell.lblsecondamount.text=@"$N/A";
    }
    else{
        cell.lblsecondamount.text=[NSString stringWithFormat:@"$%@",strsecond];
    }
    
    
     NSString*strdealer=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"first_name"];
    if ([strdealer isEqualToString:@""]) {
        cell.lbldealername.text=@"N/A";
    }
    else{
        cell.lbldealername.text=strdealer;
    }

    cell.btnshare.layer.cornerRadius=5.0f;
    cell.btnshare.layer.borderWidth=1.0f;
    cell.btnshare.layer.backgroundColor=[RGB(239, 239, 244)CGColor];
    cell.btnshare.backgroundColor=[UIColor whiteColor];
    [cell.btnshare addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.btntestdrive.layer.cornerRadius=5.0f;
    cell.btntestdrive.layer.borderWidth=1.0f;
    cell.btntestdrive.layer.backgroundColor=[RGB(239, 239, 244)CGColor];
    cell.btntestdrive.backgroundColor=[UIColor whiteColor];
    [cell.btntestdrive addTarget:self action:@selector(testdriveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
   
    cell.btnsend.layer.cornerRadius=5.0f;
    cell.btnsend.layer.borderWidth=1.0f;
    cell.btnsend.layer.backgroundColor=[RGB(239, 239, 244)CGColor];
    cell.btnsend.backgroundColor=[UIColor whiteColor];
    [cell.btnsend addTarget:self action:@selector(sendsimlarBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.btncontact.layer.cornerRadius=5.0f;
    cell.btncontact.layer.borderWidth=1.0f;
    cell.btncontact.layer.backgroundColor=[RGB(239, 239, 244)CGColor];
    cell.btncontact.backgroundColor=[UIColor whiteColor];
    [cell.btncontact addTarget:self action:@selector(contactBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btndelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnviewmore addTarget:self action:@selector(viewmoreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString*strname=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"dealership_name"];
    cell.lblname.text=[NSString stringWithFormat:@"@%@",strname];
    
    NSString*strrating=[[detailarray objectAtIndex:indexPath.row]valueForKey:@"rating"];
    int value = [strrating intValue];
    cell.ratingView .value = value;
    
    
    NSString*strexpired=[[[detailarray objectAtIndex:indexPath.row]valueForKey:@"deal_expire"]stringValue];
    NSString*testdrivevalue=[[[detailarray objectAtIndex:indexPath.row]valueForKey:@"test_drive_status"]stringValue];
    if ([strexpired isEqualToString:@"0"]) {
        cell.expiredview.hidden=YES;
        cell.btnshare.enabled=YES;
        cell.btntestdrive.enabled=YES;
        cell.btnsend.enabled=YES;
        cell.btncontact.enabled=YES;
        if ([testdrivevalue isEqualToString:@"4"]) {
            cell.btntestdrive.backgroundColor=[UIColor whiteColor];
        }
        if ([testdrivevalue isEqualToString:@"0"]) {
            cell.btntestdrive.backgroundColor=[UIColor whiteColor];
            // cell.btntestdrive.enabled=YES;
        }
        if ([testdrivevalue isEqualToString:@"1"]) {
            cell.btntestdrive.backgroundColor=RGB(229, 255, 204);
            cell.btntestdrive.enabled=NO;
        }
        if ([testdrivevalue isEqualToString:@"2"]){
            cell.btntestdrive.backgroundColor=[UIColor purpleColor];
            cell.btntestdrive.enabled=YES;
        }

    }
    else{
        cell.expiredview.hidden=NO;
        cell.btnshare.enabled=NO;
        cell.btntestdrive.enabled=NO;
        cell.btnsend.enabled=YES;
        cell.btncontact.enabled=YES;
    }
    
       
    cell.imgprofileimage.layer.cornerRadius =  cell.imgprofileimage.frame.size.width / 2;
    cell.imgprofileimage.layer.borderWidth = 2;
    cell.imgprofileimage.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    cell.imgprofileimage.clipsToBounds = YES;
    
    
    NSString*imagestr = [[detailarray objectAtIndex:indexPath.row ]valueForKey:@"profile_picture"];
    NSURL *urlimage=[NSURL URLWithString:imagestr];
    if ([imagestr isEqualToString:@""]) {
        cell.imgprofileimage.image = [UIImage imageNamed:@"no-image"];
        
    } else {
        
        [cell.imgprofileimage hnk_setImageFromURL:urlimage];
    }
    /////////////////
    carpicarray = [[detailarray objectAtIndex:indexPath.row ]valueForKey:@"car_pic"];
    if (carpicarray == nil || [carpicarray isEqual:[NSNull null]]) {
        
    } else {
    
        [cell.favroiteview setPagingEnabled:YES];
        [cell.favroiteview setAlwaysBounceVertical:NO];
        
        for (int i = 0; i < [carpicarray count]; i++)
        {
            CGFloat xOrigin = i * cell.favroiteview.frame.size.width;
            
           imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, cell.favroiteview.frame.size.width, cell.favroiteview.frame.size.height)];
            commannewstr= [carpicarray objectAtIndex:i];
            NSString*url=[NSString stringWithFormat:@"%@",commannewstr];
            imageView.clipsToBounds=YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                         placeholderImage:[UIImage imageNamed:@""]];
            [cell.favroiteview addSubview:imageView];
        }
        
        [cell.favroiteview setContentSize:CGSizeMake(cell.favroiteview.frame.size.width * [carpicarray count], cell.favroiteview.frame.size.height)];
    
    }

    return cell;
}


-(void)viewmoreBtnPressed:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    viewmore=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"description"];
    featurearray = [[detailarray objectAtIndex:myindexPath.row] valueForKey:@"features"];
    if([featurearray isKindOfClass:[NSNull class]]) {
        [[AppManager sharedManager] removeLoadingWindow];
        // return ;
    }
    else{
        NSMutableString *featurestring = [[NSMutableString alloc]init];
        for (NSString *str in featurearray){
            [featurestring appendString:str];
            [featurestring appendString:@","];
        }
        [[NSUserDefaults standardUserDefaults]setObject:featurestring forKey:@"strfeat"];
    }

    [[NSUserDefaults standardUserDefaults]setObject:viewmore forKey:@"strdis"];
    
     [self performSegueWithIdentifier:@"pushdiscription" sender:nil];
   
   
    
}


//////////
-(void)deleteBtnPressed:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    detailstr=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"dealer_id"];
    strratingid=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"rating_id"];
    [[NSUserDefaults standardUserDefaults] setObject:detailstr forKey:@"savecar"];
    [[NSUserDefaults standardUserDefaults] setObject:strratingid forKey:@"rateid"];
    
    [self deletefavoritesdetail];
}
/////////
-(void)shareBtnPressed:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    NSIndexPath *myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [mySLComposerSheet setInitialText:@"Prep Car"];
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    NSLog(@"Hello Fb");
}
////////
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
//    NSLog(@"touches began");
//    UITouch *touch = [touches anyObject];
//    if(touch.view!=hmPopUp){
//        hmPopUp.hidden = YES;
//    }
//}
/////////
-(void)testdriveBtnPressed:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    viewdatetime.hidden=NO;
    txttime.text=@"";
    txtdate.text=@"";
    
    strdealerid=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"dealer_id"];
    strdealid=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"deal_id"];
    carid=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"carplan_id"];
    ;
    [[NSUserDefaults standardUserDefaults]setObject:strdealerid forKey:@"strdeal"];
    [[NSUserDefaults standardUserDefaults]setObject:strdealid forKey:@"deal"];
    [[NSUserDefaults standardUserDefaults]setObject:strcarid forKey:@"strcar"];
    
    
    NSString*strmake=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"make"];
    
    NSString*stryear=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"model_year"];
    NSString*strmodel=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"model_type"];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: stryear,strmake,strmodel, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    lblcardetail.text=[NSString stringWithFormat:@"%@",trimmedString];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [[[window subviews] objectAtIndex:0] addSubview:viewdatetime];
    [UIView animateWithDuration:0.3/1.5 animations:^{
        viewdatetime.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            viewdatetime.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                viewdatetime.transform = CGAffineTransformIdentity;
            }];
        }];
    }];

    
}
/////////
-(void)sendsimlarBtnPressed:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    
    simler=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"dealer_id"];
    strsimler=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"car_id"];
    [[NSUserDefaults standardUserDefaults]setObject:simler forKey:@"simlerdeal"];
    [[NSUserDefaults standardUserDefaults]setObject:strsimler forKey:@"simlercar"];

    
    caridnew=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"carplan_id"];
    [[NSUserDefaults standardUserDefaults]setObject:caridnew forKey:@"car"];

    NSString*strmake=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"make"];
    
    NSString*stryear=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"model_year"];
    NSString*strmodel=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"model_type"];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: stryear,strmake,strmodel, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    
    NSString*strnew=@"Send more cars like this";
   NSString *combined = [NSString stringWithFormat:@"%@\n%@", strnew, trimmedString];
    viewcomment.hidden=NO;
    textcomment.text=[NSString stringWithFormat:@"%@",combined];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [[[window subviews] objectAtIndex:0] addSubview:viewcomment];
    [UIView animateWithDuration:0.3/1.5 animations:^{
        viewcomment.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            viewcomment.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                viewcomment.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    NSLog(@"touches began");
        viewcomment.hidden = YES;
      [textcomment resignFirstResponder];
    
}


/////////
-(void)contactBtnPressed:(id)sender{

    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.detailtbl];
    myindexPath = [self.detailtbl indexPathForRowAtPoint:buttonPosition];
    strphone=[[detailarray objectAtIndex:myindexPath.row]valueForKey:@"phone"];
    viewcall.hidden=NO;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [[[window subviews] objectAtIndex:0] addSubview:viewcall];
    [UIView animateWithDuration:0.3/1.5 animations:^{
        viewcall.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            viewcall.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                viewcall.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)callmethod:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",strphone];
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:phoneURL];
    });
 
}

-(IBAction)cancelmethod:(id)sender{
   viewcomment.hidden=YES;
}
-(IBAction)okmethod:(id)sender{
  [self sendsimlardetail];
    
}

-(IBAction)canceltimemethod:(id)sender{
    viewdatetime.hidden=YES;
}

-(IBAction)oktimemethod:(id)sender{
    [self testdrivetdetail];
}

-(IBAction)crossmethod:(id)sender{
   viewcall.hidden=YES;
}
-(IBAction)smsmethod:(id)sender{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"";
        controller.recipients = [NSArray arrayWithObjects:strphone, nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
        
    }
}

-(void)favoritesdetail{
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
    NSString *strUrl=[NSString stringWithFormat:@"%@favorites",kURl];
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
            detailarray=[responseArray valueForKey:@"data"];
            showcarpic = [detailarray valueForKey:@"car_pic"];
            if (showcarpic == nil || [showcarpic count] == 0) {
                [[AppManager sharedManager] removeLoadingWindow];
                
            }
            [_detailtbl reloadData];
            
            NSLog(@"%@",detailarray);
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });

            
        }
        else {
            //[detailarray  removeAllObjects];
           // [_detailtbl reloadData];
            
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}

-(void)deletefavoritesdetail{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *rate=[[NSUserDefaults standardUserDefaults] objectForKey:@"rateid"];
    
    detailstr=[[NSUserDefaults standardUserDefaults]objectForKey:@"savecar"];
    NSString*video_stri=[NSString stringWithFormat:@"%@",detailstr];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",video_stri,@"dealer_id",rate,@"rating_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@deletefavorite?",kURl];
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
            NSMutableArray*array=[responseArray valueForKey:@"data"];
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            NSLog(@"%@",array);
            [detailarray removeObjectAtIndex:myindexPath.row];
            [_detailtbl reloadData];
             //[self favoritesdetail];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
            
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

////////////////CONTACTAPI
-(void)testdrivetdetail{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *dealerid=[[NSUserDefaults standardUserDefaults] objectForKey:@"strdeal"];
    //NSString *carid=[[NSUserDefaults standardUserDefaults] objectForKey:@"strcar"];
     NSString *caridone=[[NSUserDefaults standardUserDefaults] objectForKey:@"idcar"];
     NSString *car=[[NSUserDefaults standardUserDefaults] objectForKey:@"deal"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",dealerid,@"dealer_id",car,@"deal_id",txtdate.text,@"date",txttime.text,@"time",caridone,@"carplan_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@testdrive",kURl];
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
    
            viewdatetime.hidden=YES;
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            NSLog(@"%@",detailarray);
            
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

///////////sendsimilar
-(void)sendsimlardetail{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *dealerid=[[NSUserDefaults standardUserDefaults] objectForKey:@"simlerdeal"];
    NSString *carid=[[NSUserDefaults standardUserDefaults] objectForKey:@"simlercar"];
    NSString *caridone=[[NSUserDefaults standardUserDefaults] objectForKey:@"car"];
    NSString*strtype=@"2";
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"buyer_id",carid,@"car_id",dealerid,@"dealer_id",strtype,@"type",textcomment.text,@"message",caridone,@"carplan_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@messages",kURl];
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
        if ([[[responseArray valueForKey:@"dataflow"] description] isEqualToString:@"1"]) {
            viewcomment.hidden=YES;
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            
        }
        else {
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            viewcomment.hidden=YES;
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


////////popdelegate

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
