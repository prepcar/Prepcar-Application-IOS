//
//  NotificationViewController.h
//  PrepCar
//
//  Created by anil on 10/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *array ;
    NSMutableArray*addressarray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *Tbl_View;


@end
