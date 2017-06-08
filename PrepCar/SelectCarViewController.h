//
//  SelectCarViewController.h
//  PrepCar
//
//  Created by Devendra on 1/11/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface SelectCarViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{

    IBOutlet UILabel *vehiclelbl;
    IBOutlet UITextView *DesriptionText;
    IBOutlet UITextField*txtterms;
    IBOutlet UITextField*txtdisclimer;
    IBOutlet UITextField*txtrate;
    IBOutlet UILabel *Desriptionlbl;
    IBOutlet UIButton *Btn;
    IBOutlet UIButton*selectbtn;
    IBOutlet UIScrollView*scroller;
    IBOutlet UITextField*txtprice;
    IBOutlet UITextField*txtmonthly;
    IBOutlet UITextField*txtnickname;
    IBOutlet UITextField*txtdown;
    IBOutlet UITextField*txttrade;
    IBOutlet UIButton *Btnmonth1;
    IBOutlet UIButton *Btnmonth2;
    IBOutlet UIButton *Btnmonth3;
    IBOutlet UIButton *Btnmonth4;
    IBOutlet UIButton *Btnmonth5;
    //////////////
    IBOutlet UIButton *Btnfinanceyes;
    IBOutlet UIButton *Btnfinanceno;
    IBOutlet UIButton *Btntradeyes;
    IBOutlet UIButton *Btntradeno;
    IBOutlet UIButton *Btnleaseyes;
    IBOutlet UIButton *Btnleaseno;
    ///////////
    DropDownListView * Dropobj;
    NSMutableArray*cararray;
    NSMutableArray*caridarray;
    NSMutableArray*modelarray;
    NSMutableArray*makearray;
    NSMutableArray*newarray;
    NSMutableArray*newarray1;
    NSMutableArray*newarray2;
    NSString*btncount;
    NSString*strnew;
    NSString*strnew1;
    NSString*combine;
  
    
}

@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;
@property(strong,nonatomic)NSString*strunique;
@property(strong,nonatomic) IBOutlet UISwitch*switchon;
@end
