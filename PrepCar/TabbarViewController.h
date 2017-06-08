

#import <UIKit/UIKit.h>

@interface TabbarViewController : UITabBarController


@property(nonatomic, assign)int selectedButtonTag;
-(void)changeSelectedIndex:(NSInteger)index;
@end
