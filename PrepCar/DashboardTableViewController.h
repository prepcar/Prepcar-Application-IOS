//
//  DashboardTableViewController.h
//  PrepCar
//
//  Created by Devendra on 11/2/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTableViewController : UITableViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
}
@property(atomic,strong)IBOutlet UISegmentedControl *mySegmentedControl;

@end
