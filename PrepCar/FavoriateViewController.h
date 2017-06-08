//
//  FavoriateViewController.h
//  PrepCar
//
//  Created by anil on 10/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
#import "SDWebImage/UIImageView+WebCache.h"



@interface FavoriateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,SDWebImageManagerDelegate>
{
    NSMutableArray*detailarray;
    NSString*detailstr;
    NSIndexPath *myindexPath;
    NSString*strdealerid;
    NSString*strcarid;
    NSString*txtstr;
    NSString*strpopup;
    NSMutableArray*carpicarray;
    NSMutableArray*showcarpic;
    NSMutableArray*finalpicarray;
    NSMutableArray*commanarray;
    NSString*commanstr;
    NSMutableArray*featurearray;
    NSMutableArray*addarray;
    NSString*strmore;
    NSString*viewmore;
    UIImageView *viewimage;
    NSString*commannewstr;
    NSString*strphone;
    
    IBOutlet UIButton*btncall;
    IBOutlet UIButton*btnsms;
    IBOutlet UIButton*btncross;
    IBOutlet UIView*viewcall;
    IBOutlet UIButton*btncancel;
    IBOutlet UIButton*btnok;
    IBOutlet UIView*viewcomment;
    IBOutlet UITextView*textcomment;
    NSString*caridnew;
    NSString*strsimler;
    NSString*simler;
    IBOutlet UIView*viewdatetime;
    IBOutlet UITextField*txtdate;
    IBOutlet UITextField*txttime;
    IBOutlet UILabel*lblcardetail;
    IBOutlet UIButton*btnoktime;
    IBOutlet UIButton*btncanceltime;
    UIDatePicker*datePickerStart;
    UIDatePicker*TimePickerStart;
    NSString*strdealid;
    NSString*carid;
    NSString*strratingid;
    UIImage*newimage;
    
    

   
   
}

@property (nonatomic,strong)IBOutlet UITableView*detailtbl;
@property (nonatomic,strong) NSCache*imgcatch;


@end
