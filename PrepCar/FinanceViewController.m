//
//  FinanceViewController.m
//  PrepCar
//
//  Created by Devendra on 1/5/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "FinanceViewController.h"
#import "TabbarViewController.h"

@interface FinanceViewController ()<kDropDownListViewDelegate>

@end

@implementation FinanceViewController
@synthesize finance;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"FINANCES";
    _cridetscore.minimumValue = 350;
    _cridetscore.maximumValue = 850;
    _downpayment.minimumValue = 0;
    _downpayment.maximumValue = 20000;
    
    choose.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    budget.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);

    ////////////////////////
    rentCar=@"yes";
    mortgageCar=@"yes";
    loanCar=@"yes";
    financeCar=@"yes";
    [[AppManager sharedManager] changeTextFieldDesign:income Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:amount Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:studentamount Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtrent Image:[UIImage imageNamed:@"user-email"]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:76/255.0f green:144/255.0f blue:208/255.0f alpha:1.0f];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    
    paymentarray=[[NSMutableArray alloc]initWithObjects:@"Under $200",@"Under $300",@"Under $400",@"Under $500",@"Under $700",@"Under $1000",@"Under $1500",@"No max", nil];
    budgetarray=[[NSMutableArray alloc]initWithObjects:@"Under $5k",@"Under $10k",@"Under $15k",@"Under $20k",@"Under $25k",@"Under $30k",@"Under $35k",@"Under $50k",@"Under $75k",@"Under $75k",@"No max",nil];
    
    [self financenewcardetail];
    
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
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:76/255.0f green:144/255.0f blue:208/255.0f alpha:1.0f];
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    Scroller2.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+550);
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)creditsliderValueChanged:(UISlider*)sender
{
    int value1 = (int)[self.cridetscore value];
    int stepSize1 = 5;
    value1 = (value1 - value1 % stepSize1);
    // Set the new value.
    //self.downpayment = value; // Rounds float to an integer
    sliderstr=[NSString stringWithFormat:@"%d",value1];
    cridetlbl.text = [NSString stringWithFormat:@"%@",sliderstr];
    
    
   // int discreteValue = roundl([sender value]); // Rounds float to an integer
//    sliderstr =[NSString stringWithFormat:@"%d",discreteValue];
//    cridetlbl.text = [NSString stringWithFormat:@"%@",sliderstr];
}

- (IBAction)downpaymentsliderValueChanged:(UISlider*)sender
{
    //int discreteValue = roundl([sender value]);
    int value = (int)[self.downpayment value];
    int stepSize = 500;
    value = (value - value % stepSize);
    // Set the new value.
    //self.downpayment = value; // Rounds float to an integer
    sliderstr1=[NSString stringWithFormat:@"%d",value];
    downlbl.text = [NSString stringWithFormat:@"%@",sliderstr1];
}


/////////////////////yes no button condition
-(IBAction)rent:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        txtrent.enabled = YES;
        rentyes.backgroundColor= RGB(34, 141, 206);
        rentno.backgroundColor=[UIColor whiteColor];
        rentCar=@"yes";
    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        txtrent.enabled = NO;
        txtrent.text = @"";
        rentyes.backgroundColor=[UIColor whiteColor];
        rentno.backgroundColor = RGB(34, 141, 206);
        rentCar=@"no";
    }
    
    
}

-(IBAction)finance:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        financeyes.backgroundColor= RGB(34, 141, 206);
        financeno.backgroundColor=[UIColor whiteColor];
        financeCar=@"yes";
        //////////////
        income.enabled=YES;
        txtrent.enabled=YES;
        amount.enabled=YES;
        studentamount.enabled=YES;
        rentyes.enabled=YES;
        rentno.enabled=YES;
        mortgageyes.enabled=YES;
        mortgageno.enabled=YES;
        loansyes.enabled=YES;
        loansno.enabled=YES;
        self.cridetscore.enabled=YES;
        self.downpayment.enabled=YES;
        payment.enabled=YES;
        choose.enabled=YES;
        budget.enabled=YES;
        btncalculate.enabled=YES;

    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        financeyes.backgroundColor=[UIColor whiteColor];
        financeno.backgroundColor = RGB(34, 141, 206);
        financeCar=@"no";
        ////////
        income.enabled=NO;
        txtrent.enabled=NO;
        amount.enabled=NO;
        studentamount.enabled=NO;
        rentyes.enabled=NO;
        rentno.enabled=NO;
        mortgageyes.enabled=NO;
        mortgageno.enabled=NO;
        loansyes.enabled=NO;
        loansno.enabled=NO;
        self.cridetscore.enabled=NO;
        self.downpayment.enabled=NO;
        payment.enabled=NO;
        choose.enabled=NO;
        budget.enabled=YES;
        btncalculate.enabled=NO;
    }
    
    
}


-(IBAction)mortgage:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        amount.enabled = YES;
        mortgageyes.backgroundColor= RGB(34, 141, 206);
        mortgageno.backgroundColor=[UIColor whiteColor];
        mortgageCar=@"yes";
    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        amount.enabled = NO;
        amount.text = @"";
        mortgageyes.backgroundColor=[UIColor whiteColor];
        mortgageno.backgroundColor = RGB(34, 141, 206);
        mortgageCar=@"no";
    }
    
    
}

-(IBAction)studentloan:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        studentamount.enabled = YES;
        loansyes.backgroundColor= RGB(34, 141, 206);
        loansno.backgroundColor=[UIColor whiteColor];
        loanCar=@"yes";
    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        studentamount.enabled = NO;
        studentamount.text = @"";
        loansyes.backgroundColor=[UIColor whiteColor];
        loansno.backgroundColor = RGB(34, 141, 206);
        loanCar=@"no";
    }
    
    
}


-(IBAction)paymentBtnPressed:(id)sender{
    NSString*incomestr=income.text;
    double myDouble = [incomestr doubleValue];
    NSString*rentstr=txtrent.text;
    double myDouble1 = [rentstr doubleValue];
    NSString*amountstr=amount.text;
    double myDouble2 = [amountstr doubleValue];
    NSString*studentstr=studentamount.text;
    double myDouble3 = [studentstr doubleValue];
    
    int my = (int)(myDouble-myDouble1-myDouble2-myDouble3)*15/100;
    NSString*strvalue=[NSString stringWithFormat:@"%d",my];
    [payment setTitle:strvalue forState:UIControlStateNormal];
    
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:76.0 G:144.0 B:208.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
    if ([finance isEqualToString:@"main"]) {
        NSString*single=[paymentarray objectAtIndex:anIndex];
        NSString*space=[NSString stringWithFormat:@"%@",single];
        [choose setTitle:space forState:UIControlStateNormal];
    }
    else{
        NSString*single1=[budgetarray objectAtIndex:anIndex];
        NSString*space1=[NSString stringWithFormat:@"%@",single1];
        [budget setTitle:space1 forState:UIControlStateNormal];
    }
    
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


-(IBAction)chooseBtnPressed:(id)sender{
    
    finance=@"main";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CHOOSE YOUR OWN" withOption:paymentarray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 280) isMultiple:NO];
}

-(IBAction)budgetBtnPressed:(id)sender{
    finance=@"name";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"BUDGET" withOption: budgetarray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 410) isMultiple:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)financenewcardetail{
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
    NSString *strUrl=[NSString stringWithFormat:@"%@finances",kURl];
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
            
            income.text=[responseArray valueForKey:@"estmonthlyincome"];
            txtrent.text=[responseArray valueForKey:@"rent_amount"];
            amount.text=[responseArray valueForKey:@"amount1"];
            studentamount.text=[responseArray valueForKey:@"amount2"];
            //date.text=[responseArray valueForKey:@"dob"];
            NSString*ownstr=[responseArray valueForKey:@"chooseyourown"];
            NSString*strchoose=[NSString stringWithFormat:@"%@",ownstr];
            if ([ownstr isKindOfClass:[NSNull class]])
                [choose setTitle:@"" forState:UIControlStateNormal];
            else{
                [choose setTitle:strchoose forState:UIControlStateNormal];
            }
            
            NSString*budstr=[responseArray valueForKey:@"budget"];
            NSString*bud=[NSString stringWithFormat:@"%@",budstr];
            [budget setTitle:bud forState:UIControlStateNormal];
            
            NSString*cridtstr = [responseArray valueForKey:@"estcreditscore"];
            cridetlbl.text=[ NSString stringWithFormat:@"%@", cridtstr];
            self.cridetscore.value = cridtstr.floatValue;
            
            NSString*downstr = [responseArray valueForKey:@"down_payment"];
            downlbl.text=[ NSString stringWithFormat:@"%@", downstr];
            self.downpayment.value = downstr.floatValue;
            
            NSString* financestr = [responseArray valueForKey:@"do_you_need_finance"];
            if ([financestr isEqualToString:@"yes"]) {
                [self finance:financeyes];
                NSString* rentstr = [responseArray valueForKey:@"rent"];
                if ([rentstr  isEqualToString:@"yes"]) {
                    [self rent:rentyes];
                }
                else{
                    [self rent:rentno];
                    
                }
                
                NSString* mortgagestr = [responseArray valueForKey:@"mortgage"];
                if ([mortgagestr isEqualToString:@"yes"]) {
                    [self mortgage:mortgageyes];
                }
                else{
                    [self mortgage:mortgageno];
                    
                    
                }
                
                NSString* studentstr = [responseArray valueForKey:@"studentloans"];
                if (studentstr == nil || [studentstr isEqual:[NSNull null]]) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return ;
                    
                } else {
                    if ([studentstr  isEqualToString:@"yes"]) {
                        [self studentloan:loansyes];
                    }
                    else{
                        [self studentloan:loansno];
                        
                    }
                    
                }
            }
            else{
                [self finance:financeno];
                [self rent:rentno];
                [self mortgage:mortgageno];
                [self studentloan:loansno];

            }
            
            

            [[AppManager sharedManager] removeLoadingWindow];
            ///[self performSegueWithIdentifier:@"go2" sender:nil];
            
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
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






- (IBAction)uploadthenewcar:(id)sender {
    [self.view endEditing:YES];
    [self financenewcar];
}

-(void)financenewcar{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:income.text,@"est_monthly_income",rentCar,@"rent",mortgageCar,@"mortgage",amount.text,@"amount1",loanCar,@"student_loans",studentamount.text,@"amount2",user,@"buyer_id",sliderstr,@"est_credit_score",payment.titleLabel.text,@"suggested_monthly_payment",choose.titleLabel.text,@"choose_your_own",budget.titleLabel.text,@"budget",sliderstr1,@"down_payment",financeCar,@"do_you_need_finance",txtrent.text,@"rent_amount",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@finances",kURl];
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
            [self performSegueWithIdentifier:@"go2" sender:nil];
            
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
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

@end
