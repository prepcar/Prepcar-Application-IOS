
//
//  ViewController.m
//  PrepCar
//
//  Created by Devendra on 11/2/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "ViewController.h"
#import "DashboardTableViewController.h"
#import "GHWalkThroughView.h"
#import "AppDelegate.h"
static NSString * const sampleDesc1 = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tincidunt laoreet diam, id suscipit ipsum sagittis a. ";

static NSString * const sampleDesc2 = @" Suspendisse et ultricies sem. Morbi libero dolor, dictum eget aliquam quis, blandit accumsan neque. Vivamus lacus justo, viverra non dolor nec, lobortis luctus risus.";


static NSString * const sampleDesc3 = @"In interdum scelerisque sem a convallis. Quisque vehicula a mi eu egestas. Nam semper sagittis augue, in convallis metus";



static NSString * const sampleDesc4 = @"Praesent ornare consectetur elit, in fringilla ipsum blandit sed. Nam elementum, sem sit amet convallis dictum, risus metus faucibus augue, nec consectetur tortor mauris ac purus.";

static NSString * const sampleDesc5 = @"Sed rhoncus arcu nisl, in ultrices mi egestas eget. Etiam facilisis turpis eget ipsum tempus, nec ultricies dui sagittis. Quisque interdum ipsum vitae ante laoreet, id egestas ligula auctor";
@interface ViewController ()<GHWalkThroughViewDataSource>

@property (nonatomic, strong) GHWalkThroughView* ghView ;
@property (nonatomic, strong) UILabel* welcomeLabel;
@property (nonatomic, strong) NSArray* descStrings;

@end
@implementation ViewController
{
    bool is_start;
}
- (void)viewDidLoad
{
    bool is_start = false;
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:YES
     animated:NO];
    _ghView = [[GHWalkThroughView alloc] initWithFrame:self.navigationController.view.bounds];
    [_ghView setDataSource:self];
    [_ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
    UILabel* welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  //  welcomeLabel.text = @"Welcome";
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel = welcomeLabel;
    
    self.descStrings = [NSArray arrayWithObjects:sampleDesc1,sampleDesc2, sampleDesc3, sampleDesc4, sampleDesc5, nil];
//    NSString*str =[[NSUserDefaults standardUserDefaults]objectForKey:@"User"];
//    BOOL isFirstLaunch=[[NSUserDefaults standardUserDefaults] boolForKey:@"ISFirstLaunch"];
//    if (!isFirstLaunch) {
//        if ([str isEqualToString:@"4"]) {
//            self.navigationController.navigationBarHidden=YES;
//            [self performSegueWithIdentifier:@"pushtab" sender:self];
//        }
//        else{
//        self.navigationController.navigationBarHidden=YES;
//        [self performSegueWithIdentifier:@"pushnext" sender:self];
//        }
//        return;
//    }


}
-(void)viewWillAppear:(BOOL)animated
{
    if (is_start== true) {
        [self performSegueWithIdentifier:@"LoginFirst" sender:nil];
    }
}
-(NSInteger) numberOfPages
{
    return 3;
}
- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.RollID isEqualToString:@"3"])
    {
            cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"dealer-box_%ld", index+1]];
    }else
    {
            cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"buyer_box_%ld", index+1]];
    }
    //cell.desc = [self.descStrings objectAtIndex:index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*) bgImageforPage:(NSInteger)index
{
    NSString* imageName =[NSString stringWithFormat:@"bg_0%ld.jpg", index+1];
    UIImage* image = [UIImage imageNamed:imageName];
    return image;
}
- (IBAction)btn_BuyerAction:(id)sender {
    is_start= true;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.RollID =@"4";
      self.ghView.isfixedBackground = NO;
    [_ghView setFloatingHeaderView:self.welcomeLabel];
    self.ghView.isfixedBackground = YES;
    self.ghView.bgImage = [UIImage imageNamed:@"bglogo"];
    [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];

    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
    
  
    [self performSegueWithIdentifier:@"LoginFirst" sender:nil];
}

- (IBAction)btn_DealerAction:(id)sender {
    is_start=true;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.RollID =@"3";
    self.ghView.isfixedBackground = NO;
    [_ghView setFloatingHeaderView:self.welcomeLabel];
    self.ghView.isfixedBackground = YES;
    self.ghView.bgImage = [UIImage imageNamed:@"bglogo"];
    [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    
    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
       [self performSegueWithIdentifier:@"LoginFirst" sender:nil];
}
@end
