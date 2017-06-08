//
//  Car'sViewController.h
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Car_sViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

{

    NSMutableArray *arrayDetail;
    NSMutableArray*carid;
    NSIndexPath *selectedindexPath;
    NSIndexPath*myindexpath;
    
}

@property (strong, nonatomic) IBOutlet UITableView *cartbl;
@property(nonatomic,strong) NSString*strunique;

@end
