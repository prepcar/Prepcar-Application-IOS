//
//  NotificationdealerViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "NotificationdealerViewController.h"

@interface NotificationdealerViewController ()

@end

@implementation NotificationdealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]
     setNavigationBarHidden:NO
     animated:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    addressarray = [[NSMutableArray alloc] init];
    [self notificationdeletemethod];
    self.tabBarItem.badgeValue = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [self notificationmethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return addressarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"NotificationdealerCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    UILabel *label = (UILabel *)[cell viewWithTag:11];
    label.text= [[addressarray objectAtIndex:indexPath.row]valueForKey:@"created"];
    /////////////////////
    UILabel *label1 = (UILabel *)[cell viewWithTag:12];
    label1.text=[[addressarray objectAtIndex:indexPath.row]valueForKey:@"message"];
   
    
    UIImageView*carimg = (UIImageView *)[cell viewWithTag:101];
    carimg.layer.cornerRadius = carimg.frame.size.width / 2;
    carimg.layer.borderWidth = 1.0f;
    carimg.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:227.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    carimg.clipsToBounds = YES;
    
    return cell;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 3 == 0)
        cell.backgroundColor = [UIColor colorWithRed:213/255.0 green:216/255.0 blue:233/255.0 alpha:1.0f];
    else if(indexPath.row % 2 == 0)
        cell.backgroundColor =[UIColor colorWithRed:247/255.0 green:204/255.0 blue:203/255.0 alpha:1.0f];
    else{
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f];
    }
}


-(void)notificationmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"user_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@notifications",kURl];
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
            addressarray=[responseArray valueForKey:@"data"];
            NSLog(@"%@",addressarray);
            [_Tbl_View reloadData];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[AppManager sharedManager] removeLoadingWindow];
            });
            
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
        }
        else {
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}

-(void)notificationdeletemethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"user_id",nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@notificationread",kURl];
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
            NSMutableArray*array1=[responseArray valueForKey:@"data"];
            NSLog(@"%@",array1);
            
            [[AppManager sharedManager] removeLoadingWindow];
            
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
        }
        else {
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
        }
        
    }];
    [request101 setFailedBlock:^{
        [[AppManager sharedManager] removeLoadingWindow];
        NSLog(@"error");
    }];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [addressarray removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
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
