
#import "TabbarViewController.h"

@interface TabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
   
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
    
    item.selectedImage = [[UIImage imageNamed:@"icon_maunu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.image=[[UIImage imageNamed:@"icon_maunu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //item.title=@"Home";
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    item.imageInsets = UIEdgeInsetsMake(6, 6, -6, -6);
    
    
    
   UITabBarItem* item1 = [self.tabBar.items objectAtIndex:1];
    item1.selectedImage = [[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image=[[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //item1.title=@"Profile";
    item1.imageInsets = UIEdgeInsetsMake(6, 6, -6, -6);

    // here you need to use the icon with the color you want, as it will be rendered as it is
    
   UITabBarItem* item2 = [self.tabBar.items objectAtIndex:2];
    item2.selectedImage = [[UIImage imageNamed:@"icon_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image=[[UIImage imageNamed:@"icon_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.imageInsets = UIEdgeInsetsMake(6, 6, -6, -6);
   // item2.title=@"Message";
   

    
 
    UITabBarItem* item3 = [self.tabBar.items objectAtIndex:3];
    item3.selectedImage = [[UIImage imageNamed:@"foot_white_icon_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image=[[UIImage imageNamed:@"foot_notification_icn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.imageInsets = UIEdgeInsetsMake(6, 6, -6, -6);
     
    
    
    //item3.title=@"Setting";
    
    
    UITabBarItem* item4 = [self.tabBar.items objectAtIndex:4];
    item4.selectedImage = [[UIImage imageNamed:@"foot_white_icon_4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image=[[UIImage imageNamed:@"foot_user_icn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.imageInsets = UIEdgeInsetsMake(6, 6, -6, -6);
    //item4.title=@"Setting";

   
    
    
//      [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(36, 160, 218)} forState:UIControlStateSelected];
// 
    
    //Important line
    self.selectedIndex=0;
  
    [self setDelegate:self];
    
    // Do any additional setup after loading the view.
}
-(void)changeSelectedIndex:(NSInteger)index
{
    self.selectedIndex=index;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Tabar Called");
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (self.selectedIndex==0) {
        [[self navigationController]
         setNavigationBarHidden:YES
         animated:NO];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if (self.selectedIndex==1){
        [[self navigationController]
         setNavigationBarHidden:NO
         animated:NO];
       self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if (self.selectedIndex==2){
        [[self navigationController]
         setNavigationBarHidden:NO
         animated:NO];
        self.navigationItem.rightBarButtonItem = nil;
         self.navigationItem.title = @"";
        UIImage *image = [UIImage imageNamed:@"icon_logo"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
       self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
       
        
    }
    else if (self.selectedIndex==3){
        [[self navigationController]
         setNavigationBarHidden:NO
         animated:NO];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.title = @"NOTIFICATION";
       self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
        
    }
    else if (self.selectedIndex==4){
        [[self navigationController]
         setNavigationBarHidden:NO
         animated:NO];
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(pushback:)];
        [anotherButton setTintColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem = anotherButton;
      self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41/255.0f green:58/255.0f blue:146/255.0f alpha:1.0f];
        self.navigationItem.title = @"";
    }
}
-(IBAction)pushback:(id)sender{
    
           if (!isWifiAvailable)
        {
            [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [[AppManager sharedManager] removeLoadingWindow];
            return;
        }
        NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"user_id", nil];
        
        NSLog(@"%@",postDictionary);
        
        [[AppManager sharedManager] addLoadingWindow];
        NSString *strUrl=[NSString stringWithFormat:@"%@logout",kURl];
        ASIFormDataRequest*  request101=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:strUrl]];
        NSLog(@"Print WebServiceUrl : %@",strUrl);
        [request101 addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        NSMutableString *body = [NSMutableString string];
        [request101 setRequestMethod:@"Post"];
        
        for (NSString *key in postDictionary) {
            NSString *val = [postDictionary objectForKey:key];
            if ([body length])
                [body appendString:@"&"];
            [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String],
             [[val description] urlEncodedUTF8String]];
        }
        
        [request101 appendPostData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request101 setTimeOutSeconds:6000];
        [request101 setDelegate:self];
        [request101 startAsynchronous];
        [request101 setCompletionBlock:^{
            
            NSString*responseSting=[request101 responseString];
            NSMutableDictionary *responseArray=[responseSting JSONValue];
            NSLog(@"%@",responseArray);
            
            if ([[[responseArray valueForKey:@"status"] description] isEqualToString:@"1"]) {
            
                 [self performSegueWithIdentifier:@"lognpush" sender:nil];
                [[AppManager sharedManager] removeLoadingWindow];
            }
            else {
                [KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
                [[AppManager sharedManager] removeLoadingWindow];
            }
            
        }];
        [request101 setFailedBlock:^{
            [[AppManager sharedManager] removeLoadingWindow];
            NSLog(@"error");
        }];
        
    }




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
