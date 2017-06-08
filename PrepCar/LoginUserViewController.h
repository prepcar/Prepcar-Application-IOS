//
//  LoginUserViewController.h
//  PrepCar
//
//  Created by Devendra on 12/22/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginUserViewController :UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txt_Email;
@property (weak, nonatomic) IBOutlet UITextField *txt_Password;
@property (weak, nonatomic) IBOutlet UILabel *txt_screenTitle;
@property (weak, nonatomic) IBOutlet UIButton*btnsignup;

- (IBAction)btn_LoginAction:(id)sender;

@end
