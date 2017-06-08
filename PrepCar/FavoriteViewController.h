//
//  FavoriteViewController.h
//  PrepCar
//
//  Created by Devendra on 1/12/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *Datearray;
    NSMutableArray* favarray;
   
    
}

@property(nonatomic,strong)IBOutlet UITableView*tblfav;

@end
