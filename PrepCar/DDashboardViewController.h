//
//  DDashboardViewController.h
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString*strplan;
    int value;
    NSString*title;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *tbl_BuyerList;

@end
