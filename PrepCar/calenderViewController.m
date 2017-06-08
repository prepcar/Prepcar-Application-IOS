//
//  calenderViewController.m
//  PrepCar
//
//  Created by anil on 13/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import "calenderViewController.h"
#import "UIImageView+WebCache.h"
#import "Haneke.h"
#import "AcceptViewController.h"

@interface calenderViewController ()

@end

@implementation calenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self notificationlistmethod];
}

-(void)viewWillAppear:(BOOL)animated{
    [self notificationlistmethod];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return arrynotification.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"notificationcell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text= [[arrynotification objectAtIndex:indexPath.row]valueForKey:@"buyer_name"];
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:101];
    label1.text= [[arrynotification objectAtIndex:indexPath.row]valueForKey:@"date"];
    
    
    UILabel *label2 = (UILabel *)[cell viewWithTag:102];
    NSString*strname=[[arrynotification valueForKey:@"make"]objectAtIndex:0];
    
    NSString*strvicle=[[arrynotification valueForKey:@"model_year"]objectAtIndex:0];
    
    NSString*stryear=[[arrynotification valueForKey:@"model_type"]objectAtIndex:0];
    NSArray *myStrings = [[NSArray alloc] initWithObjects: strvicle, strname,stryear, nil];
    NSString *joinedString = [myStrings componentsJoinedByString:@" "];
    NSString *trimmed = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *trimmedString = [trimmed stringByReplacingOccurrencesOfString:@" " withString:@" "];
    label2.text=[NSString stringWithFormat:@"%@",trimmedString];
    
    UILabel *label3 = (UILabel *)[cell viewWithTag:103];
    label3.text=[[arrynotification objectAtIndex:indexPath.row]valueForKey:@"time"];
    
    
    
    UIImageView *imglogo = (UIImageView *)[cell viewWithTag:104];
    imglogo.clipsToBounds = YES;
    imglogo.layer.cornerRadius = imglogo.frame.size.width / 2;
    NSString*strimage=[[arrynotification objectAtIndex:indexPath.row]valueForKey:@"single_car_pic"];
    NSURL*url=[NSURL URLWithString:strimage];
    if ([strimage isEqualToString:@""]) {
        imglogo.image = [UIImage imageNamed:@"no-image"];
    }
    else{
        
        [imglogo hnk_setImageFromURL:url];
    }
    
    UIImageView *imageplan = (UIImageView *)[cell viewWithTag:250];
    strplan=[[arrynotification objectAtIndex:indexPath.row] valueForKey:@"confirm_status"];
    strsold=[[arrynotification objectAtIndex:indexPath.row] valueForKey:@"appointment_status"];
    value = [strplan intValue];
    value1=[strsold intValue];
    if (value==0) {
        imageplan.image = [UIImage imageNamed:@"new@"];
    }
    else if (value==2){
            imageplan.image = [UIImage imageNamed:@"new3"];
        }
        else {
            if (value1==1) {
                imageplan.image = [UIImage imageNamed:@"new-1"];
            }
            else{
                imageplan.image = [UIImage imageNamed:@"accepted@"];
            }
            
        }
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    testdriveid = [[arrynotification objectAtIndex:indexPath.row]valueForKey:@"testdrive_id"];
    [[NSUserDefaults standardUserDefaults] setObject:testdriveid forKey:@"testdrive"];
    AcceptViewController * SV = [[AcceptViewController alloc]init];
    SV.dataString = [arrynotification objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:SV.dataString forKey:@"cardetail"];
        
   [self performSegueWithIdentifier:@"pushtoaccept" sender:nil];
}

-(void)notificationlistmethod{
    if (!isWifiAvailable)
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:kErrorConnectionMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [[AppManager sharedManager] removeLoadingWindow];
        return;
    }
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:user,@"dealer_id", nil];
    
    NSLog(@"%@",postDictionary);
    
    [[AppManager sharedManager] addLoadingWindow];
    NSString *strUrl=[NSString stringWithFormat:@"%@testdrivelist",kURl];
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
            
            arrynotification =[responseArray valueForKey:@"data"];
            //[KSToastView ks_showToast:[responseArray objectForKey:@"message"] duration:2.0f];
            [[AppManager sharedManager] removeLoadingWindow];
            [tblnotification reloadData];
            
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
