//
//  PrivacyViewController.m
//  PrepCar
//
//  Created by anil on 14/04/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "PrivacyViewController.h"
#import "TabViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webstatement.delegate = self;
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activity.color=[UIColor blackColor];
    activity.center=self.view.center;
    [self aboutusmethod];
}


-(void)aboutusmethod{
    NSString *urlString = @"http://autonana.com/admin/pages/privacy";
    [activity startAnimating];
    [activity setHidden:NO];
    webstatement.scrollView.scrollEnabled = YES;
    webstatement.scrollView.contentOffset = CGPointMake(0, 800);
    webstatement.scalesPageToFit = YES;
    [webstatement loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activity startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity stopAnimating];
    activity.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
