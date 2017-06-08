//
//  HesitantViewController.h
//  PrepCar
//
//  Created by Devendra on 1/7/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "TTRangeSlider.h"

@interface HesitantViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{

    IBOutlet UIScrollView *Scroller3;
    IBOutlet UILabel*lblrange;
    IBOutlet UIButton*btnnew;
    IBOutlet UIButton*btncertified;
    IBOutlet UIButton*btnpre;
    IBOutlet UIButton*btnlease;
    IBOutlet UIButton*anything;
    IBOutlet UIButton*btnecenomy;
    IBOutlet UIButton*btnsuv;
    IBOutlet UIButton*btnsedan;
    IBOutlet UIButton*btnconvertiable;
    IBOutlet UIButton*btncoupe;
    IBOutlet UIButton*btnluxury;
    IBOutlet UIButton*btnrowseat;
    IBOutlet UIButton*btnhatch;
    IBOutlet UIButton*btnspeed;
    IBOutlet UIButton*btnvan;
    IBOutlet UIButton*btntruck;
    IBOutlet UIButton*btneletric;
    IBOutlet UIButton*btndriving;
    IBOutlet UIButton*btnhnew;
    IBOutlet UIButton*btnunder10k;
    IBOutlet UIButton*btnunder30k;
    IBOutlet UIButton*btnunder50k;
    IBOutlet UIButton*btnunder70k;
    IBOutlet UIButton*btnunder100k;
    IBOutlet UIButton*btncolor;
    IBOutlet UIButton*btntransmission;
    IBOutlet UIButton*btnpower;
    IBOutlet UIButton*btnseats;
    IBOutlet UIButton*btnamerican;
    IBOutlet UIButton*btnasian;
    IBOutlet UIButton*btneurope;
    IBOutlet UIButton*btnsave;
    IBOutlet UIButton*btnhybrid;
    NSString*strdata;
    NSString*type;
    NSString*style;
    NSString*mileage;
    NSString*mileagen1;
    NSString*rangestr;
    NSMutableArray*arraycolor;
    NSMutableArray*arraytrasmission;
    NSMutableArray*arraypower;
    NSMutableArray*arrayperifance;
    NSMutableArray*arrayamerica;
    NSMutableArray*arrayasia;
    NSMutableArray*arrayeurope;
    NSMutableArray*SelectedIndex;
    NSString*strcolor;
    NSString*strtransmission;
    NSString*strpower;
    NSString*strseat;
    NSString*stramerica;
    NSString*strasia;
    NSString*streurope;
    NSArray*tempArray;
    NSMutableArray*newTempArray;
    NSString *jsonString;
    NSArray*tempArraydetail;
    NSMutableArray*newTempArraydeatil;
    NSString *jsonStringdetail;
    NSMutableArray*selectamerica;
    NSMutableArray*selectasia;
    NSMutableArray*selecteurope;
    NSMutableArray*selectcolor;
    NSMutableArray*selectprefrience;
    NSString *jsonString3;
    NSString *jsonString4;
    NSString*jsonString5;
    NSString*jsonString6;
    NSString*jsonString7;
    DropDownListView * Dropobj;
    NSString*maxstr;
    NSString*minstr;
    NSMutableArray*newarraydetail;
    NSMutableArray*newarray;
    NSMutableArray*selectedcolorValues;
    NSMutableArray*selectedmainValues;

    NSMutableArray*selectednameValues;

    NSMutableArray*selectedotherValues;
    NSMutableArray*selectedprefienceValues;



}

@property(nonatomic,strong)IBOutlet UISlider*range;
@property (strong, nonatomic) IBOutlet NSString*hasitent;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;

@end
