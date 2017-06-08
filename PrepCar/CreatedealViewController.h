//
//  CreatedealViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"


@interface CreatedealViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UILabel*lblname;
    IBOutlet UILabel*lbldiscription;
    IBOutlet UILabel*lblprice;
    IBOutlet UILabel*lblvichel;
    IBOutlet UILabel*deal;
    IBOutlet UILabel*dislimaer;
    IBOutlet UIImageView*imagecar;
    NSMutableArray*detailarray;
    IBOutlet UILabel*lblmonth;
    IBOutlet UILabel*lblintrest;
    IBOutlet UILabel*lblsales;
    IBOutlet UILabel*lbldown;
    IBOutlet UILabel*lbltrade;
    IBOutlet UILabel*lblamount;
    NSString*discriptionstr;
    IBOutlet UIButton*btnmore;
    NSString*strtitle;
    
}
@property(nonatomic,strong) IBOutlet UIScrollView*detailscroll;


@end
