//
//  NotificationdealerViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationdealerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *array ;
    NSMutableArray*addressarray;
}
@property (strong, nonatomic) IBOutlet UITableView *Tbl_View;

@end
