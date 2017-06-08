//
//  DiscriptionViewController.m
//  PrepCar
//
//  Created by anil on 07/04/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "DiscriptionViewController.h"

@interface DiscriptionViewController ()

@end

@implementation DiscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"DESCRIPTION";
    NSDictionary *titleAttributes =@{
                                     NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;

     NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"strdis"];
     NSString *feature=[[NSUserDefaults standardUserDefaults] objectForKey:@"strfeat"];
     lbldis.text=user;
    lblfeature.text=feature;
    lbldis.layer.cornerRadius=2.0f;
    lbldis.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor grayColor]);
    lbldis.layer.borderWidth=3.0f;
}

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES]; // ios 6
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
