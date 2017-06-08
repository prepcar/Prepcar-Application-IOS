//
//  SentViewController.h
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

  NSMutableArray *arraysend ;
    NSIndexPath*myindexpath;
    NSString*detailstr;
    NSIndexPath*selectedindexPath;
    NSMutableArray*arrayimg;

}
@property (strong, nonatomic) IBOutlet UITableView *Table_view;

@end
