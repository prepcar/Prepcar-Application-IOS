//
//  CarplanViewController.h
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"

@interface CarplanViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    ///////////discovery
    IBOutlet UILabel*lblidentity;
    IBOutlet UILabel*lblfirstcar;
    IBOutlet UILabel*lblmainuses;;
    IBOutlet UILabel*lblhieght;
    IBOutlet UILabel*lblchildren;
    IBOutlet UILabel*lbldiscount;
    IBOutlet UILabel*lblzipcode;
    IBOutlet UILabel*lblshopping;
    //////////////////finance
    IBOutlet UILabel*lblincome;
    IBOutlet UILabel*lblrent;
    IBOutlet UILabel*lblamountr;
    IBOutlet UILabel*lblmortage;
    IBOutlet UILabel*lblamountm;
    IBOutlet UILabel*lblstudent;
    IBOutlet UILabel*lblamounts;
    IBOutlet UILabel*lblscore;
    IBOutlet UILabel*lblpayment;
    IBOutlet UILabel*lblchoose;
    IBOutlet UILabel*lblbuget;
    IBOutlet UILabel*lbldown;
    ////////////////currentcar
     IBOutlet UILabel*lblyear;
     IBOutlet UILabel*lblmake;
     IBOutlet UILabel*lblmodel;
     IBOutlet UILabel*lblowed;
     IBOutlet UILabel*lblmilage;
     IBOutlet UILabel*lblcondition;
     IBOutlet UILabel*lbldetail;
     NSMutableArray*image;
    NSString*strimg;
   //////////////////////
    IBOutlet UILabel*lblminyear;
    IBOutlet UILabel*lblmaxyear;
    IBOutlet UILabel*lbltype;
    IBOutlet UILabel*lblstyle;
    IBOutlet UILabel*lblmilag;
    IBOutlet UILabel*lblcolor;
    IBOutlet UILabel*lbltrans;
    IBOutlet UILabel*lblpower;
    IBOutlet UILabel*lblprefrience;
    IBOutlet UILabel*lblamerican;
    IBOutlet UILabel*lblasian;
    IBOutlet UILabel*lbleurope;
    IBOutlet UILabel*lblcartype;
    IBOutlet UILabel*lblyearwant;
    IBOutlet UILabel*lblmakewant;
    IBOutlet UILabel*lblmodelwant;
    IBOutlet UILabel*lblfeature;
    IBOutlet UILabel*lblcomment;
    IBOutlet UILabel*lblsearch;
    IBOutlet UIImageView*finalimage;
    IBOutlet UIView*showimageview;
    IBOutlet UIView*backview;
    IBOutlet UIButton*btnmore;
    IBOutlet UIButton*detailreadmore;
    NSString*discriptionstr;
    NSString*strreadmore;

}

@property(nonatomic,strong)IBOutlet UIScrollView*scroller;
@property(nonatomic,strong)IBOutlet UIScrollView*scrollerimage;
@property(nonatomic,strong)IBOutlet UICollectionView*view1;

@property(nonatomic,strong) NSString *carplanId;


@end
