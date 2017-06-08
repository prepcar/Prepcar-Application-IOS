//
//  SignUpViewController.h
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController :UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txt_Email;
@property (weak, nonatomic) IBOutlet UITextField *txt_Password;
@property (weak, nonatomic) IBOutlet UITextField *txt_ConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_ZipCode;
@property (weak, nonatomic) IBOutlet UITextField *txt_DelearShipCode;

- (IBAction)btn_SignUpAction:(id)sender;
@end
