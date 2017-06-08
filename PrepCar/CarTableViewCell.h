//
//  CarTableViewCell.h
//  PrepCar
//
//  Created by anil on 25/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_car;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_year;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;

@end
