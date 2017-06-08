//
//  DiscoveryViewController.h
//  PrepCar
//
//  Created by Devendra on 12/28/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface DiscoveryViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    IBOutlet UIScrollView*scroller;
    IBOutlet UIButton*male;
    IBOutlet UIButton*Female;
    IBOutlet UIButton*other;
    IBOutlet UIButton*caryes;
    IBOutlet UIButton*carno;
    IBOutlet UIButton*tall;
    IBOutlet UIButton*grande;
    IBOutlet UIButton*venti;
    IBOutlet UIButton*smallyes;
    IBOutlet UIButton*smallno;
    IBOutlet UIButton*discountbtn;
    IBOutlet UITextView*note;
    IBOutlet UIButton*savebtn;
    IBOutlet UIButton*mainusesbtn;
    NSString* firstCar;
    NSString*identity;
    NSString*height;
    NSString*small;
    NSMutableArray*mainarray;
    NSMutableArray*discountarray;
    NSString*mystring;
    NSString*mystring1;
    NSMutableArray*arraynew;
    NSMutableArray *selectedObjects;
    NSString*selectstr;
    NSMutableArray*array;
    NSString*strdata;
    DropDownListView * Dropobj;
    
    NSMutableArray*selecteddropDownValues;

    
}

@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;
@property (strong, nonatomic) IBOutlet NSString *type;


@end
