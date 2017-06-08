//
//  FinanceViewController.h
//  PrepCar
//
//  Created by Devendra on 1/5/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface FinanceViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
////
    IBOutlet UITextField*suggestedamount;
    IBOutlet UIButton*btncalculate;
    /////
    IBOutlet UIScrollView *Scroller2;
    IBOutlet UITextField*income;
    IBOutlet UITextField*txtrent;
    IBOutlet UITextField*amount;
    IBOutlet UITextField*studentamount;
    IBOutlet UIButton*rentyes;
    IBOutlet UIButton*rentno;
    IBOutlet UIButton*mortgageyes;
    IBOutlet UIButton*mortgageno;
    IBOutlet UIButton*loansyes;
    IBOutlet UIButton*loansno;
    IBOutlet UIButton*payment;
    IBOutlet UIButton*choose;
    IBOutlet UIButton*budget;
    IBOutlet UIButton*financeyes;
    IBOutlet UIButton*financeno;
    IBOutlet UILabel*cridetlbl;
    IBOutlet UILabel*downlbl;
    NSMutableArray*paymentarray;
    NSMutableArray*choosearray;
    NSMutableArray*budgetarray;
    NSString*str1;
    NSString*str2;
    NSString*str3;
    NSString*sliderstr;
    NSString*sliderstr1;
    NSString*rentCar;
    NSString*mortgageCar;
    NSString*loanCar;
    NSString*financeCar;
    DropDownListView * Dropobj;
   

    
}
@property(nonatomic,strong)IBOutlet UISlider*cridetscore;
@property(nonatomic,strong)IBOutlet UISlider*downpayment;
@property (strong, nonatomic) IBOutlet NSString *finance;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectedCountryNames;



@end
