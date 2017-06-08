//
//  BDashboardTableViewCell.h
//  PrepCar
//
//  Created by Devendra on 12/23/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDashboardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImage *img_logo;
@property (weak, nonatomic) IBOutlet UIImage *img_BG;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_disc;
@property (weak, nonatomic) IBOutlet UIImageView *img_Icon;
@property (weak, nonatomic) IBOutlet UIImageView *img_BGColor;

@end
