
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppManager : NSObject <UIAlertViewDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, strong) UIWindow *loadingWindow;
@property (nonatomic, strong) NSCharacterSet *numerics;
@property (nonatomic, strong) NSCharacterSet *alphabets;
@property (nonatomic, strong) NSCharacterSet *alphanumerics;
@property (nonatomic, strong) NSCharacterSet *decimalnumbers;
@property (nonatomic, strong)UIButton *backMenuButton;
@property (nonatomic, strong)UIButton *MenuButton;
@property (nonatomic, strong)UIButton *rightBarButton;
@property (nonatomic, strong)UIButton *searchButton;
@property (nonatomic, strong) UIButton *paddingView;
@property (nonatomic, strong) UIButton *crossButton;

- (void)addLoadingWindow;
- (void)removeLoadingWindow;
- (BOOL)validateEmailWithString:(NSString*)email;
- (BOOL)validateUrl:(NSString *)candidate;
- (UIColor *) colorFromHexString:(NSString *)hexString;
- (UIImage*)scaleAndRotateImage:(UIImage *)rotateImage;
-(NSString *)getUTCFormateDate:(NSDate *)localDate;
- (NSDate *) convertDate:(NSDate *) date toTimeZone:(NSString *) timeZoneAbbreviation;
-(void)fadingTransitionNavigationController:(UINavigationController*)navigationController;
- (unsigned char*)UIImageToByteArray:(UIImage*)image;
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
-(void)textFieldDesignChanged:(NSString*)string txtField:(UITextField*)textField;
-(UIBarButtonItem*)toggelLeftBarButton:(UIViewController*)controller;
-(UIBarButtonItem*)customLeftBarButton:(UIViewController*)controller;
-(UIBarButtonItem*)customRightBarButton:(UIViewController*)controller;
-(NSDate*)dateFromEpocString:(NSString*)epocString;
-(void)textFieldDesignChangedNew:(NSString*)string txtField:(UITextField*)textField;
-(NSMutableAttributedString*)setAttrubuteText:(UIButton*)allBtn String:(NSString*)string;
-(NSMutableAttributedString*)setOtherAttrubuteText:(UIButton*)allBtn String:(NSString*)string;
- (NSNumber *)minutesForTimeString:(NSString *)string;
- (NSNumber *)convertIntoSeconds:(NSString *)string;
- (NSString *)timeFormatted:(int)totalSeconds;
-(void)changeTextFieldDesign:(UITextField*)txtField Image:(UIImage*)image;
- (NSMutableArray *) rgbColorFromHexString:(NSString *)hexString;
-(UIBarButtonItem*)customLeftMenuBarButton:(UIViewController*)controller;
-(UIBarButtonItem*)customRightBarButton:(UIViewController*)controller ImageName:(UIImage*)img;
-(void)removeLeftBarButtonSpace:(UIViewController*)controller;
-(NSString *)allTrimSpacesAndNewline:(NSString *)str;
@end
