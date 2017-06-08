//
//  AcceptViewController.h
//  PrepCar
//
//  Created by anil on 24/04/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcceptViewController : UIViewController
{
    IBOutlet UIImageView*imgcar;
    IBOutlet UILabel*lblname;
    IBOutlet UILabel*lbldate;
    IBOutlet UILabel*lbltime;
    IBOutlet UILabel*lblcar;
    IBOutlet UIView*view1;
    IBOutlet UIView*view2;
    IBOutlet UIButton*btnaccept;
    IBOutlet UIButton*btnresudel;
    IBOutlet UIButton*btnsold;
    IBOutlet UIButton*btnlost;
    IBOutlet UIButton*btnpending;
    IBOutlet UIView*view3;
    NSMutableArray*arraydetail;
    NSString*strappintment;
    NSString*strconfirm;
    NSString*dealstr;

}

@property (nonatomic, retain) NSString* dataString;

@end
