//
//  PrivacybuyerViewController.h
//  PrepCar
//
//  Created by anil on 14/04/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacybuyerViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView*webstatement;
    IBOutlet UIActivityIndicatorView*activity;
}

@end
