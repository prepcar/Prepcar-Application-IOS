//
//  SearchViewController.h
//  PrepCar
//
//  Created by Devendra on 1/9/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate,PlaceSearchTextFieldDelegate,CLLocationManagerDelegate>
{
    IBOutlet UILabel* lbllocation;
    IBOutlet UILabel* lblmiles;
    IBOutlet UILabel* lbllocated;
    IBOutlet UILabel* lbldreamcar;
    IBOutlet UIButton* btnnumbercount;
    IBOutlet UITextField* txtdreamcar;
    IBOutlet UIButton* btnmatches;
    IBOutlet UIButton* btncount1;
    IBOutlet UIButton* btncount2;
    IBOutlet UIButton* btncount3;
    IBOutlet UIButton* btncount4;
    IBOutlet UIButton* btncount5;
    NSString*counting;
    NSMutableArray *arraysearch;
    CLLocationManager *locationManager;

}
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *location;

@end
