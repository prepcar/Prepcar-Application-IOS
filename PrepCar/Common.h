
#import<UIKit/UIKit.h>

#ifndef EngNet_Common_h
#define EngNet_Common_h
#define kURl @"http://autonana.com/admin/admin/webservices/"
#define kURl1 @"http://autonana.com/admin/admin/webservices/car_add"
#define kURlcurrent_car @"http://autonana.com/admin/admin/webservices/current_car"
#define kURlEdit_car @"http://autonana.com/admin/admin/webservices/car_edit"
//#define kFacebookProfleURL @"https://graph.facebook.com/%@/picture?type=large"
//#define kCatImageURL @"http://pixelpointtechnology.com/99monkey/uploads/images/small/"

#define isWifiAvailable [[NSUserDefaults standardUserDefaults] boolForKey:@"isWifiAvailable"]
#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBORANGE [UIColor colorWithRed:(62)/255.0 green:(103)/255.0 blue:(57)/255.0 alpha:1]

#define RGBPINK [UIColor colorWithRed:(168)/255.0 green:(0)/255.0 blue:(146)/255.0 alpha:1]
#define currentLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages] objectAtIndex:0] ofType:@"lproj"]]


#define isiPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4 ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define IS_IPHONE_6P ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE
#define IS_IOS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kAppDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kISLoggedIn @"isLoggedIn"
#define kLoggedInUserRollID @"kLoggedInUserRollID"
#define DEVICETYPE @"2"
#define Languagevalue @"language"
#define kISFacebookUser @"isFacebookUser"
#define kLoggedInUserID @"LoggedInUserID"
#define kLoggedUserName @"UserName"
#define kLoggedInPassword @"Password"
#define kErrorConnectionMessage @"Unable to connect server. Please check you internet settings and try again."

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;

@end


static inline UIFont *boldGlaciaFont(CGFloat size) {
    return [UIFont fontWithName:@"GlacialIndifference-Bold" size:size];
}

static inline UIFont *regularGlaciaFont(CGFloat size) {
    return [UIFont fontWithName:@"GlacialIndifference-Regular" size:size];
}

static inline UIFont *lightHelveticaGlaciaFont(CGFloat size) {
    return [UIFont fontWithName:@"HelveticaNeueCE-Light" size:size];
}

static inline double XXRadiansToDegrees(double radians) {
    return radians * 180.0f / M_PI;
}

static inline double XXDegreesToRadians(double degrees) {
    return degrees * M_PI / 180.0f;
}


//@end


#endif

