//
//  ProfiledealerViewController.h
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfiledealerViewController :UIViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UITextField *txt_FirstName;
    __weak IBOutlet UITextField *txt_emailID;
    __weak IBOutlet UITextField *txt_Address;
    IBOutlet UIScrollView*scroller1;
    
    __weak IBOutlet UITextField *txt_LastName;
    __weak IBOutlet UITextField *txt_phoneNo;
    __weak IBOutlet UITextField *txt_state;
    __weak IBOutlet UITextField *txt_City;
    __weak IBOutlet UITextField *txt_zipcode;
    UIImagePickerController *imagePickerController;
    CGFloat TitleFontsize;
    IBOutlet UIButton*btnabout;
    IBOutlet UIButton*btnterms;
    IBOutlet UIButton*btnprivacy;
    IBOutlet UIButton*btncontact;
    IBOutlet UITextField*txtdealername;
    IBOutlet UITextField*txtdealershipcode;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_ProfilePic;
- (IBAction)btn_UpdateAction:(id)sender;


@end
