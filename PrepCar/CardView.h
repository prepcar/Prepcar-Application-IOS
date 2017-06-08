//
//  UserCardView.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/11/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableCardView.h"

 

@interface CardView : DraggableCardView <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UILabel *lblamount;
@property (weak, nonatomic) IBOutlet UIImageView *ProImg;
@property (weak, nonatomic) IBOutlet UIImageView *swipeimg;
@property (weak, nonatomic) IBOutlet UILabel *lbldetail;
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblcomment;
@property (weak, nonatomic) IBOutlet UILabel *lblfeature;
@property (weak, nonatomic) IBOutlet UILabel *lblnickname;
@property (weak, nonatomic) IBOutlet UILabel *lblpayment;
@property (weak, nonatomic) IBOutlet UIButton *btnnope;
@property (weak, nonatomic) IBOutlet UIButton *btnmaybe;
@property (weak, nonatomic) IBOutlet UIButton *btnloveit;


/////
@property (weak, nonatomic) IBOutlet UILabel *lbldealername;

@property (weak, nonatomic) NSString*strrating;
@property (nonatomic, assign) NSInteger rating;



@end
