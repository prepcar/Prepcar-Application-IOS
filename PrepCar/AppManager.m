

#import "AppManager.h"
#import "Common.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
//#import "MainVC.h"

@implementation AppManager

+ (instancetype)sharedManager {
    static AppManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    self = [super init];
    return self;
}


- (UIWindow *)loadingWindow {
    if (_loadingWindow) {
        return _loadingWindow;
    }
    _loadingWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    _loadingWindow.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [_loadingWindow makeKeyAndVisible];
    [_loadingWindow setHidden:YES];
    
//    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [activityIndicator setCenter:_loadingWindow.center];
//    [activityIndicator setHidesWhenStopped:YES];
//    [activityIndicator setTag:123456];
//    [_loadingWindow addSubview:activityIndicator];
    
    return _loadingWindow;
}

- (void)addLoadingWindow {
    [self.loadingWindow setHidden:NO];
   // UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.loadingWindow viewWithTag:123456];
    //[aiv startAnimating];
    
    [SVProgressHUD showWithStatus:@"Loading..."];
}

- (void)removeLoadingWindow {
    [SVProgressHUD dismiss];
   // UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.loadingWindow viewWithTag:123456];
    //[aiv stopAnimating];
    [self.loadingWindow setHidden:YES];
}

-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

- (NSDate *) convertDate:(NSDate *) date toTimeZone:(NSString *) timeZoneAbbreviation {
    NSTimeZone *systemZone  = [NSTimeZone systemTimeZone];
    NSTimeZone *zoneUTC     = [NSTimeZone timeZoneWithAbbreviation:timeZoneAbbreviation];
    NSTimeInterval s        = [zoneUTC secondsFromGMT];
    
    NSTimeZone *myZone      = [NSTimeZone timeZoneWithAbbreviation:[systemZone abbreviationForDate:date]];
    NSTimeInterval p        = [myZone secondsFromGMT];
    
    NSTimeInterval i = s+p;
    NSDate *d = [NSDate dateWithTimeInterval:i sinceDate:date];
    
    return d;
    
}

- (unsigned char*)UIImageToByteArray:(UIImage*)image {
    
    unsigned char *imageData = (unsigned char*)(malloc( 4*image.size.width*image.size.height));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef imageRef = [image CGImage];
    CGContextRef bitmap = CGBitmapContextCreate( imageData,
                                                image.size.width,
                                                image.size.height,
                                                8,
                                                image.size.width*4,
                                                colorSpace,
                                                kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage( bitmap, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    
    CGContextRelease( bitmap);
    CGColorSpaceRelease( colorSpace);
    
    return imageData;
}

-(void)fadingTransitionNavigationController:(UINavigationController*)navigationController{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type =kCATransitionFade;
    
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [navigationController.view.layer addAnimation:transition forKey:nil];
}


- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/?=]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (NSCharacterSet *)numerics {
    if (!_numerics) {
        _numerics = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    return _numerics;
}

- (NSCharacterSet *)alphabets {
    if (!_alphabets) {
        _alphabets = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_ "];
    }
    return _alphabets;
}

- (NSCharacterSet *)alphanumerics {
    if (!_alphanumerics) {
        _alphanumerics = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ "];
    }
    return _alphanumerics;
}


- (NSCharacterSet *)decimalnumbers {
    if (!_decimalnumbers) {
        _decimalnumbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    return _decimalnumbers;
}

- (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSMutableArray *) rgbColorFromHexString:(NSString *)hexString {
    NSMutableArray *colorArray=[[NSMutableArray alloc] init];
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    [colorArray addObject:[NSString stringWithFormat:@"%f",red]];
    [colorArray addObject:[NSString stringWithFormat:@"%f",green]];
    [colorArray addObject:[NSString stringWithFormat:@"%f",blue]];
    [colorArray addObject:[NSString stringWithFormat:@"%f",alpha]];
    
    return colorArray;
}


- (UIImage*)scaleAndRotateImage:(UIImage *)rotateImage
{
    
    CGImageRef imgRef = rotateImage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    int kMaxResolution = CGImageGetWidth(imgRef)>CGImageGetHeight(imgRef)?CGImageGetWidth(imgRef):CGImageGetHeight(imgRef); // Or whatever
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = rotateImage.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:fromDateTime
                                                          toDate:toDateTime
                                                         options:0];
    
    return [components day];
    
}


#pragma mark - textField Design Change
-(void)textFieldDesignChanged:(NSString*)string txtField:(UITextField*)textField{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, textField.frame.size.height+40, textField.frame.size.height);
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    textField.font=[UIFont systemFontOfSize:15];
    textField.layer.sublayerTransform=CATransform3DMakeTranslation(8, 0, 0);
    textField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textField.layer.borderWidth=1.0;
    textField.layer.masksToBounds=YES;
    
    _crossButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 7, 20, 20)];
    _crossButton.backgroundColor=[UIColor clearColor];
    [_crossButton setBackgroundImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [view addSubview:_crossButton];
    
    _paddingView = [[UIButton alloc] initWithFrame:CGRectMake(32, -2, textField.frame.size.height+2, textField.frame.size.height+2)];
   // _paddingView.backgroundColor=RGB(15, 111, 201);
    [_paddingView setBackgroundImage:[UIImage imageNamed:@"selectedSearch"] forState:UIControlStateNormal];
    [view addSubview:_paddingView];
    textField.rightView = view;
    textField.rightViewMode = UITextFieldViewModeAlways;

}

#pragma mark - textField Design Change
-(void)textFieldDesignChangedNew:(NSString*)string txtField:(UITextField*)textField{
     textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    textField.font=[UIFont systemFontOfSize:14];
    textField.layer.borderColor=[RGBORANGE CGColor];
    textField.layer.borderWidth= 2.0f;
    textField.layer.sublayerTransform=CATransform3DMakeTranslation(8, 0, 0);
    //textField.layer.cornerRadius=5.0;
    textField.layer.masksToBounds=YES;
    
}

#pragma mark - Custom Left Button
-(UIBarButtonItem*)customLeftBarButton:(UIViewController*)controller{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 56, 36)];
    bgView.backgroundColor=[UIColor clearColor];
    
    _backMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backMenuButton.frame=CGRectMake(0, 4, 56, 30);
    [_backMenuButton setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [_backMenuButton setTitle:@"" forState:UIControlStateNormal];
    [_backMenuButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_backMenuButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    //_backMenuButton.titleEdgeInsets=UIEdgeInsetsMake(0, 7, 0, 0);rightmenubutton
    [bgView addSubview:_backMenuButton];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    return barBtnItem;
    
}

//-(UIBarButtonItem*)customLeftMenuBarButton:(UIViewController*)controller{
//    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:controller];
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(274, 7, 33,19);
//    UIImageView *backImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 33, 19)];
//    backImgView.backgroundColor=[UIColor clearColor];
//     [leftButton setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
//    [leftButton addSubview:backImgView];
//    [mainVC configureRightMenuButton:leftButton];
//    [leftButton addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    return rightBarButtonItem;
//}


-(UIBarButtonItem*)toggelLeftBarButton:(UIViewController*)controller{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 56, 36)];
    bgView.backgroundColor=[UIColor clearColor];
    
    _backMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backMenuButton.frame=CGRectMake(0, 4, 56, 30);
    [_backMenuButton setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [_backMenuButton setTitle:@"" forState:UIControlStateNormal];
    [_backMenuButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_backMenuButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    //_backMenuButton.titleEdgeInsets=UIEdgeInsetsMake(0, 7, 0, 0);
    [bgView addSubview:_backMenuButton];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    return barBtnItem;
    
}


#pragma mark - Custom Right Button
-(UIBarButtonItem*)customRightBarButton:(UIViewController*)controller ImageName:(UIImage*)img{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 2, 31, 35)];
    bgView.backgroundColor=[UIColor clearColor];
    
    _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBarButton.frame=CGRectMake(0, 2, 31, 30);
    [_rightBarButton setBackgroundImage:img forState:UIControlStateNormal];
    [bgView addSubview:_rightBarButton];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    return barBtnItem;
    
}

-(NSDate*)dateFromEpocString:(NSString*)epocString {
    if ([epocString isEqual:[NSNull null]])
        return nil;
    
    NSString* miliMinutes = [epocString substringWithRange:NSMakeRange(6,13)];
    long long minutesSince1970 = [miliMinutes longLongValue] / 1000;
    int timeOffset = [[epocString substringWithRange:NSMakeRange(19,3)] intValue];
    long long minutesOffset = timeOffset * 60 * 60;
    return [NSDate dateWithTimeIntervalSince1970:minutesSince1970 + minutesOffset];
}

-(NSMutableAttributedString*)setAttrubuteText:(UIButton*)allBtn String:(NSString*)string{
    int fontSize=17;
    int wordfontSize=22;
    int newfontSize=10;
    if (IS_IPHONE_6 || IS_IPHONE_6P) {
        fontSize=25;
        wordfontSize=32;
        newfontSize=10;
    }
    
    NSString *allBtnString=[allBtn titleForState:UIControlStateNormal];
    NSMutableAttributedString *allBtnStr = [[NSMutableAttributedString alloc] initWithString:allBtnString];
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(string.length,string.length+6)];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:wordfontSize] range:NSMakeRange(0, string.length)];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:newfontSize] range:NSMakeRange(string.length, 6)];
    
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:RGB(27, 94, 200) range:NSMakeRange(string.length+6,10)];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(string.length+6, 10)];
    
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:RGB(54, 118, 200) range:NSMakeRange(string.length+6+10,allBtnString.length-(string.length+6+10))];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:newfontSize] range:NSMakeRange(string.length+6+10, allBtnString.length-(string.length+6+10))];
    return allBtnStr;
}

-(NSMutableAttributedString*)setOtherAttrubuteText:(UIButton*)allBtn String:(NSString*)string{
    int fontSize=17;
    if (IS_IPHONE_6 || IS_IPHONE_6P) {
        fontSize=25;
    }
    NSMutableAttributedString *allBtnStr = [[NSMutableAttributedString alloc] initWithString:allBtn.titleLabel.text];
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(string.length,string.length+6)];
     [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, string.length)];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(string.length, 6)];
    
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string.length+6,8)];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(string.length+6, 8)];
    
    [allBtnStr addAttribute:NSForegroundColorAttributeName value:RGB(54, 118, 200) range:NSMakeRange(string.length+6+8,allBtn.titleLabel.text.length-(string.length+6+8))];
    [allBtnStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(string.length+6+8, allBtn.titleLabel.text.length-(string.length+6+8))];
    return allBtnStr;
}

- (NSNumber *)minutesForTimeString:(NSString *)string {
    
    NSArray *components = [string componentsSeparatedByString:@":"];
    if (components.count<=1) {
        return 0;
    }
    NSInteger hours   = [[components objectAtIndex:0] integerValue];
    NSInteger minutes = [[components objectAtIndex:1] integerValue];
    //NSInteger seconds = [[components objectAtIndex:2] integerValue];
    
    //return [NSNumber numberWithInteger:(hours * 60 * 60) + (minutes * 60) + seconds];
    return [NSNumber numberWithInteger:(hours * 60) + minutes];
}

- (NSNumber *)convertIntoSeconds:(NSString *)string {
    NSArray *components = [string componentsSeparatedByString:@":"];
    NSInteger hours   = [[components objectAtIndex:0] integerValue];
    NSInteger minutes = [[components objectAtIndex:1] integerValue];
    //NSInteger seconds = [[components objectAtIndex:2] integerValue];
    
    return [NSNumber numberWithInteger:(hours * 60 * 60) + (minutes * 60)];
    //return [NSNumber numberWithInteger:(hours * 60) + minutes];
}


- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

-(void)changeTextFieldDesign:(UITextField*)txtField Image:(UIImage*)image{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height-14 ,txtField.frame.size.height)];
    UIImageView *imgView=[[UIImageView alloc] initWithImage:image];
    imgView.center=paddingView.center;
    [paddingView addSubview:imgView];
    txtField.leftView = paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)removeLeftBarButtonSpace:(UIViewController*)controller{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -16;
    [controller.navigationItem setLeftBarButtonItems:@[negativeSpacer, controller.navigationItem.leftBarButtonItem] animated:NO];

}
-(NSString *)allTrimSpacesAndNewline:(NSString *)str
{
    NSString *newstr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return newstr;
}
@end
