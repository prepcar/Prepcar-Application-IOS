//
//  ProfileViewController.h
//  PrepCar
//
//  Created by Devendra on 12/26/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController :UIViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
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
    
    SHViewPager *viewPager;
        UIImagePickerController *imagePickerController;
      CGFloat TitleFontsize;
    
    IBOutlet UIButton*btnabout;
    IBOutlet UIButton*btnterms;
    IBOutlet UIButton*btnprivacy;
    IBOutlet UIButton*btncontact;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_ProfilePic;
- (IBAction)btn_UpdateAction:(id)sender;

@end
