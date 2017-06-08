//
//  UserCardView.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/11/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//


#import "CardView.h"
#import "DraggableCardView.h"
#import "OverlayView.h"


@interface CardView ()<DraggableCardViewDelegate>
@end


@implementation CardView



#pragma mark - LifeCycle


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [super setup];
    _ProImg.layer.cornerRadius = _ProImg.frame.size.width / 2;
    _ProImg.layer.borderWidth = 2;
    _ProImg.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    _ProImg.clipsToBounds = YES;
    _ProImg.contentMode = UIViewContentModeScaleAspectFill;
    _swipeimg.contentMode = UIViewContentModeScaleAspectFill;
    _swipeimg.clipsToBounds = YES;
    
    _btnnope.layer.borderColor=RGB(192, 208, 227).CGColor;
    _btnnope.layer.borderWidth=2.0f;
    _btnnope.layer.cornerRadius=15.0f;
    
    _btnmaybe.layer.borderColor=RGB(192, 208, 227).CGColor;
    _btnmaybe.layer.borderWidth=2.0f;
    _btnmaybe.layer.cornerRadius=15.0f;
    
    _btnloveit.layer.borderColor=RGB(192, 208, 227).CGColor;
    _btnloveit.layer.borderWidth=2.0f;
    _btnloveit.layer.cornerRadius=15.0f;
    

    
    
    UITapGestureRecognizer *tapApproveImageViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonAction)];
    // * Pass the touch to the next responder
    tapApproveImageViewGesture.cancelsTouchesInView = NO;
    //[self.approveImageView addGestureRecognizer:tapApproveImageViewGesture];
    
    UITapGestureRecognizer *tapRejectImageViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonAction)];
    tapRejectImageViewGesture.cancelsTouchesInView = NO;
   // [self.rejectImageView addGestureRecognizer:tapRejectImageViewGesture];
}

-(IBAction)btnnope:(UIButton*)object{
        _rating =2;
        NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_rating],@"Rating", nil];
        
        NSLog(@"%ld",self.superview.tag);
        NSDictionary *dicttag=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",self.btnnope.superview.tag],@"tag", nil];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"RateViewValue" object:dicttag userInfo:dict];
        
        //[self.delegate tapDidRateView:self rating:self.rating];
    }
    


-(IBAction)btnmaybe:(id)sender{
    _rating =3;
    NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_rating],@"Rating", nil];
    
    NSLog(@"%ld",self.superview.tag);
    NSDictionary *dicttag=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",self.btnmaybe.superview.tag],@"tag", nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RateViewValue" object:dicttag userInfo:dict];
    
}

-(IBAction)btnlove:(id)sender{
    _rating =5;
    NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_rating],@"Rating", nil];
    
    NSLog(@"%ld",self.superview.tag);
    NSDictionary *dicttag=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",self.btnloveit.superview.tag],@"tag", nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RateViewValue" object:dicttag userInfo:dict];
}


@end
