//
//  ChangePasswordViewController.h
//  PrepCar
//
//  Created by Devendra on 12/28/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController :UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txt_Password;
@property (weak, nonatomic) IBOutlet UITextField *txt_newPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_Conformpassword;
@end
