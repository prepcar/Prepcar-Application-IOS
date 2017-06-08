//
//  FavoriteTableViewCell.m
//  PrepCar
//
//  Created by anil on 06/03/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@implementation FavoriteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imgprofileimage.clipsToBounds = YES;
    _imgprofileimage.contentMode = UIViewContentModeScaleAspectFill;
    _imgfullimage.contentMode = UIViewContentModeScaleAspectFill;
    _imgfullimage.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
