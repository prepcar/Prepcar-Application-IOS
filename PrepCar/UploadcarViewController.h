//
//  UploadcarViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import "DropDownListView.h"

@interface UploadcarViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate,kDropDownListViewDelegate>
{
    IBOutlet UITextField*txtmodel;
    IBOutlet UIScrollView*uploadscroll;
    IBOutlet UITextField*txtmake;
    IBOutlet UITextField*txtyear;
    IBOutlet UIButton*transmissionyes;
    IBOutlet UIButton*transmissionno;
    IBOutlet UITextField*stocktxt;
    IBOutlet UIImageView*carimage1;
    IBOutlet UIButton*choosecar;
    IBOutlet UIButton*uploadcar;
    IBOutlet UIButton*btnfeature;
    NSMutableArray*modearray;
    NSMutableArray*makarray;
    NSMutableArray*typearray;
    NSString*mystring;
    NSString*mystring1;
    NSString*mystring2;
    NSString*imageString;
    NSData *imageDataa;
    NSString*str1;
    NSMutableArray *images;
    NSMutableArray *addImages;
    NSMutableArray*convertimage;
    NSMutableArray*imgarray;
    UIImagePickerController *imagePickerController;
    NSString*jsonStringimage;
    NSString*commstr;
    NSString *carID;
    NSString*caridsecond;
    NSString*imagestr;
    NSMutableArray*imagesArray;
    NSMutableArray*arraycolor;
    NSMutableArray*selectcolor;
    DropDownListView * Dropobj;
    NSString*strdata;
    NSString*featuredata;
    IBOutlet UIButton*btncolor;
    NSString*jsonStringimage1;
    NSMutableArray*arrayfeature;
    NSMutableArray*fraturearray;
    NSString*jsonStringfeature;
    NSString*jsonStringfeature1;
    NSMutableArray*arry_feature;
    NSIndexPath*myindexpath;
    NSData *webdata;
    UIImage*img;
    NSMutableArray*urlarray;
    
}

@property(nonatomic,strong) IBOutlet UICollectionView*uploadview;
@property(nonatomic,strong) NSString*strpast;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;


@end
