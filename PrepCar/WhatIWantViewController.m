//
//  HesitantViewController.m
//  PrepCar
//
//  Created by Devendra on 1/7/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "WhatIWantViewController.h"
#import "TabbarViewController.h"

@interface WhatIWantViewController ()<kDropDownListViewDelegate>

@end

@implementation WhatIWantViewController
@synthesize whatwant;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    /////
    selectedcolorValues = [[NSMutableArray alloc]init];
   selectedfeatureValues = [[NSMutableArray alloc]init];
    selectedcolorValues1= [[NSMutableArray alloc]init];;
    
    selectedcolorValues2= [[NSMutableArray alloc]init];;
    
    selectedcolorValues3= [[NSMutableArray alloc]init];;
    
    selectedcolorValues4= [[NSMutableArray alloc]init];;
   selectednewValues = [[NSMutableArray alloc]init];
    arraycolor1=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
    arraycolor2=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
    arraycolor3=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
    arraycolor4=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
    arraycolor5=[[NSMutableArray alloc]initWithObjects:@"White",@"Black",@"Blue",@"Green",@"Pink",@"Yellow",@"Gray",@"Silver",@"Brown",@"Purple",@"Red",@"No preferences", nil];
////////
    view2.hidden=YES;
    view3.hidden=YES;
    view4.hidden=YES;
    view5.hidden=YES;
   

    ///////////////
    [[AppManager sharedManager] changeTextFieldDesign:txtyear Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtmake Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:txtmodel Image:[UIImage imageNamed:@"user-email"]];
    //////////
    [[AppManager sharedManager] changeTextFieldDesign:btnyear2 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmake2 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmodel2 Image:[UIImage imageNamed:@"user-email"]];
    /////////
    [[AppManager sharedManager] changeTextFieldDesign:btnyear3 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmake3 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmodel3 Image:[UIImage imageNamed:@"user-email"]];
    ///////////
    [[AppManager sharedManager] changeTextFieldDesign:btnyear4 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmake4 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmodel4 Image:[UIImage imageNamed:@"user-email"]];
    
    ////////
    [[AppManager sharedManager] changeTextFieldDesign:btnyear5 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmake5 Image:[UIImage imageNamed:@"user-email"]];
    [[AppManager sharedManager] changeTextFieldDesign:btnmodel5 Image:[UIImage imageNamed:@"user-email"]];
    btnnew1.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btnfeature.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btncolor.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btncolor1.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);

    btncolor2.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);

    btncolor3.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);

    btncolor4.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);



    ///////////////////
    btnnew2.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btnfeature1.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    ////////////////////

    btnnew3.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btnfeature2.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    ////////////////

    btnnew4.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btnfeature3.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    /////////////

    btnnew5.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    btnfeature4.titleEdgeInsets = UIEdgeInsetsMake(-13,10, -10, 0);
    
    
    count=1;
    
    ///////////////
    
    
    self.navigationItem.title = @"I KNOW WHAT I WANT";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
    arraynew1 =[[NSMutableArray alloc]initWithObjects:@"New",@"used",@"lease", nil];
    arraynew2 =[[NSMutableArray alloc]initWithObjects:@"New",@"used",@"lease", nil];
    arraynew3 =[[NSMutableArray alloc]initWithObjects:@"New",@"used",@"lease", nil];
    arraynew4 =[[NSMutableArray alloc]initWithObjects:@"New",@"used",@"lease", nil];
    arraynew5 =[[NSMutableArray alloc]initWithObjects:@"New",@"used",@"lease", nil];
    arrayfeature =[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat", nil];
    arrayfeature1 =[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat", nil];
    arrayfeature2 =[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat", nil];
    arrayfeature3 =[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat", nil];
    arrayfeature4 =[[NSMutableArray alloc]initWithObjects:@"Sunroof/Moonroof",@"Leather seats",@"Back-up camera",@"Navigation",@"Keyless entry",@"Apple CarPlay/Android Auto",@"Bluetooth",@"Heated seats",@"Remote start",@"Parking assist",@"Premium audio",@"3rd row seat", nil];
    
    //[self yearList];
    [self whatiwantdetail];
    txtcomment.delegate=self;
    viewcomment1.delegate=self;
    txtcomment1.delegate=self;
    txtcomment2.delegate=self;
    txtcomment3.delegate=self;
    txtcomment4.delegate=self;
    
    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+20, self.view.frame.size.width-30, 45)];

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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:114/255.0f green:195/255.0f blue:106/255.0f alpha:1.0f];
}
-(BOOL)checkValidation{
    if (txtcomment.text.length==0||[txtcomment.text isEqualToString:@"Comment"])  {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter comment"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if ([btnnew1.currentTitle isEqualToString:@"NEW"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the new"
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
                                                                                 message:@"Please Select the COLOR"
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
                                                                                 message:@"Please Select the FEATURES"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    if (txtyear.text==0) {
        
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
    
    if (txtmake.text==0) {
        
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
    
    if (txtmodel.text==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the model"
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

-(BOOL)checkValidation1{
    if (txtcomment1.text.length==0||[txtcomment1.text isEqualToString:@"Comment"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter comment"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if ([btnnew2.currentTitle isEqualToString:@"NEW"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the new"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if (btnyear2.text==0) {
        
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
    
    if ([btncolor1.currentTitle isEqualToString:@"SELECT COLOR"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the COLOR"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    
    if ([btnfeature1.currentTitle isEqualToString:@"SELECT FEATURES"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the FEATURES"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    
    if (btnmake2.text==0) {
        
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
    
    if (btnmodel2.text==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the model"
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


-(BOOL)checkValidation2{
    if (txtcomment2.text.length==0||[txtcomment2.text isEqualToString:@"Comment"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter comment"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if ([btnnew3.currentTitle isEqualToString:@"NEW"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the new"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if ([btncolor2.currentTitle isEqualToString:@"SELECT COLOR"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the COLOR"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    
    if ([btnfeature2.currentTitle isEqualToString:@"SELECT FEATURES"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the FEATURES"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    if (btnyear3.text==0) {
        
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
    
    if (btnmake3.text==0) {
        
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
    
    if (btnmodel3.text==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the model"
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


-(BOOL)checkValidation3{
    if (txtcomment3.text.length==0||[txtcomment3.text isEqualToString:@"Comment"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please enter comment"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    if ([btnnew4.currentTitle isEqualToString:@"NEW"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the new"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    if ([btncolor3.currentTitle isEqualToString:@"SELECT COLOR"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the COLOR"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    
    if ([btnfeature3.currentTitle isEqualToString:@"SELECT FEATURES"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Select the FEATURES"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }

    if (btnyear4.text==0) {
        
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
    
    if (btnmake4.text==0) {
        
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
    
    if (btnmodel4.text==0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please Enter the model"
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

-(void) viewDidLayoutSubviews; {
    super.viewDidLayoutSubviews;
    Scroller4.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height+1100);
}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)saveBtnPressed:(id)sender{
    if ([self checkValidation]) {
    [self whatiwant];
    }
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:127.0 G:197.0 B:132.0 alpha:0.88];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    
         
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    if (ArryData.count>0) {
        for (int i=0; i<ArryData.count; i++) {
            //NSString*str=[ArryData objectAtIndex:i];
            strdata= [ArryData componentsJoinedByString:@","];
        }
        if ([whatwant isEqualToString:@"new1"]){
            [btnnew1 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"new2"]){
            [btnnew2 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"new3"]){
            [btnnew3 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"new4"]){
            [btnnew4 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"new5"]){
            [btnnew5 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"feature"]){
            [btnfeature setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"feature1"]){
            [btnfeature1 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"feature2"]){
            [btnfeature2 setTitle:strdata forState:UIControlStateNormal];
           
        }
        if ([whatwant isEqualToString:@"feature3"]){
            [btnfeature3 setTitle:strdata forState:UIControlStateNormal];
            
        }
        if ([whatwant isEqualToString:@"feature4"]){
            [btnfeature4 setTitle:strdata forState:UIControlStateNormal];
        }
        if ([whatwant isEqualToString:@"color"]){
            [btncolor setTitle:strdata forState:UIControlStateNormal];
        }
        if ([whatwant isEqualToString:@"color1"]){
            [btncolor1 setTitle:strdata forState:UIControlStateNormal];
        }
        if ([whatwant isEqualToString:@"color2"]){
            [btncolor2 setTitle:strdata forState:UIControlStateNormal];
        }
        if ([whatwant isEqualToString:@"color3"]){
            [btncolor3 setTitle:strdata forState:UIControlStateNormal];
        }
        if ([whatwant isEqualToString:@"color4"]){
            [btncolor4 setTitle:strdata forState:UIControlStateNormal];
        }
        
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
///////


-(IBAction)newbutton:(UIButton*)sender;
{
    whatwant=@"new1";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CAR TYPES" withOption:arraynew1 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 65) isMultiple:YES andSelectedrows:selectednewValues];
}

-(IBAction)feature:(UIButton*)sender;
{
    
    whatwant=@"feature";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"AMENITIES" withOption:arrayfeature xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES andSelectedrows:selectedfeatureValues];
}


/////////////////

-(IBAction)new2button:(UIButton*)sender;
{
    whatwant=@"new2";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CAR TYPES" withOption:arraynew2 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 65) isMultiple:YES andSelectedrows:selectednewValues];
   
}

-(IBAction)feature1:(UIButton*)sender;
{
    
    whatwant=@"feature1";
    [Dropobj fadeOut];
     [self showPopUpWithTitle:@"AMENITIES" withOption:arrayfeature1 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES andSelectedrows:selectedfeatureValues];
    
}


////////////////


-(IBAction)new3button:(UIButton*)sender;
{
    whatwant=@"new3";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CAR TYPES" withOption:arraynew3 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 65) isMultiple:YES andSelectedrows:selectednewValues];
}

-(IBAction)feature2:(UIButton*)sender;
{
    whatwant=@"feature2";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"AMENITIES" withOption:arrayfeature2 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES andSelectedrows:selectedfeatureValues];
}


-(IBAction)new4button:(UIButton*)sender;
{
    whatwant=@"new4";
    [Dropobj fadeOut];
   [self showPopUpWithTitle:@"CAR TYPES" withOption:arraynew4 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 65) isMultiple:YES andSelectedrows:selectednewValues];
}

-(IBAction)feature3:(UIButton*)sender;
{
    whatwant=@"feature3";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"AMENITIES" withOption:arrayfeature3 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES andSelectedrows:selectedfeatureValues];
}

-(IBAction)new5button:(UIButton*)sender;
{
    whatwant=@"new5";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"CAR TYPES" withOption:arraynew5 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 65) isMultiple:YES andSelectedrows:selectednewValues];
}

-(IBAction)feature4:(UIButton*)sender;
{
    whatwant=@"feature4";
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"AMENITIES" withOption:arrayfeature4 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50,410) isMultiple:YES andSelectedrows:selectedfeatureValues];
}

-(IBAction)add1BtnPressed:(id)sender{
    if ([self checkValidation]) {
        view2.hidden=NO;
        btnadd1.hidden=YES;
        count++;
        [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+360, self.view.frame.size.width-30, 45)];
        
        
        
    }
}
-(IBAction)add2BtnPressed:(id)sender{
    if ([self checkValidation1]) {
        view3.hidden=NO;
        btnadd2.hidden=YES;
        btndelete1.enabled = NO;
        count++;
        [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+720, self.view.frame.size.width-30, 45)];
        
        
        
    }
}
-(IBAction)add3BtnPressed:(id)sender{
    if ([self checkValidation2]) {
        view4.hidden=NO;
        btnadd3.hidden=YES;
        btndelete2.enabled = NO;
        count++;
        [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+1070, self.view.frame.size.width-30, 45)];
        
        
        
    }
}
-(IBAction)add4BtnPressed:(id)sender{
    if ([self checkValidation3]) {
        view5.hidden=NO;
        btnadd4.hidden=YES;
        btndelete3.enabled = NO;
        count++;
        [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+1400, self.view.frame.size.width-30, 45)];
        
        
        
    }
}


-(IBAction)delete2BtnPressed:(id)sender{
    view2.hidden=YES;
    btnadd1.hidden=NO;
    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+20, self.view.frame.size.width-30, 45)];
    
    
}

-(IBAction)delete3BtnPressed:(id)sender{
    view3.hidden=YES;
    btnadd2.hidden=NO;
    btndelete1.enabled = YES;
    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+360, self.view.frame.size.width-30, 45)];
    
    
}

-(IBAction)delete4BtnPressed:(id)sender{
    
    view4.hidden=YES;
    btnadd3.hidden=NO;
    btndelete2.enabled = YES;
     [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+720, self.view.frame.size.width-30, 45)];
    
    
    
}

-(IBAction)delete5BtnPressed:(id)sender{
    view5.hidden=YES;
    btnadd4.hidden=NO;
    btndelete3.enabled = YES;
    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+1070, self.view.frame.size.width-30, 45)];
    
    
    
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)whatiwant{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    
    NSMutableArray*newarray1=[[NSMutableArray alloc]init];
    NSString*new;
    NSString*year;
    NSString*make;
    NSString*model;
    NSString*feature;
    NSString*comment;
    NSString*strcolor;
    
    for (int i=0; i<count; i++) {
        UIView* subview = [Scroller4 viewWithTag:200+i];
        for (id obj in subview.subviews) {
            NSLog(@"%@",subview.subviews);
            UIView *view=(UIView*)obj;
            if (view.tag==100) {
                UIButton *btn=(UIButton*)view;
                new=[btn titleForState:UIControlStateNormal];
            }
            else if (view.tag==101) {
                UITextField *btn=(UITextField*)view;
                year=[btn text];
            }
            else if (view.tag==102) {
                UITextField *btn=(UITextField*)view;
                make=[btn text];
            }
            else if (view.tag==103) {
                UITextField *btn=(UITextField*)view;
                model=[btn text];
            }
            else if (view.tag==104) {
                UIButton *btn=(UIButton*)view;
                feature=[btn titleForState:UIControlStateNormal];
            }
            else if (view.tag==105) {
                UITextView *txtView=(UITextView*)view;
                comment=txtView.text;
            }
            else if (view.tag==106) {
                UIButton *btn=(UIButton*)view;
                strcolor=[btn titleForState:UIControlStateNormal];
            }
            
        }
        
        NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:new,@"new",year,@"year",make,@"make",model,@"model",feature,@"feature",comment,@"comment",strcolor,@"color", nil];
        [newarray1 addObject:dict];
    }
    
    NSLog(@"%@",newarray1);
    NSMutableArray *commentString=[[NSMutableArray alloc] init];
    NSMutableArray *featureString=[[NSMutableArray alloc] init];
    
    NSMutableArray *yearString=[[NSMutableArray alloc] init];
    
    NSMutableArray *makeString=[[NSMutableArray alloc] init];
    
    NSMutableArray *modelString=[[NSMutableArray alloc] init];
    
    NSMutableArray *newString=[[NSMutableArray alloc] init];
    NSMutableArray *newcolor=[[NSMutableArray alloc] init];
    
    for (int i=0; i<newarray1.count; i++) {
        NSString *commentstr=[[newarray1 valueForKey:@"comment"] objectAtIndex:i];
        [commentString addObject:commentstr];
        
        NSString *featurestr=[[newarray1 valueForKey:@"feature"] objectAtIndex:i];
        [featureString addObject:featurestr];
        
        
        NSString *makestr=[[newarray1 valueForKey:@"make"] objectAtIndex:i];
        [makeString addObject:makestr];
        
        NSString *modelstr=[[newarray1 valueForKey:@"model"] objectAtIndex:i];
        [modelString addObject:modelstr];
        
        
        NSString *newstr=[[newarray1 valueForKey:@"new"] objectAtIndex:i];
        [newString addObject:newstr];
        
        
        NSString *yearstr=[[newarray1 valueForKey:@"year"] objectAtIndex:i];
        [yearString addObject:yearstr];
        
        NSString *colorstr=[[newarray1 valueForKey:@"color"] objectAtIndex:i];
        [newcolor addObject:colorstr];
        
    }
    NSData *jsonDatanew = [NSJSONSerialization dataWithJSONObject:newString options:0 error:nil];
    jsonStringnew = [[NSString alloc] initWithData:jsonDatanew encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatayear = [NSJSONSerialization dataWithJSONObject:yearString options:0 error:nil];
    jsonStringyear = [[NSString alloc] initWithData:jsonDatayear encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatamake = [NSJSONSerialization dataWithJSONObject:makeString options:0 error:nil];
    jsonStringmake = [[NSString alloc] initWithData:jsonDatamake encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatamodel = [NSJSONSerialization dataWithJSONObject:modelString options:0 error:nil];
    jsonStringmodel = [[NSString alloc] initWithData:jsonDatamodel encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatafeature = [NSJSONSerialization dataWithJSONObject:featureString options:0 error:nil];
    jsonStringfeature = [[NSString alloc] initWithData:jsonDatafeature encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatacomment = [NSJSONSerialization dataWithJSONObject:commentString options:0 error:nil];
    jsonStringcommen= [[NSString alloc] initWithData:jsonDatacomment encoding:NSUTF8StringEncoding];
    
    NSData *jsonDatacolor = [NSJSONSerialization dataWithJSONObject:newcolor options:0 error:nil];
    jsonStringcolor= [[NSString alloc] initWithData:jsonDatacolor encoding:NSUTF8StringEncoding];
    
    
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:jsonStringnew,@"new",jsonStringyear,@"year",user,@"buyer_id",jsonStringmake,@"make",jsonStringmodel,@"model",jsonStringfeature,@"features",jsonStringcommen,@"comment",jsonStringcolor,@"color", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@new_car_first_type",kURl];
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
            [self performSegueWithIdentifier:@"pushwhat" sender:nil];
            
            [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:3.0f];
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

/////////////detail

-(void)whatiwantdetail{
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
    NSString *strUrl=[NSString stringWithFormat:@"%@new_car_first_type",kURl];
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
            
//            search.text=[responseArray valueForKey:@"car_search"];
//            txtmodels.text=[responseArray valueForKey:@"specificmodel"];
            NSMutableArray*arr=[responseArray valueForKey:@"comment"];
            NSMutableArray*arr1=[responseArray valueForKey:@"features"];
            NSMutableArray*arr2=[responseArray valueForKey:@"make"];
            NSMutableArray*arr3=[responseArray valueForKey:@"model"];
            NSMutableArray*arr5=[responseArray valueForKey:@"year"];
            NSMutableArray*arr4=[responseArray valueForKey:@"new"];
            NSMutableArray*arr6=[responseArray valueForKey:@"color"];
            
            if(![arr isKindOfClass:[NSMutableArray class]]) {
                [[AppManager sharedManager] removeLoadingWindow];
                
            }
            else{
            
            for (int i=0; i<arr.count; i++){
                if (i==0) {
                    view1.hidden=NO;
                    NSString*commstr=[arr objectAtIndex:i];
                    NSString*feastr=[arr1 objectAtIndex:i];
                    NSString*yeastr=[arr5 objectAtIndex:i];
                    NSString*modstr=[arr3 objectAtIndex:i];
                    NSString*newstr=[arr4 objectAtIndex:i];
                    NSString*makstr=[arr2 objectAtIndex:i];
                    NSString*colstr=[arr6 objectAtIndex:i];
                    [btnnew1 setTitle:newstr forState:UIControlStateNormal];
                    [btncolor setTitle:colstr forState:UIControlStateNormal];
                    txtyear.text =yeastr;
                    txtmake.text =makstr;
                    txtmodel.text =modstr;


                    txtcomment.text=[NSString stringWithFormat:@"%@",commstr];
                    NSString*spacestr =[NSString stringWithFormat:@"%@",feastr];
                    [btnfeature setTitle:spacestr forState:UIControlStateNormal];
                    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+20, self.view.frame.size.width-30, 45)];
                    
                }
                else if (i==1) {
                    view2.hidden=NO;
                    NSString*commstr1=[arr objectAtIndex:i];
                    NSString*feastr1=[arr1 objectAtIndex:i];
                    NSString*yeastr1=[arr5 objectAtIndex:i];
                    NSString*modstr1=[arr3 objectAtIndex:i];
                    NSString*newstr1=[arr4 objectAtIndex:i];
                    NSString*makstr1=[arr2 objectAtIndex:i];
                    NSString*colstr=[arr6 objectAtIndex:i];
                    [btncolor1 setTitle:colstr forState:UIControlStateNormal];
                    [btnnew2 setTitle:newstr1 forState:UIControlStateNormal];
                    
                    btnyear2.text =yeastr1;
                    btnmake2.text =makstr1;

                    btnmodel2.text =modstr1;

                    txtcomment1.text=[NSString stringWithFormat:@"%@",commstr1];
                    NSString*spacestr1 =[NSString stringWithFormat:@"%@",feastr1];
                    [btnfeature1 setTitle:spacestr1 forState:UIControlStateNormal];
                    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+370, self.view.frame.size.width-30, 45)];
                    
                    
                    
                    //txtfeature1.text=[NSString stringWithFormat:@"%@",feastr1];
                }
                else if (i==2) {
                    view3.hidden=NO;
                    NSString*commstr2=[arr objectAtIndex:i];
                    NSString*feastr2=[arr1 objectAtIndex:i];
                    NSString*yeastr2=[arr5 objectAtIndex:i];
                    NSString*modstr2=[arr3 objectAtIndex:i];
                    NSString*newstr2=[arr4 objectAtIndex:i];
                    NSString*makstr2=[arr2 objectAtIndex:i];
                    NSString*colstr=[arr6 objectAtIndex:i];
                    [btncolor2 setTitle:colstr forState:UIControlStateNormal];
                    [btnnew3 setTitle:newstr2 forState:UIControlStateNormal];
                    btnyear3.text =yeastr2;
                    btnmake3.text =makstr2;
                    btnmodel3.text =modstr2;
                    txtcomment2.text=[NSString stringWithFormat:@"%@",commstr2];
                    NSString*spacestr2 =[NSString stringWithFormat:@"%@",feastr2];
                    [btnfeature2 setTitle:spacestr2 forState:UIControlStateNormal];
                    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+720, self.view.frame.size.width-30, 45)];
                    
                    
                    
                    //txtfeature2.text=[NSString stringWithFormat:@"%@",feastr2];
                }
                else if (i==3) {
                    view4.hidden=NO;
                    NSString*commstr3=[arr objectAtIndex:i];
                    NSString*feastr3=[arr1 objectAtIndex:i];
                    NSString*yeastr3=[arr5 objectAtIndex:i];
                    NSString*modstr3=[arr3 objectAtIndex:i];
                    NSString*newstr3=[arr4 objectAtIndex:i];
                    NSString*makstr3=[arr2 objectAtIndex:i];
                    NSString*colstr=[arr6 objectAtIndex:i];
                    [btncolor3 setTitle:colstr forState:UIControlStateNormal];
                    [btnnew4 setTitle:newstr3 forState:UIControlStateNormal];
                    
                    btnyear4.text =yeastr3;
                    btnmake4.text =makstr3;
                    
                    btnmodel4.text =modstr3;
                    txtcomment3.text=[NSString stringWithFormat:@"%@",commstr3];
                    NSString*spacestr3 =[NSString stringWithFormat:@"%@",feastr3];
                    [btnfeature3 setTitle:spacestr3 forState:UIControlStateNormal];
                    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+1070, self.view.frame.size.width-30, 45)];
                    
                    
                    
                    //txtfeature3.text=[NSString stringWithFormat:@"%@",feastr3];
                }
                else if (i==4) {
                    view5.hidden=NO;
                    NSString*commstr4=[arr objectAtIndex:i];
                    NSString*feastr4=[arr1 objectAtIndex:i];
                    NSString*yeastr4=[arr5 objectAtIndex:i];
                    NSString*modstr4=[arr3 objectAtIndex:i];
                    NSString*newstr4=[arr4 objectAtIndex:i];
                    NSString*makstr4=[arr2 objectAtIndex:i];
                    NSString*colstr=[arr6 objectAtIndex:i];
                    [btncolor4 setTitle:colstr forState:UIControlStateNormal];
                    [btnnew5 setTitle:newstr4 forState:UIControlStateNormal];
                    btnyear5.text =yeastr4;
                    btnmake5.text =makstr4;
                    
                    btnmodel5.text =modstr4;
                    txtcomment4.text=[NSString stringWithFormat:@"%@",commstr4];
                    NSString*spacestr4 =[NSString stringWithFormat:@"%@",feastr4];
                    [btnfeature4 setTitle:spacestr4 forState:UIControlStateNormal];
                    [btnsave  setFrame:CGRectMake(self.view.frame.origin.x+16, btndelete1.frame.origin.y+1400, self.view.frame.size.width-30, 45)];
                    
                    
                    //txtfeature4.text=[NSString stringWithFormat:@"%@",feastr4];
                }
            }
            
        }
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
-(IBAction)colorBtnPressed:(id)sender{
    whatwant=@"color";

    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"COLOR" withOption:arraycolor1 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES];
    
}
-(IBAction)colorBtn1Pressed:(id)sender{
    whatwant=@"color1";
    
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"COLOR" withOption:arraycolor2 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES];
    
}
-(IBAction)colorBtn2Pressed:(id)sender{
    whatwant=@"color2";
    
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"COLOR" withOption:arraycolor3 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES];
    
}
-(IBAction)colorBtn3Pressed:(id)sender{
    whatwant=@"color3";
    
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"COLOR" withOption:arraycolor4 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES];
    
}
-(IBAction)colorBtn4Pressed:(id)sender{
    whatwant=@"color4";
    
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"COLOR" withOption:arraycolor5 xy:CGPointMake(self.view.frame.origin.x+22, 58) size:CGSizeMake(self.view.frame.size.width-50, 420) isMultiple:YES];
    
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
    if ([whatwant isEqualToString:@"new1"]){
        selectednewValues =[selectedindexpaths mutableCopy];
    }
    if ([whatwant isEqualToString:@"new2"]){
        selectednewValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"new3"]){
        selectednewValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"new4"]){
        selectednewValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"new5"]){
        selectednewValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"feature"]){
        selectedfeatureValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"feature1"]){
        selectedfeatureValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"feature2"]){
        selectedfeatureValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"feature3"]){
        selectedfeatureValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"feature4"]){
        selectedfeatureValues =[selectedindexpaths mutableCopy];
        
    }
    
    if ([whatwant isEqualToString:@"color"]){
        selectedcolorValues =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"color1"]){
        selectedcolorValues1 =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"color2"]){
        selectedcolorValues2 =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"color3"]){
        selectedcolorValues3 =[selectedindexpaths mutableCopy];
        
    }
    if ([whatwant isEqualToString:@"color4"]){
        selectedcolorValues4 =[selectedindexpaths mutableCopy];
        
    }
    
   
   
    //whatwant
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
