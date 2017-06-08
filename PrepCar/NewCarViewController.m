//
//  NewCarViewController.m
//  PrepCar
//
//  Created by Devendra on 1/6/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "NewCarViewController.h"

@interface NewCarViewController ()

@end

@implementation NewCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"NEW CAR";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:112/255.0f green:190/255.0f blue:102/255.0f alpha:1.0f];
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    UIImage*img=[UIImage imageNamed:@"foot_home_icn"];
    UIBarButtonItem *homebtn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(HomeBtnPressed)];
    [homebtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = homebtn;
}

-(void)HomeBtnPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}




//-(void)viewWillDisappear:(BOOL)animated{
//    [[self navigationController]
//     setNavigationBarHidden:YES
//     animated:NO];
//}

-(IBAction)backBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
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
