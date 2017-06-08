//
//  DiscoveryViewController.m
//  PrepCar
//
//  Created by Devendra on 12/28/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()<kDropDownListViewDelegate>

@end

@implementation DiscoveryViewController
@synthesize type;



- (void)viewDidLoad {
    [super viewDidLoad];
    selecteddropDownValues = [[NSMutableArray alloc]init];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"DISCOVERY";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    [male setBackgroundImage:[UIImage imageNamed:@"select_male_icon@1x"]forState:UIControlStateNormal];
    [tall setBackgroundImage:[UIImage imageNamed:@"check_boxfil@1x"]forState:UIControlStateNormal];
    discountbtn.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    
    mainusesbtn.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
   note.textContainerInset = UIEdgeInsetsMake(10, 0, 13, 0);
    [self savedetaildiscovery];
     

    //note.text = @"Add a global comment here..";
   // note.textColor = [UIColor lightGrayColor];
    note.delegate =self;
    firstCar=@"yes";
    height=@"4'10-5'3";
    identity=@"male";
    small=@"yes";

     mainarray =[[NSMutableArray alloc]initWithObjects:@"Commute",@"Family",@"City",@"Road trips",@"Extreme weather",@"Lyft/Uber/Rideshare", nil];
    discountarray =[[NSMutableArray alloc]initWithObjects:@"Educator",@"Student",@"Military",@"First responder",@"N/A", nil];
      selectedObjects = [[NSMutableArray alloc]init];
      array=[[NSMutableArray alloc]init];
   }

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
    [self.tabBarController.tabBar setHidden:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    scroller.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+100);
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    note.text = @"";
    note.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(note.text.length == 0){
        note.textColor = [UIColor blackColor];
        note.text = @"Add a comment here..";
        [note resignFirstResponder];
    }
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
    
}


-(IBAction)male:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        caryes.backgroundColor= RGB(41, 58, 146);
        carno.backgroundColor=[UIColor whiteColor];
        firstCar=@"yes";
        
    }
     if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        caryes.backgroundColor=[UIColor whiteColor];
        carno.backgroundColor = RGB(41, 58, 146);
        
        
        firstCar=@"no";
    }
    
    
}

////////////////////////////
-(IBAction)identity:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        [male setBackgroundImage:[UIImage imageNamed:@"select_male_icon@1x"]forState:UIControlStateNormal];
       [Female setBackgroundImage:[UIImage imageNamed:@"female_icon@1x"]forState:UIControlStateNormal];
        
       [other setBackgroundImage:[UIImage imageNamed:@"other@1x"]forState:UIControlStateNormal];
        identity=@"male";
    }
    if (sender.tag==2)
    {
        [male setBackgroundImage:[UIImage imageNamed:@"Male_icon@1x"]forState:UIControlStateNormal];
       [Female setBackgroundImage:[UIImage imageNamed:@"select_female_icon@1x"]forState:UIControlStateNormal];
        [other setBackgroundImage:[UIImage imageNamed:@"other@1x"]forState:UIControlStateNormal];
        identity=@"female";
    }
    
}
///////////////////////////
-(IBAction)height:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        [tall setBackgroundImage:[UIImage imageNamed:@"check_boxfil@1x"]forState:UIControlStateNormal];
        [grande setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        [venti setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        height=@"4'10-5'3";
    }
    if (sender.tag==2)
    {
        [tall setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        [grande setBackgroundImage:[UIImage imageNamed:@"check_boxfil@1x"]forState:UIControlStateNormal];
        [venti setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        height=@"5'4-5'10";
    }
    if (sender.tag==3)
    {
        [tall setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        [grande setBackgroundImage:[UIImage imageNamed:@"check_box@1x"]forState:UIControlStateNormal];
        [venti setBackgroundImage:[UIImage imageNamed:@"check_boxfil@1x"]forState:UIControlStateNormal];
        height=@"5'11-7'+";
    }

}
///////////////////
-(IBAction)smallchildren:(UIButton*)sender;

{
    if(sender.tag==1)
    {
        smallyes.backgroundColor= RGB(41, 58, 146);
        smallno.backgroundColor=[UIColor whiteColor];
        small=@"yes";
    }
    if (sender.tag==2)
    {
        //isFemaleOrMale=@"female";
        smallyes.backgroundColor=[UIColor whiteColor];
        smallno.backgroundColor = RGB(41, 58, 146);
        small=@"no";
    }
    
    
}
-(void)savedetaildiscovery{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    NSString *user1=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user1,@"buyer_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@discovery",kURl];
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
            
         selectedObjects = [responseArray valueForKey:@"mainuse"];
          if([selectedObjects isKindOfClass:[NSNull class]]) {
                [[AppManager sharedManager] removeLoadingWindow];
              // return ;
            }
          else{
            for (int i=0; i<selectedObjects.count; i++){
                NSString*commstr=[selectedObjects objectAtIndex:i];
                NSString*strtitle=[NSString stringWithFormat:@"%@",commstr];
                NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                NSString * newReplacedString = [[strtitle componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
                [mainusesbtn setTitle:newReplacedString forState:UIControlStateNormal];
            }
          }
            NSString*str1 = [responseArray valueForKey:@"discount"];
            [discountbtn setTitle:str1 forState:UIControlStateNormal];
            note.text=[responseArray valueForKey:@"shoppingnotes"];
            
            NSString* maleOrFemale = [responseArray valueForKey:@"identify"];
            if ([[maleOrFemale lowercaseString] isEqualToString:@"male"]) {
                [self identity:male];
            }
            else if ([[maleOrFemale lowercaseString] isEqualToString:@"female"]) {
            [self identity:Female];
            }
            else{
            [self identity:other];
            }
            
            NSString* tallorgrand = [responseArray valueForKey:@"height"];
            if ([[tallorgrand lowercaseString] isEqualToString:@"tall"]) {
                [self height:tall];
            }
             if ([[tallorgrand lowercaseString] isEqualToString:@"grande"]) {
                [self height:grande];
            }
            {
            if ([[tallorgrand lowercaseString] isEqualToString:@"venti"])
                [self height:venti];
            }
        
            NSString* first = [responseArray valueForKey:@"firstcar"];
            if ([[first lowercaseString] isEqualToString:@"yes"]) {
                [self male:caryes];
            }
            else{
                [self male:carno];

            }
            
            NSString* smallstr = [responseArray valueForKey:@"smallchildren"];
            if ([[smallstr lowercaseString] isEqualToString:@"yes"]) {
                 [self smallchildren:smallyes];
            }
            else{
                 [self smallchildren:smallno];
                
            }
        
            
            //NSLog(@"%@",arrayDetail);
            [[AppManager sharedManager] removeLoadingWindow];
            //[self performSegueWithIdentifier:@"go1" sender:nil];
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


-(IBAction)submitbtn:(UIButton*)sender;
{
        [self.view endEditing:YES];
        [self savedetail];
        
    }

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj  =[[DropDownListView alloc]initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple andselected:selecteddropDownValues];
    
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:41.0 G:58.0 B:146.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    NSString*single=[discountarray objectAtIndex:anIndex];
    NSString*space=[NSString stringWithFormat:@"%@",single];
    [discountbtn setTitle:space forState:UIControlStateNormal];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
        if (ArryData.count>0) {
        
        for (int i=0; i<ArryData.count; i++) {
            //NSString*str=[ArryData objectAtIndex:i];
            strdata= [ArryData componentsJoinedByString:@", "];
        }
         [mainusesbtn setTitle:strdata forState:UIControlStateNormal];
         [array addObject:strdata];
          selectedObjects = [array mutableCopy];
        
        
        }
    
    else{
        _lblSelectedCountryNames.text=@"";
    }
}

-(void)dropDown:(DropDownListView *)dropdownListView SelectedIndexPaths:(NSArray *)selectedindexpaths

{
    if (selecteddropDownValues.count>0) {
        [selecteddropDownValues removeAllObjects];
    }
    selecteddropDownValues = [selectedindexpaths mutableCopy];

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

-(IBAction)smallusesbutton:(UIButton*)sender;
{

    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"MAIN USES" withOption:mainarray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 200) isMultiple:YES];
}

-(IBAction)discountbutton:(UIButton*)sender;
{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"DISCOUNTS" withOption:discountarray xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 200) isMultiple:NO];
}

-(void)savedetail{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSData *jsonDatacomment = [NSJSONSerialization dataWithJSONObject:selectedObjects options:0 error:nil];
    selectstr= [[NSString alloc] initWithData:jsonDatacomment encoding:NSUTF8StringEncoding];
    NSString *user1=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user1,@"buyer_id",identity,@"identify",firstCar,@"first_car",selectstr,@"main_use",height,@"height",small,@"small_children",discountbtn.titleLabel.text,@"discount",note.text,@"shopping_notes", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@discovery",kURl];
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
             //NSLog(@"%@",arrayDetail);
            [[AppManager sharedManager] removeLoadingWindow];
            [self performSegueWithIdentifier:@"go1" sender:nil];

            
            
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
