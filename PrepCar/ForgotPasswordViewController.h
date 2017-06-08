//
//  ForgotPasswordViewController.h
//  PrepCar
//
//  Created by Devendra on 12/23/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ForgotPasswordViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *txt_EmailId;
- (IBAction)btn_SubmitAction:(id)sender;

@end
