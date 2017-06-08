//
//  FavoriteTableViewCell.h
//  PrepCar
//
//  Created by anil on 06/03/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXRatingView.h"

@interface FavoriteTableViewCell : UITableViewCell

@property (nonatomic,strong)IBOutlet UIImageView*imgprofileimage;
@property (nonatomic,strong)IBOutlet UILabel*lblmake;
@property (nonatomic,strong)IBOutlet UILabel*lblname;
@property (nonatomic,strong)IBOutlet UILabel*lblamount;
@property (nonatomic,strong)IBOutlet UILabel*lbldiscription;
@property (nonatomic,strong)IBOutlet UILabel*lbldealername;
@property (nonatomic,strong)IBOutlet UILabel*lblsecondamount;
@property (nonatomic,strong)IBOutlet UIView*expiredview;


@property (nonatomic,strong)IBOutlet UIButton*btnshare;
@property (nonatomic,strong)IBOutlet UIButton*btndelete;
@property (nonatomic,strong)IBOutlet UIButton*btntestdrive;
@property (nonatomic,strong)IBOutlet UIButton*btnsend;
@property (nonatomic,strong)IBOutlet UIButton*btncontact;
@property (nonatomic,strong)IBOutlet UIScrollView *favroiteview;
@property (nonatomic,strong)IBOutlet UIImageView*imgfullimage;
/////////////////

@property (nonatomic,strong)IBOutlet UILabel*lbllease;
@property (nonatomic,strong)IBOutlet UILabel*lblrate;
@property (nonatomic,strong)IBOutlet UILabel*lblsales;
@property (nonatomic,strong)IBOutlet UILabel*lbldown;
@property (nonatomic,strong)IBOutlet UILabel*lbltrade;
/////////

@property (nonatomic,strong)IBOutlet UIButton*btnviewmore;
@property (nonatomic,strong)IBOutlet UILabel*lbltext;
@property (strong, nonatomic) IBOutlet AXRatingView *ratingView;





@end
