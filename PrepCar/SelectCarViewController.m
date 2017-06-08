//
//  SelectCarViewController.m
//  PrepCar
//
//  Created by Devendra on 1/11/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "SelectCarViewController.h"
#import "UploadcarViewController.h"
#import "TabViewController.h"

@interface SelectCarViewController ()<kDropDownListViewDelegate>

@end

@implementation SelectCarViewController
{
    NSMutableArray *ary_jointArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ary_jointArray =[[NSMutableArray alloc]init];
    self.navigationItem.title=@"SELECT CAR";
    DesriptionText.layer.borderWidth = 2;
    DesriptionText.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    //_switchon.onImage = [UIImage imageNamed:@"on_button"];
    selectbtn.layer.cornerRadius=3.0f;
    selectbtn.layer.borderWidth=1.0f;
    selectbtn.layer.borderColor=[UIColor grayColor].CGColor;
    ////////////
    Btnmonth1.layer.cornerRadius=5.0f;
    Btnmonth1.layer.borderWidth=1.0f;
    Btnmonth1.layer.borderColor=[UIColor grayColor].CGColor;
    //////////
    Btnmonth2.layer.cornerRadius=5.0f;
    Btnmonth2.layer.borderWidth=1.0f;
    Btnmonth2.layer.borderColor=[UIColor grayColor].CGColor;
     //////////////
    Btnmonth3.layer.cornerRadius=5.0f;
    Btnmonth3.layer.borderWidth=1.0f;
    Btnmonth3.layer.borderColor=[UIColor grayColor].CGColor;
    //////////////
    Btnmonth4.layer.cornerRadius=5.0f;
    Btnmonth4.layer.borderWidth=1.0f;
    Btnmonth4.layer.borderColor=[UIColor grayColor].CGColor;
    //////////
    Btnmonth5.layer.cornerRadius=5.0f;
    Btnmonth5.layer.borderWidth=1.0f;
    Btnmonth5.layer.borderColor=[UIColor grayColor].CGColor;
    /////
    Btnfinanceyes.layer.cornerRadius=3.0f;
    Btnfinanceyes.layer.borderWidth=1.0f;
    Btnfinanceyes.layer.borderColor=[UIColor grayColor].CGColor;
    ////////
    Btnfinanceno.layer.cornerRadius=3.0f;
    Btnfinanceno.layer.borderWidth=1.0f;
    Btnfinanceno.layer.borderColor=[UIColor grayColor].CGColor;
    //////////
   Btntradeyes.layer.cornerRadius=3.0f;
    Btntradeyes.layer.borderWidth=1.0f;
    Btntradeyes.layer.borderColor=[UIColor grayColor].CGColor;
    //////
    Btntradeno.layer.cornerRadius=3.0f;
    Btntradeno.layer.borderWidth=1.0f;
    Btntradeno.layer.borderColor=[UIColor grayColor].CGColor;
    //////
    Btnleaseyes.layer.cornerRadius=3.0f;
    Btnleaseyes.layer.borderWidth=1.0f;
    Btnleaseyes.layer.borderColor=[UIColor grayColor].CGColor;
    ///////
    Btnleaseno.layer.cornerRadius=3.0f;
    Btnleaseno.layer.borderWidth=1.0f;
    Btnleaseno.layer.borderColor=[UIColor grayColor].CGColor;

    
    [[AppManager sharedManager] changeTextFieldDesign:txtterms Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtdisclimer Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtrate Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtprice Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtmonthly Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtdown Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txttrade Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtnickname Image:[UIImage imageNamed:@"user-email"]];
    //[[AppManager sharedManager] changeTextFieldDesign:txtamount Image:[UIImage imageNamed:@"user-email"]];
    Btn.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    txtprice.delegate=self;
    txtdisclimer.delegate=self;
    txtterms.delegate=self;
    txtrate.delegate=self;
    txtmonthly.delegate=self;
    txtdown.delegate=self;
    txttrade.delegate=self;
    //txtamount.delegate=self;
    
    
     UIImage*newimage=[UIImage imageNamed:@"left_arrow"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:newimage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    cararray =[[NSMutableArray alloc]init];
    caridarray=[[NSMutableArray alloc]init];
   
}
-(void)HomeBtnPressed
{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TabViewController class]] ) {
            TabViewController *groupViewController = (TabViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
        }
    }

}

-(IBAction)financemethod:(UIButton*)sender;

{
    if(sender.tag==99)
    {
        Btnfinanceyes.backgroundColor= RGB(41, 58, 146);
        Btnfinanceno.backgroundColor=[UIColor whiteColor];
        Btnmonth1.enabled=YES;
        Btnmonth2.enabled=YES;
        Btnmonth3.enabled=YES;
        Btnmonth4.enabled=YES;
        Btnmonth5.enabled=YES;
        txtmonthly.enabled=YES;
        txtrate.enabled=YES;
        txtdown.enabled=YES;
        
    }
    if (sender.tag==100)
    {
        
        Btnfinanceyes.backgroundColor=[UIColor whiteColor];
        Btnfinanceno.backgroundColor = RGB(41, 58, 146);
        Btnmonth1.enabled=NO;
        Btnmonth2.enabled=NO;
        Btnmonth3.enabled=NO;
        Btnmonth4.enabled=NO;
        Btnmonth5.enabled=NO;
        txtmonthly.enabled=NO;
        txtrate.enabled=NO;
        txtdown.enabled=NO;
        
    }
    
    
}

-(IBAction)trademethod:(UIButton*)sender;

{
    if(sender.tag==101)
    {
       Btntradeyes.backgroundColor= RGB(41, 58, 146);
       Btntradeno.backgroundColor=[UIColor whiteColor];
        txttrade.enabled=YES;
        
    }
    if (sender.tag==102)
    {
        
        Btntradeyes.backgroundColor=[UIColor whiteColor];
        Btntradeno.backgroundColor = RGB(41, 58, 146);
        txttrade.enabled=NO;

        
    }
    
    
}

-(IBAction)leasemethod:(UIButton*)sender;

{
    if(sender.tag==103)
    {
        Btnleaseyes.backgroundColor= RGB(41, 58, 146);
        Btnleaseno.backgroundColor=[UIColor whiteColor];
        txtterms.enabled=YES;
        txtdisclimer.enabled=YES;
        
    }
    if (sender.tag==104)
    {
        
        Btnleaseyes.backgroundColor=[UIColor whiteColor];
        Btnleaseno.backgroundColor = RGB(41, 58, 146);
        txtterms.enabled=NO;
        txtdisclimer.enabled=NO;
        
    }

}


-(void)viewWillAppear:(BOOL)animated

{
     [self cardetailmethod];
}

-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    scroller.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+400);
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

        [DesriptionText resignFirstResponder];
    
    return YES;
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)uploadcarmethod:(id)sender{
    _strunique=@"new";
    [self performSegueWithIdentifier:@"newupload" sender:nil];
    
}

-(IBAction)clickcountbtn:(UIButton*)sender{
    if(sender.tag==991)
    {
        Btnmonth1.backgroundColor=RGB(0, 17, 111);
        Btnmonth2.backgroundColor=[UIColor whiteColor];
        Btnmonth3.backgroundColor=[UIColor whiteColor];
        Btnmonth4.backgroundColor=[UIColor whiteColor];
        Btnmonth5.backgroundColor=[UIColor whiteColor];
        btncount=@"24";
        
    }
    if (sender.tag==992)
    {
        Btnmonth1.backgroundColor=[UIColor whiteColor];
        Btnmonth2.backgroundColor=RGB(0, 17, 111);
        Btnmonth3.backgroundColor=[UIColor whiteColor];
        Btnmonth4.backgroundColor=[UIColor whiteColor];
        Btnmonth5.backgroundColor=[UIColor whiteColor];
        btncount=@"36";
       
    }
    if (sender.tag==993)
    {
        Btnmonth1.backgroundColor=[UIColor whiteColor];
        Btnmonth2.backgroundColor=[UIColor whiteColor];
        Btnmonth3.backgroundColor=RGB(0, 17, 111);
        Btnmonth4.backgroundColor=[UIColor whiteColor];
        Btnmonth5.backgroundColor=[UIColor whiteColor];
        btncount=@"48";
        
    }
    if (sender.tag==994)
    {
        Btnmonth1.backgroundColor=[UIColor whiteColor];
        Btnmonth2.backgroundColor=[UIColor whiteColor];
        Btnmonth3.backgroundColor=[UIColor whiteColor];
        Btnmonth4.backgroundColor=RGB(0, 17, 111);
        Btnmonth5.backgroundColor=[UIColor whiteColor];
        btncount=@"60";
       
        
    }
    
    if (sender.tag==995)
    {
        Btnmonth1.backgroundColor=[UIColor whiteColor];
        Btnmonth2.backgroundColor=[UIColor whiteColor];
        Btnmonth3.backgroundColor=[UIColor whiteColor];
        Btnmonth4.backgroundColor=[UIColor whiteColor];
        Btnmonth5.backgroundColor=RGB(0, 17, 111);
        btncount=@"72";
       
        
    }
}


-(IBAction)carBtnPressed:(id)sender{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CAR LIST" withOption:cararray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 200) isMultiple:NO];
}

-(IBAction)createdealbtn:(id)sender{
    if ([self checkValidation]) {
        [self.view endEditing:YES];
        [self createdealmethod];
        
    }
}

-(void)cardetailmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
   // NSString *buyerID=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userstr,@"dealer_id", nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@car_list",kURl];
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
        int status = [responsedict[@"dataFlow"] intValue];
        NSString *IsStatus = [NSString stringWithFormat:@"%d",status];
        if ([[[responsedict valueForKey:@"status"] description] isEqualToString:@"1"]) {
             NSMutableDictionary*discoverydict=[responsedict valueForKey:@"response"];
                if (status==0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return ;

                }
           
            newarray1=[discoverydict valueForKey:@"make"];
            newarray=[discoverydict valueForKey:@"model_type"];
            newarray2=[discoverydict valueForKey:@"model_year"];
            
            if (newarray1 == nil || [newarray1 count] == 0) {
                [[AppManager sharedManager] removeLoadingWindow];
                return;
            }
            if (ary_jointArray.count>0) {
                [ary_jointArray removeAllObjects];
            }
            for (int i=0; i<newarray1.count; i++){
                NSString*commstr2=[newarray1 objectAtIndex:i];
                NSString*strtitle1=[NSString stringWithFormat:@"%@",commstr2];
                
                NSString*commstr3=[newarray objectAtIndex:i];
                NSString*strtitle2=[NSString stringWithFormat:@"%@",commstr3];
                
                NSString*commstr4=[newarray2 objectAtIndex:i];
                NSString*strtitle3=[NSString stringWithFormat:@"%@",commstr4];
                
                NSString* str_Joinsting=[NSString stringWithFormat:@"%@ %@ %@", strtitle3,strtitle1,strtitle2];
                
                
                NSCharacterSet *doNotWant1 = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                NSString * newReplacedString1 = [[strtitle1 componentsSeparatedByCharactersInSet: doNotWant1] componentsJoinedByString: @""];
                [ary_jointArray addObject:str_Joinsting];
            }
            cararray= [ary_jointArray mutableCopy];
             caridarray =[discoverydict valueForKey:@"car_id"];
            [[AppManager sharedManager] removeLoadingWindow];
            
            
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

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:41.0 G:58.0 B:146.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    NSString*single=[cararray objectAtIndex:anIndex];
    NSString*space=[NSString stringWithFormat:@"%@",single];
    [Btn setTitle:space forState:UIControlStateNormal];
    NSInteger row = anIndex;
    NSString*carstr =[caridarray objectAtIndex:row];
    [[NSUserDefaults standardUserDefaults]setObject:carstr forKey:@"car"];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    if (ArryData.count>0) {
        
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
-(BOOL)checkValidation{
    
    return YES;
}


-(void)createdealmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *vichelid=[[NSUserDefaults standardUserDefaults] objectForKey:@"car"];
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString*userstr=[NSString stringWithFormat:@"%@",user];
    NSString *carplan=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedcar"];
    NSMutableDictionary*postDictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:carplan,@"carplan_id",userstr,@"dealer_id",vichelid,@"vechicle",txtterms.text,@"lease_deal_trems",txtdisclimer.text,@"lease_deal_disclaimer",txtnickname.text,@"nickname",txtprice.text,@"price",DesriptionText.text,@"description",btncount,@"months",txtrate.text,@"interest_rate",txtmonthly.text,@"monthly_payment",txtdown.text,@"down_payment",txttrade.text,@"trade_in_value",  nil];
    
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@create_deal",kURl];
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
            
            NSMutableDictionary*discoverydict=[responsedict valueForKey:@"response"];
            NSString*dealstr=[discoverydict valueForKey:@"deal_id"];
            [[NSUserDefaults standardUserDefaults]setObject:dealstr forKey:@"deal"];
             [[AppManager sharedManager] removeLoadingWindow];
            
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:1.0f];
            
        }
        else {
            //[KSToastView ks_showToast:[responsedict objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        [self performSegueWithIdentifier:@"pushcreate" sender:nil];
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newupload"]) {
        UploadcarViewController *container = (UploadcarViewController *)[segue destinationViewController];
        container.strpast = _strunique;
        
    }
}
@end
