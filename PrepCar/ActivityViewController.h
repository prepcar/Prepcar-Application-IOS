//
//  ActivityViewController.h
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray*arrayactive;

}
@property(nonatomic,strong)IBOutlet UITableView*tblactive;


@end
