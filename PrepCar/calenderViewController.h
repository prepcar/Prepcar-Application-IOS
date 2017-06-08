//
//  calenderViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calenderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView*tblnotification;
    NSMutableArray*arrynotification;
    NSString*testdriveid;
    NSString*strplan;
    NSString*strsold;
    int value;
    int value1;
}

@end
