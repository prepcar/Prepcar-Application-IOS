//
//  WhatIWantViewController.h
//  PrepCar
//
//  Created by Devendra on 1/6/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface WhatIWantViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{

    NSMutableArray*arraycolor1;
    NSMutableArray*arraycolor2;
    NSMutableArray*arraycolor3;
    NSMutableArray*arraycolor4;
    NSMutableArray*arraycolor5;
    NSString*jsonStringcolor;
    NSMutableArray*selectedcolorValues;
    
    NSMutableArray*selectedcolorValues1;

    NSMutableArray*selectedcolorValues2;

    NSMutableArray*selectedcolorValues3;

    NSMutableArray*selectedcolorValues4;

    NSMutableArray*selectedfeatureValues;
    IBOutlet UIButton*btncolor;
    IBOutlet UIButton*btncolor1;
    IBOutlet UIButton*btncolor2;
    IBOutlet UIButton*btncolor3;
    IBOutlet UIButton*btncolor4;

    NSMutableArray*selectednewValues;

    NSString *hasitent ;
    IBOutlet UIScrollView *Scroller4;
    IBOutlet UILabel*lblsearch;
    IBOutlet UIView*view1;
    IBOutlet UIView*view2;
    IBOutlet UIView*view3;
    IBOutlet UIView*view4;
    IBOutlet UIView*view5;
    IBOutlet UIButton*btnnew1;
    IBOutlet UITextField *txtyear;
    IBOutlet UITextField *txtmake;
    IBOutlet UITextField *txtmodel;
    IBOutlet UITextField*viewcomment1;
    IBOutlet UIButton*btnsave;
    IBOutlet UIButton*btnadd1;
    IBOutlet UIButton*btnadd2;
    IBOutlet UIButton*btnadd3;
    IBOutlet UIButton*btnadd4;
    IBOutlet UIButton*btnadd5;
    NSMutableArray*arrayyear1;
    NSMutableArray*arraymake1;;
    NSMutableArray*arraymodel1;
    NSMutableArray*arraynew1;
    NSString*mystring;
    NSString*mystring1;
    NSString*mystring2;
    NSString*mystring3;
    //////////
    NSArray*tempnewarray;
    NSMutableArray*newarray;
    NSString*jsonStringnew;
     NSString*jsonStringyear;
     NSString*jsonStringmake;
     NSString*jsonStringmodel;
     NSString*jsonStringfeature;
     NSString*jsonStringcommen;
    int count;
    NSString*strdata;
    IBOutlet UIButton*btndelete1;
    IBOutlet UIButton*btndelete2;
    IBOutlet UIButton*btndelete3;
    IBOutlet UIButton*btndelete4;
    ///////////////////
    IBOutlet UIButton*btnfeature;
    IBOutlet UITextView*txtcomment;
    IBOutlet UIButton*btnfeature1;
    IBOutlet UITextView*txtcomment1;
    IBOutlet UIButton*btnfeature2;
    IBOutlet UITextView*txtcomment2;
    IBOutlet UIButton*btnfeature3;
    IBOutlet UITextView*txtcomment3;
    IBOutlet UIButton*btnfeature4;
    IBOutlet UITextView*txtcomment4;
    ////////////
    NSMutableArray*arrayyear2;
    NSMutableArray*arraymake2;;
    NSMutableArray*arraymodel2;
    NSMutableArray*arraynew2;
    NSString*newstring;
    NSString*newstring1;
    NSString*newstring2;
    NSString*newstring3;
    IBOutlet UIButton*btnnew2;
    IBOutlet UITextField*btnyear2;
    IBOutlet UITextField*btnmake2;
    IBOutlet UITextField*btnmodel2;
    
/////////////////////
    NSMutableArray*arrayyear3;
    NSMutableArray*arraymake3;;
    NSMutableArray*arraymodel3;
    NSMutableArray*arraynew3;
    NSString*carstring;
    NSString*carstring1;
    NSString*carstring2;
    NSString*carstring3;
    IBOutlet UIButton*btnnew3;
    IBOutlet UITextField*btnyear3;
    IBOutlet UITextField*btnmake3;
    IBOutlet UITextField*btnmodel3;
    ///////////////
    NSMutableArray*arrayyear4;
    NSMutableArray*arraymake4;;
    NSMutableArray*arraymodel4;
    NSMutableArray*arraynew4;
    NSString*fourthstring;
    NSString*fourthstring1;
    NSString*fourthstring2;
    NSString*fourthstring3;
    IBOutlet UIButton*btnnew4;
    IBOutlet UITextField*btnyear4;
    IBOutlet UITextField*btnmake4;
    IBOutlet UITextField*btnmodel4;
    //////////////////
    NSMutableArray*arrayyear5;
    NSMutableArray*arraymake5;;
    NSMutableArray*arraymodel5;
    NSMutableArray*arraynew5;
    NSString*fifthstring;
    NSString*fifthstring1;
    NSString*fifthstring2;
    NSString*fifthstring3;
    IBOutlet UIButton*btnnew5;
    IBOutlet UITextField*btnyear5;
    IBOutlet UITextField*btnmake5;
    IBOutlet UITextField*btnmodel5;
    DropDownListView * Dropobj;
     NSMutableArray*arrayfeature;
     NSMutableArray*arrayfeature1;
     NSMutableArray*arrayfeature2;
     NSMutableArray*arrayfeature3;
     NSMutableArray*arrayfeature4;
    ////////////select new array
    NSMutableArray*selectnew1;
    NSMutableArray*selectnew2;
    NSMutableArray*selectnew3;
    NSMutableArray*selectnew4;
    NSMutableArray*selectnew5;
    ////////////select frature array
    NSMutableArray*selectfeature1;
    NSMutableArray*selectfeature2;
    NSMutableArray*selectfeature3;
    NSMutableArray*selectfeature4;
    NSMutableArray*selectfeature5;
    NSString*color;
    NSString*stringcolor;


}

@property(nonatomic,strong)IBOutlet NSString*whatwant;
//////////////////


@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;



@end
