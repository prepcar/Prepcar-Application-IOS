//
//  AppDelegate.m
//  PrepCar
//
//  Created by Devendra on 11/2/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "AppDelegate.h"
#import "DashboardTableViewController.h"
#import "Reachability.h"
#import "LoginUserViewController.h"
#import "startViewController.h"
#import "DDashboardViewController.h"
#import "AGPushNoteView.h"
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize Devise_ID,RollID,str_USERID,rating;

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    if(curReach == internetReach)
    {
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        BOOL connectionRequired= [curReach connectionRequired];
        NSString* statusString= @"";
        switch (netStatus)
        {
            case NotReachable:
            {
                statusString = @"Access Not Available";
                //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
                connectionRequired= NO;
                //isWifiAvailable=NO;
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isWifiAvailable"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                break;
            }
                
            case ReachableViaWWAN:
            {
                statusString = @"Reachable WWAN";
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isWifiAvailable"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                break;
            }
            case ReachableViaWiFi:
            {
                statusString= @"Reachable WiFi";
                //isWifiAvailable=YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isWifiAvailable"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                break;
            }
        }
        if(connectionRequired)
        {
            statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
        }
        NSLog(@"%@",statusString);
    }
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    UIDevice *device = [UIDevice currentDevice];
    
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    //NSLog(@"%@",currentDeviceId);
    Devise_ID = currentDeviceId;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    [GMSPlacesClient provideAPIKey:@"AIzaSyCoIiBVYyUntKhoIKgK-mIlPwiQF6IPQfE"];
    //Change the host name here to change the server your monitoring
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateInterfaceWithReachability: internetReach];
    BOOL isLoggedIn=[[NSUserDefaults standardUserDefaults] boolForKey:kISLoggedIn];
    if (isLoggedIn) {
        NSString *rollID=[[NSUserDefaults standardUserDefaults] objectForKey:kLoggedInUserRollID];
        if ([rollID isEqualToString:@"4"]) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabview = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
            UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:tabview];
            [nav setNavigationBarHidden:YES animated:NO];
            nav.title=@"ACTIVE LEADS";
            self.window.rootViewController=nav;
        
        }
    
        else{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *tabview1 = [storyBoard instantiateViewControllerWithIdentifier:@"TabViewController"];
            UINavigationController*nav1=[[UINavigationController alloc]initWithRootViewController:tabview1];
           nav1.navigationBar.barTintColor = RGB(41, 58, 146);
            self.window.rootViewController=nav1;
            
            
        }

    }

    return YES;
}



- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // NS_AVAILABLE_IOS(8_0);
{
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    NSLog(@"deviceToken: %@", deviceToken);
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"tokenname"];
    
    NSLog(@"token: %@", token);
}
////////////////push notification

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
   
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
  
    NSString*str=[userInfo valueForKeyPath:@"aps.badge"];
    NSString*newcount=[NSString stringWithFormat:@"%@",str];
    [[NSUserDefaults standardUserDefaults]setObject:newcount forKey:@"count"];
    NSString *rollID=[[NSUserDefaults standardUserDefaults] objectForKey:kLoggedInUserRollID];
    NSString*str1=[userInfo valueForKeyPath:@"aps.alert"];
    if ([rollID isEqualToString:@"4"]){
        if (application.applicationState == UIApplicationStateBackground) {
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            startViewController *controller = (startViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"start"];
            [navigationController pushViewController:controller animated:YES];
            navigationController.navigationBar.barTintColor = RGB(41, 58, 146);
            
        }
        else if (application.applicationState == UIApplicationStateActive){
           
            [AGPushNoteView showWithNotificationMessage:[NSString stringWithFormat:@"%@", str1]];
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"sms-alert-5-daniel_simon"
                                                                  ofType:@"wav"];
            NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_notificationSound);
            AudioServicesPlaySystemSound(_notificationSound);
            [AGPushNoteView setMessageAction:^(NSString *message) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PREP CAR NOTIFICATION"
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
                [alert show];
            }];
            
        }
        else{
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            startViewController *controller = (startViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"start"];
            [navigationController pushViewController:controller animated:YES];
            navigationController.navigationBar.barTintColor = RGB(41, 58, 146);
        }
    } else {
        if (application.applicationState == UIApplicationStateBackground) {
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            DDashboardViewController *controller = (DDashboardViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"desboard"];
            [navigationController pushViewController:controller animated:YES];
            navigationController.navigationBar.barTintColor = RGB(41, 58, 146);
        }
        else if (application.applicationState == UIApplicationStateActive){
            [AGPushNoteView showWithNotificationMessage:[NSString stringWithFormat:@"%@", str1]];
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"sms-alert-5-daniel_simon"
                                                                  ofType:@"wav"];
            NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_notificationSound);
            AudioServicesPlaySystemSound(_notificationSound);
            [AGPushNoteView setMessageAction:^(NSString *message) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PREP CAR NOTIFICATION"
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
                [alert show];
            }];
        }
        else{
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            DDashboardViewController *controller = (DDashboardViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"desboard"];
            [navigationController pushViewController:controller animated:YES];
            navigationController.navigationBar.barTintColor = RGB(41, 58, 146);
        }
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


//Send carplan buy buyer : 1
//Request accept\decline buy dealerData : 2
//
//dealer send some deals : 3
//buyer send message to dealer : 4

/////////
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        //[self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [FBSession.activeSession closeAndClearTokenInformation];
        NSLog(@"Logged out of facebook");
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            NSString* domainName = [cookie domain];
            NSRange domainRange = [domainName rangeOfString:@"facebook"];
            if(domainRange.length > 0)
            {
                [storage deleteCookie:cookie];
            }
        }
        // [closeAndClearTokenInformation];
        //[self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            //  [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                //  [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                //  [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        //[FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
    
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

-(void)DelegateObj
{
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
