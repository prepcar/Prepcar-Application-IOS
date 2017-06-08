//
//  BuyerdetailViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyerdetailViewController : UIViewController
{
    NSMutableArray*detailarray;
    IBOutlet UILabel*lblname;
    IBOutlet UILabel*lbllocation;
    IBOutlet UILabel*lblcomment;
    IBOutlet UIImageView*imgbuyer;
    IBOutlet UIButton*btnaccept;
    
}
@property(nonatomic,strong)NSString *carplansId;
@end
