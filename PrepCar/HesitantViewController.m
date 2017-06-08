//
//  HesitantViewController.m
//  PrepCar
//
//  Created by Devendra on 1/7/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "HesitantViewController.h"
#import "TabbarViewController.h"

@interface HesitantViewController ()<TTRangeSliderDelegate,kDropDownListViewDelegate>
@property (weak, nonatomic) IBOutlet TTRangeSlider *rangeSlider;

@end

@implementation HesitantViewController
@synthesize hasitent;

- (void)viewDidLoad {
     [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:NO];
    selectedmainValues= [[NSMutableArray alloc]init];
     
     selectednameValues= [[NSMutableArray alloc]init];
     
    selectedotherValues= [[NSMutableArray alloc]init];
     selectedprefienceValues= [[NSMutableArray alloc]init];
     selectedcolorValues = [[NSMutableArray alloc]init];
     self.navigationItem.title = @"I'M HESITANT";
     NSDictionary *titleAttributes =@{
                                      NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                      };
     self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
     UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
     UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
     [homebtn setTintColor:[UIColor whiteColor]];
     self.navigationItem.rightBarButtonItem = homebtn;
     tempArray=[[NSArray alloc] initWithObjects:@"new",@"certified",@"prefiance",@"lease",@"anithing", nil];
     newTempArray=[[NSMutableArray alloc] init];
     
     tempArraydetail=[[NSArray alloc] initWithObjects:@"ecomamy",@"suv",@"sedan",@"convertable",@"coupe",@"lauxary",@"seat",@"hatch",@"speed",@"van",@"truck",@"electirc",@"driving",@"hybrid", nil];
     newTempArraydeatil=[[NSMutableArray alloc]init];
     selectasia=[[NSMutableArray alloc]init];
     selectamerica=[[NSMutableArray alloc]init];
     selecteurope=[[NSMutableArray alloc]init];
     selectcolor=[[NSMutableArray alloc]init];
     selectprefrience=[[NSMutableArray alloc]init];
     
     self.rangeSlider.delegate = self;
     self.rangeSlider.minValue = 1990;
     self.rangeSlider.maxValue = 2017;
     self.rangeSlider.selectedMinimum = 1990;
     self.rangeSlider.selectedMaximum = 2017;
     btncolor.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btntransmission.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btnpower.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btnseats.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btnamerican.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btnasian.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
     btneurope.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);

     
     //     self.range.minimumValue = 1990;
     //     self.range.maximumValue = 2017;
     
     type=@"new";
     style=@"ecenomy";
     mileage=@"new";
     arraycolor=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
     arraytrasmission=[[NSMutableArray alloc]initWithObjects:@"Automatic",@"Manual",nil];
     
     
     arrayperifance=[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat",nil];
     
     arrayamerica=[[NSMutableArray alloc]initWithObjects:@"Ford",@"Chevrolet",@"Lincoln",@"Tesla",@"Cadillac",@"Buick",@"Chrysler",@"Dodge",@"Jeep",@"GMC",@"None", nil];
     
     arrayasia=[[NSMutableArray alloc]initWithObjects:@"Toyota",@"Acura",@"Nissan",@"Suzuki",@"Honda",@"Hyundai",@"INFINITI",@"Mitsubishi",@"Subaru",@"Mazda",@"Kia",@"None",nil];
     
     arrayeurope=[[NSMutableArray alloc]initWithObjects:@"BMW",@"Audi",@"Fiat",@"Volvo",@"Volkswagen",@"Mercedes",@"Jaguar",@"MINI",@"None", nil];
     
     [self savecardetail];
     
}

-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:114/255.0f green:195/255.0f blue:106/255.0f alpha:1.0f];
}

-(void) viewDidLayoutSubviews; {
     super.viewDidLayoutSubviews;
     Scroller3.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+580);
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
-(IBAction)backBtnPressed:(id)sender{
     [self.navigationController popViewControllerAnimated:YES];
     
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
     
     [textField resignFirstResponder];
     return YES;
}

//- (IBAction)yearrangeChanged:(UISlider*)sender
//{
//     int discreteValue = roundl([sender value]); // Rounds float to an integer
//     rangestr=[NSString stringWithFormat:@"%d",discreteValue];
//     lblrange.text = [NSString stringWithFormat:@"%@",rangestr];
//}


-(IBAction)radiobuttonSelected:(UIButton*)sender;

{
     for (id obj in Scroller3.subviews) {
          UIButton *view=(UIButton*)obj;
          if ((view.tag==sender.tag) && sender.tag<=5) {
               [view setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
               break;
          }
          else if ((view.tag==sender.tag) && sender.tag>101) {
               [view setBackgroundImage:[UIImage imageNamed:@"check_box_2@1x"]forState:UIControlStateNormal];
               break;
          }
     }
     
     if (sender.tag==1) {
          sender.tag=101;
     }
     else if (sender.tag==101){
          sender.tag=1;
     }
     
     if (sender.tag==2) {
          sender.tag=102;
     }
     else if (sender.tag==102){
          sender.tag=2;
     }
     
     if (sender.tag==3) {
          sender.tag=103;
     }
     else if (sender.tag==103){
          sender.tag=3;
     }
     
     if (sender.tag==4) {
          sender.tag=104;
     }
     else if (sender.tag==104){
          sender.tag=4;
     }
     
     if (sender.tag==5) {
          sender.tag=105;
     }
     else if (sender.tag==105){
          sender.tag=5;
     }
     
     if (sender.tag<=5) {
          if ([newTempArray containsObject:[NSString stringWithFormat:@"%ld",sender.tag]]) {
               [newTempArray removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
          }
          else{
               [newTempArray addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
          }
     }
     else{
          if ([newTempArray containsObject:[NSString stringWithFormat:@"%ld",sender.tag-101]]) {
               [newTempArray removeObject:[NSString stringWithFormat:@"%ld",sender.tag-101]];
          }
          else{
               [newTempArray addObject:[NSString stringWithFormat:@"%ld",sender.tag-101]];
          }
          
     }
     
}

///////////////

-(IBAction)radiobutton:(UIButton*)sender;

{
     for (id obj in Scroller3.subviews) {
          UIButton *view=(UIButton*)obj;
          if ((view.tag==sender.tag) && sender.tag<=20) {
               [view setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
               break;
          }
          else if ((view.tag==sender.tag) && sender.tag>106) {
               [view setBackgroundImage:[UIImage imageNamed:@"check_box_2@1x"]forState:UIControlStateNormal];
               break;
          }
     }
     
     if (sender.tag==7) {
          sender.tag=107;
     }
     else if (sender.tag==107){
          sender.tag=7;
     }
     
     if (sender.tag==8) {
          sender.tag=108;
     }
     else if (sender.tag==108){
          sender.tag=8;
     }
     
     if (sender.tag==9) {
          sender.tag=109;
     }
     else if (sender.tag==109){
          sender.tag=9;
     }
     
     if (sender.tag==10) {
          sender.tag=110;
     }
     else if (sender.tag==110){
          sender.tag=10;
     }
     
     if (sender.tag==11) {
          sender.tag=111;
     }
     else if (sender.tag==111){
          sender.tag=11;
     }
     
     if (sender.tag==12) {
          sender.tag=112;
     }
     else if (sender.tag==112){
          sender.tag=12;
     }
     
     if (sender.tag==13) {
          sender.tag=113;
     }
     else if (sender.tag==113){
          sender.tag=13;
     }
     
     if (sender.tag==14) {
          sender.tag=114;
     }
     else if (sender.tag==114){
          sender.tag=14;
     }
     
     if (sender.tag==15) {
          sender.tag=115;
     }
     else if (sender.tag==115){
          sender.tag=15;
     }
     
     if (sender.tag==16) {
          sender.tag=116;
     }
     else if (sender.tag==116){
          sender.tag=16;
     }
     
     if (sender.tag==17) {
          sender.tag=117;
     }
     else if (sender.tag==117){
          sender.tag=17;
     }
     
     if (sender.tag==18) {
          sender.tag=118;
     }
     else if (sender.tag==118){
          sender.tag=18;
     }
     
     if (sender.tag==19) {
          sender.tag=119;
     }
     else if (sender.tag==119){
          sender.tag=19;
     }
     if (sender.tag==20) {
          sender.tag=120;
     }
     else if (sender.tag==120){
          sender.tag=20;
     }
     
     
     if (sender.tag<=20) {
          if ([newTempArraydeatil containsObject:[NSString stringWithFormat:@"%ld",sender.tag]]) {
               [newTempArraydeatil removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
          }
          else{
               [newTempArraydeatil addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
          }
     }
     else{
          if ([newTempArraydeatil containsObject:[NSString stringWithFormat:@"%ld",sender.tag-100]]) {
               [newTempArraydeatil removeObject:[NSString stringWithFormat:@"%ld",sender.tag-100]];
          }
          else{
               [newTempArraydeatil addObject:[NSString stringWithFormat:@"%ld",sender.tag-100]];
          }
          
     }
     
     
}

/////////////////////
-(IBAction)mileage:(UIButton*)sender;

{
     if(sender.tag==24)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"new";
     }
     if (sender.tag==25)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"under10k";
          
     }
     if (sender.tag==26)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"under30k";
     }
     if (sender.tag==27)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"under50k";
     }
     
     if (sender.tag==28)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"under70k";
     }
     
     if (sender.tag==29)
     {
          [btnhnew setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder10k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder30k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder50k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder70k setBackgroundImage:[UIImage imageNamed:@"radio_icon@1x"]forState:UIControlStateNormal];
          [btnunder100k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
          mileage=@"under100k";
     }
}

-(IBAction)colorBtnPressed:(id)sender{
     hasitent=@"color";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"EXTERIOR COLOR" withOption:arraycolor xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES andSelectedrows:selectedcolorValues];
     
}

-(IBAction)transmissionBtnPressed:(id)sender{
     hasitent=@"transmission";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"TRANSMISSION" withOption:arraytrasmission xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 35) isMultiple:NO];
}


-(IBAction)perfianceBtnPressed:(id)sender{
     hasitent=@"prefience";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"AMENITIES" withOption:arrayperifance xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 410) isMultiple:YES andSelectedrows:selectedprefienceValues];

}

-(IBAction)americaBtnPressed:(id)sender{
     hasitent=@"main";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"AMERICANS BRANDS" withOption:arrayamerica xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 365) isMultiple:YES andSelectedrows:selectedmainValues];

}

-(IBAction)asiaBtnPressed:(id)sender{
     hasitent=@"name";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"ASIAN BRANDS" withOption:arrayasia xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 410) isMultiple:YES andSelectedrows:selectednameValues];

}

-(IBAction)europeBtnPressed:(id)sender{
     hasitent=@"other";
     [Dropobj fadeOut];
     [self showPopUpWithTitle:@"EUROPEANS BRANDS" withOption:arrayeurope xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 296) isMultiple:YES andSelectedrows:selectedotherValues];
}

-(IBAction)saveandfinddealerBtnPressed:(id)sender{
     [self hesitantcar];
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
     
     
     Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
     Dropobj.delegate = self;
     [Dropobj showInView:self.view animated:YES];
     
     /*----------------Set DropDown backGroundColor-----------------*/
     [Dropobj SetBackGroundDropDown_R:127.0 G:197.0 B:132.0 alpha:0.88];
     
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple andSelectedrows:(NSMutableArray *)selectedarray{
     
     
     Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple andselected:selectedarray];
     Dropobj.delegate = self;
     [Dropobj showInView:self.view animated:YES];
     
     /*----------------Set DropDown backGroundColor-----------------*/
     [Dropobj SetBackGroundDropDown_R:127.0 G:197.0 B:132.0 alpha:0.88];
     
}
-(void)dropDown:(DropDownListView *)dropdownListView SelectedIndexPaths:(NSArray *)selectedindexpaths

{
     if ([hasitent isEqualToString:@"main"]) {
          selectedmainValues  = [selectedindexpaths mutableCopy];
     }
     if ([hasitent isEqualToString:@"name"]) {
          selectednameValues  = [selectedindexpaths mutableCopy];

     }
     
     if([hasitent isEqualToString:@"other"]){
          selectedotherValues  = [selectedindexpaths mutableCopy];

     }
     if ([hasitent isEqualToString:@"color"]) {
          selectedcolorValues  = [selectedindexpaths mutableCopy];

          
     }
     if ([hasitent isEqualToString:@"prefience"]){
          selectedprefienceValues  = [selectedindexpaths mutableCopy];

     }

     
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
     /*----------------Get Selected Value[Single selection]-----------------*/
     if ([hasitent isEqualToString:@"color"]) {
          NSString*single1=[arraycolor objectAtIndex:anIndex];
          NSString*space1=[NSString stringWithFormat:@"%@",single1];
          [btncolor setTitle:space1 forState:UIControlStateNormal];
     }
     
     if ([hasitent isEqualToString:@"transmission"]) {
          NSString*single2=[arraytrasmission objectAtIndex:anIndex];
          NSString*space2=[NSString stringWithFormat:@"%@",single2];
          [btntransmission setTitle:space2 forState:UIControlStateNormal];
     }
     
     
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
     
     /*----------------Get Selected Value[Multiple selection]-----------------*/
     if (ArryData.count>0) {
          for (int i=0; i<ArryData.count; i++) {
               //NSString*str=[ArryData objectAtIndex:i];
               strdata= [ArryData componentsJoinedByString:@", "];
          }
          
          if ([hasitent isEqualToString:@"main"]) {
               [selectamerica addObject:strdata];
               [btnamerican setTitle:strdata forState:UIControlStateNormal];
          }
          if ([hasitent isEqualToString:@"name"]) {
               [btnasian setTitle:strdata forState:UIControlStateNormal];
               [selectasia addObject:strdata];
          }
          
          if([hasitent isEqualToString:@"other"]){
               [btneurope setTitle:strdata forState:UIControlStateNormal];
               [selecteurope addObject:strdata];
          }
          if ([hasitent isEqualToString:@"color"]) {
               [btncolor setTitle:strdata forState:UIControlStateNormal];
               [selectcolor addObject:strdata];
               
          }
          if ([hasitent isEqualToString:@"prefience"]){
               [btnseats setTitle:strdata forState:UIControlStateNormal];
               [selectprefrience addObject:strdata];
          }
     }
     else{
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



- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}



-(void)hesitantcar{
     if (!isWifiAvailable)
     {
          [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
          [[AppManager sharedManager] removeLoadingWindow];
          return;
     }
     
     newarray=[[NSMutableArray alloc]init];
     for (int i=0; i<newTempArray.count; i++) {
          NSString *str=[newTempArray objectAtIndex:i];
          NSString *str8=[tempArray objectAtIndex:[str intValue]];
          [newarray addObject:str8];
     }
     
     newarraydetail=[[NSMutableArray alloc]init];
     for (int i=0; i<newTempArraydeatil.count; i++) {
          NSString *strtemp=[newTempArraydeatil objectAtIndex:i];
          NSString *strdetail=[tempArraydetail objectAtIndex:[strtemp intValue]-7];
          [newarraydetail addObject:strdetail];
     }
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newarray options:0 error:nil];
     jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     
     NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:newarraydetail options:0 error:nil];
     jsonStringdetail = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
     
     NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:selectamerica options:0 error:nil];
     jsonString3 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
     
     NSData *jsonData3 = [NSJSONSerialization dataWithJSONObject:selectasia options:0 error:nil];
     jsonString4 = [[NSString alloc] initWithData:jsonData3 encoding:NSUTF8StringEncoding];
     NSData *jsonData4 = [NSJSONSerialization dataWithJSONObject:selecteurope options:0 error:nil];
     jsonString5 = [[NSString alloc] initWithData:jsonData4 encoding:NSUTF8StringEncoding];
     NSData *jsonData5 = [NSJSONSerialization dataWithJSONObject:selectcolor options:0 error:nil];
     jsonString6 = [[NSString alloc] initWithData:jsonData5 encoding:NSUTF8StringEncoding];
     NSData *jsonData6 = [NSJSONSerialization dataWithJSONObject:selectprefrience options:0 error:nil];
     jsonString7 = [[NSString alloc] initWithData:jsonData6 encoding:NSUTF8StringEncoding];
     
     NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
     
     NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:minstr,@"year_range",jsonString,@"type",jsonStringdetail,@"styles",mileage,@"mileage",jsonString6,@"color",btntransmission.titleLabel.text,@"transmission",user,@"buyer_id",jsonString7,@"preferences",jsonString3,@"brand_americans",jsonString4,@"brand_asians",jsonString5,@"brand_europeans",maxstr,@"year_range_max",nil];
     
     
     NSLog(@"%@",postDictionary);
     
     [[AppManager sharedManager] addLoadingWindow];
     NSString *strUrl=[NSString stringWithFormat:@"%@new_car_second_type",kURl];
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
               [self performSegueWithIdentifier:@"pushhasitant" sender:nil];
               
               [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:3.0f];
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

-(void)savecardetail{
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
     NSString *strUrl=[NSString stringWithFormat:@"%@new_car_second_type",kURl];
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
               minstr = [responseArray valueForKey:@"year_range"];
               if ([minstr isEqualToString:@""]) {
                    self.rangeSlider.minValue = 1990;
               }
               else{
                    
                    self.rangeSlider.selectedMinimum=[minstr intValue];
                    
               }
               maxstr = [responseArray valueForKey:@"year_range_max"];
               if ([maxstr isEqualToString:@""]) {
                    self.rangeSlider.maxValue = 2017;
               }
               else{
                    
                    self.rangeSlider.selectedMaximum=[maxstr intValue];
               }
               
               selectamerica = [responseArray valueForKey:@"brand_americans"];
               if (selectamerica == nil || [selectamerica count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               for (int i=0; i<selectamerica.count; i++){
                    NSMutableArray*commstr1=[selectamerica objectAtIndex:i];
                    NSString*strtitle=[NSString stringWithFormat:@"%@",commstr1];
                    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString = [[strtitle componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
                    [btnamerican setTitle:newReplacedString forState:UIControlStateNormal];
                    //[btnamerican setTitle:commstr1 forState:UIControlStateNormal];
                    
               }
               
               
               selectasia = [responseArray valueForKey:@"brand_asians"];
               if (selectasia == nil || [selectasia count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               for (int i=0; i<selectasia.count; i++){
                    NSString*commstr2=[selectasia objectAtIndex:i];
                    NSString*strtitle1=[NSString stringWithFormat:@"%@",commstr2];
                    NSCharacterSet *doNotWant1 = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString1 = [[strtitle1 componentsSeparatedByCharactersInSet: doNotWant1] componentsJoinedByString: @""];
                    [btnasian setTitle:newReplacedString1 forState:UIControlStateNormal];
                    
               }
               
               
               
               selecteurope = [responseArray valueForKey:@"brand_europeans"];
               if (selecteurope == nil || [selecteurope count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               for (int i=0; i<selecteurope.count; i++){
                    NSString*commstr3=[selecteurope objectAtIndex:i];
                    NSString*strtitle2=[NSString stringWithFormat:@"%@",commstr3];
                    NSCharacterSet *doNotWant2 = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString2 = [[strtitle2 componentsSeparatedByCharactersInSet: doNotWant2] componentsJoinedByString: @""];
                    [btneurope setTitle:newReplacedString2 forState:UIControlStateNormal];
                    
                    
               }
               
               
               NSString*typestring=[responseArray valueForKey:@"mileage"];
               if ([[typestring lowercaseString] isEqualToString:@"new"]) {
                    [btnhnew setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
               }
               else if ([[typestring lowercaseString] isEqualToString:@"under10k"]) {
                    [btnunder10k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
               }
               else if ([[typestring lowercaseString] isEqualToString:@"under30k"]) {
                    [btnunder30k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
               }
               
               else if ([[typestring lowercaseString] isEqualToString:@"under50k"]) {
                    [btnunder50k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];               }
               
               else if ([[typestring lowercaseString] isEqualToString:@"under70k"]) {
                    [btnunder70k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];
               }
               
               else{
                    [btnunder100k setBackgroundImage:[UIImage imageNamed:@"select_radio_icon@1x"]forState:UIControlStateNormal];               }
               
              selectcolor = [responseArray valueForKey:@"color"];
               if (selectcolor == nil || [selectcolor count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               for (int i=0; i < [selectcolor count]; i++){
                    NSString*commstr4=[selectcolor objectAtIndex:i];
                    NSString*strtitle2=[NSString stringWithFormat:@"%@",commstr4];
                    NSCharacterSet *doNotWant2 = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString2 = [[strtitle2 componentsSeparatedByCharactersInSet: doNotWant2] componentsJoinedByString: @""];
                    [btncolor setTitle:newReplacedString2 forState:UIControlStateNormal];
               }
               
               NSString*transmissionstring=[responseArray valueForKey:@"transmission"];
               NSString*trans=[NSString stringWithFormat:@"%@",transmissionstring];
               [btntransmission setTitle:trans forState:UIControlStateNormal];
               
             
               selectprefrience = [responseArray valueForKey:@"preferences"];
               if (selectprefrience == nil || [selectprefrience count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               for (int i=0; i < [selectprefrience count]; i++){
                    NSString*commstr5=[selectprefrience objectAtIndex:i];
                    NSString*strtitle2=[NSString stringWithFormat:@"%@",commstr5];
                    NSCharacterSet *doNotWant2 = [NSCharacterSet characterSetWithCharactersInString:@"\n()"""];
                    NSString * newReplacedString2 = [[strtitle2 componentsSeparatedByCharactersInSet: doNotWant2] componentsJoinedByString: @""];
                    [btnseats setTitle:newReplacedString2 forState:UIControlStateNormal];
               }
     
               
               newarray = [responseArray valueForKey:@"type"];
               if (newarray == nil || [newarray count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               
               for (int i=0; i < [newarray count]; i++){
                    mileagen1=[newarray objectAtIndex:i];
                    if ([mileagen1  isEqualToString:@"new"]) {
                         [btnnew setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnnew.tag=101;
                         [newTempArray addObject:@"1"];
                    }
                    if ([mileagen1  isEqualToString:@"certified"]) {
                         [btncertified setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btncertified.tag=102;
                         [newTempArray addObject:@"2"];
                         
                    }
                    if ([mileagen1  isEqualToString:@"prefiance"]) {
                         [btnpre setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnpre.tag=103;
                         [newTempArray addObject:@"3"];
                         
                         
                    }
                    
                    if ([mileagen1  isEqualToString:@"lease"]) {
                         [btnlease setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnlease.tag=104;
                         [newTempArray addObject:@"4"];
                         
                         
                    }
                    
                    if ([mileagen1  isEqualToString:@"anithing"]) {
                         [anything setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         anything.tag=105;
                         [newTempArray addObject:@"5"];
                         
                         
                    }
               }
               
               
               newarraydetail = [responseArray valueForKey:@"styles"];
               if (newarraydetail == nil || [newarraydetail count] == 0) {
                    [[AppManager sharedManager] removeLoadingWindow];
                    return;
               }
               
               for (int i=0; i < newarraydetail.count; i++){
                    style=[newarraydetail objectAtIndex:i];
                    if ([style  isEqualToString:@"ecomamy"]) {
                         [btnecenomy setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnecenomy.tag=107;
                         [newTempArraydeatil addObject:@"7"];
                    }
                    if ([style  isEqualToString:@"suv"]) {
                         [btnsuv setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnsuv.tag=108;
                         [newTempArraydeatil addObject:@"8"];
                    }
                    if ([style  isEqualToString:@"sedan"]) {
                         [btnsedan setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnsedan.tag=109;
                         [newTempArraydeatil addObject:@"9"];
                    }
                    if ([style  isEqualToString:@"convertable"]) {
                         [btnconvertiable setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnconvertiable.tag=110;
                         [newTempArraydeatil addObject:@"10"];
                    }
                    if ([style  isEqualToString:@"coupe"]) {
                         [btncoupe setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btncoupe.tag=111;
                         [newTempArraydeatil addObject:@"11"];
                         
                    }
                    if ([style  isEqualToString:@"lauxary"]) {
                         [btnluxury setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnluxury.tag=112;
                         [newTempArraydeatil addObject:@"12"];
                         
                    }
                    if ([style  isEqualToString:@"seat"]) {
                         [btnrowseat setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnrowseat.tag=113;
                         [newTempArraydeatil addObject:@"13"];
                    }
                    if ([style  isEqualToString:@"hatch"]) {
                         [btnhatch setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnhatch.tag=114;
                         [newTempArraydeatil addObject:@"14"];
                         
                    }
                    if ([style  isEqualToString:@"speed"]) {
                         [btnspeed setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnspeed.tag=115;
                         [newTempArraydeatil addObject:@"15"];
                         
                    }
                    if ([style  isEqualToString:@"van"]) {
                         [btnvan setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnvan.tag=116;
                         [newTempArraydeatil addObject:@"16"];
                         
                    }
                    if ([style  isEqualToString:@"truck"]) {
                         [btntruck setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btntruck.tag=117;
                         [newTempArraydeatil addObject:@"17"];
                         
                    }
                    
                    if ([style  isEqualToString:@"electirc"]) {
                         [btneletric setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btneletric.tag=118;
                         [newTempArraydeatil addObject:@"18"];
                         
                    }
                    if ([style  isEqualToString:@"driving"]) {
                         [btndriving setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btndriving.tag=119;
                         [newTempArraydeatil addObject:@"19"];
                         
                    }
                    if ([style  isEqualToString:@"hybrid"]) {
                         [btnhybrid setBackgroundImage:[UIImage imageNamed:@"check_box_fil2@1x"]forState:UIControlStateNormal];
                         btnhybrid.tag=120;
                         [newTempArraydeatil addObject:@"20"];
                         
                    }

                    
               }
          
               [[AppManager sharedManager] removeLoadingWindow];
               //[self performSegueWithIdentifier:@"go2" sender:nil];
               
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

-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(int)selectedMinimum andMaximumValue:(int)selectedMaximum{
     
     //     minstr=[NSString stringWithFormat:@"%f",selectedMinimum];
     //     maxstr=[NSString stringWithFormat:@"%f",selectedMaximum];
     if (sender == self.rangeSlider){
          NSLog(@"Standard slider updated. Min Value: %d Max Value: %d", selectedMinimum, selectedMaximum);
          minstr=[NSString stringWithFormat:@"%d",selectedMinimum];
          maxstr=[NSString stringWithFormat:@"%d",selectedMaximum];
          
     }
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
