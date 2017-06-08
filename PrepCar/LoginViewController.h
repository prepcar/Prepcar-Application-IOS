//
//  LoginViewController.h
//  PrepCar
//
//  Created by Devendra on 12/20/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
__weak IBOutlet UIButton *btn_Dealer;
    __weak IBOutlet UIButton *btn_buyer;
}
- (IBAction)btn_BuyerLoginAction:(id)sender;
- (IBAction)btn_dealerLoginAction:(id)sender;

@end
