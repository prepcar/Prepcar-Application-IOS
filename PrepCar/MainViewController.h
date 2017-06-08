//
//  MainViewController.h
//  PrepCar
//
//  Created by anil on 10/01/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "DraggableCardView.h"



@interface MainViewController : UIViewController 
{
    
    NSMutableArray*dealer;
    NSString*dealerstr;
    NSString*ratestr;
    NSString*carstr;
    NSMutableArray*featurearray;
    NSString*carplane;
    NSString*dealid;
    
    
    
}
@property(nonatomic, strong)NSMutableArray*dealerarray;
@property (weak) id <DraggableCardViewDelegate> delegate;
@property BOOL isComeFromSearch;

@end
