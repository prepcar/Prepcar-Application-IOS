//
//  AppDelegate.h
//  PrepCar
//
//  Created by Devendra on 11/2/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <UserNotifications/UserNotifications.h>
@class  DashboardTableViewController;
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

    {
        Reachability *internetReach;
         SystemSoundID _notificationSound;
        
        
        
    }
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, assign) CGFloat rating;
@property (strong, nonatomic) UINavigationController *viewController;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
+ (AppDelegate *)sharedDelegate;
@property(nonatomic,retain) NSString *Devise_ID,*str_USERID;
@property(nonatomic,retain) NSString *RollID;
- (void) DelegateObj;
@end

