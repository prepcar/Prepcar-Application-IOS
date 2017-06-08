//
//  CurrentCarViewController.h
//  PrepCar
//
//  Created by Devendra on 1/6/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "ELCImagePickerHeader.h"

@interface CurrentCarViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ELCImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>
{

    IBOutlet UIScrollView *Scroller1;
    IBOutlet UITextField*yearbtn;
    IBOutlet UITextField*modelbtn;
    IBOutlet UITextField*makebtn;
    IBOutlet UIButton*conditionbtn;
    IBOutlet UITextField*milagetxt;
    IBOutlet UITextView*txtdetail;
    IBOutlet UIImageView*carimage;
    UIImagePickerController *imagePickerController;
    NSString*commstr;

    int sliderValue;
    NSString*str;
    NSMutableArray*conditionarray;
    NSString*mystring;
    NSString*mystring1;
    NSString*mystring2;
    NSString*mystring3;
    NSString *imageString;
    NSData * imageDataa;
    NSMutableArray*imgarray;
    NSString*imgstr;
    NSString*jsonStringimage;
    DropDownListView * Dropobj;
    NSMutableArray *images;
    NSMutableArray *addImages;
    NSMutableArray*convertimage;
    NSIndexPath*myindexpath;
    NSMutableArray*array;
    NSData *webdata;
    NSMutableArray*urlarray;


}
@property (weak, nonatomic) IBOutlet UISlider *slider; 

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *viewcollection;
@property (strong, nonatomic)  NSString *currentcar;
@property (strong, nonatomic)  UILabel *lblSelectedCountryNames;
//@property (nonatomic, copy) NSMutableArray *chosenImages;



@end
