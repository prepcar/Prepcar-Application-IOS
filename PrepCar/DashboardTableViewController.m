//
//  DashboardTableViewController.m
//  PrepCar
//
//  Created by Devendra on 11/2/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

#import "DashboardTableViewController.h"
#import "AFTableViewCell.h"

@interface DashboardTableViewController ()
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation DashboardTableViewController
{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Hello World";
    CGRect myFrame = CGRectMake(00.0f, 67.0f, 380.0f, 40.0f);
    
    //Array of items to go inside the segment control
    //You can choose to add an UIImage as one of the items instead of NSString
    NSArray *mySegments = [[NSArray alloc] initWithObjects: @"New Matches",
                           @"MyFavs", @"MyFriends Fav", nil];
    
    //create an intialize our segmented control
    self.mySegmentedControl = [[UISegmentedControl alloc] initWithItems:mySegments];
    
    //set the size and placement
    self.mySegmentedControl.frame = myFrame;
    self.mySegmentedControl.tintColor =[UIColor blackColor];
     //self.mySegmentedControl.tintColor =[UIColor clearColor];
    
    //set the style for the segmented control
    self.mySegmentedControl.segmentedControlStyle  = UISegmentedControlStyleBar;
    
    //remove the third index from the control
    [self.mySegmentedControl removeSegmentAtIndex:2
                                         animated:true];
    
    //add another control at the end
    [self.mySegmentedControl insertSegmentWithTitle:@"Brown"
                                            atIndex:3
                                           animated:true];
    
    
    //default the selection to second item
    [self.mySegmentedControl setSelectedSegmentIndex:1];
    
    //attach target action for if the selection is changed by the user
    [self.mySegmentedControl addTarget:self
                                action:@selector(whichColor:)
                      forControlEvents:UIControlEventValueChanged];
    
    //add the control to the view

    UIView*newview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380,106)];
    newview.backgroundColor =[UIColor whiteColor];
        [newview addSubview:self.mySegmentedControl];
    [self.navigationController.view addSubview:newview];
    
}

-(void)loadView
{
    [super loadView];
    
    const NSInteger numberOfTableViewRows = 20;
    const NSInteger numberOfCollectionViewCells = 15;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
    {
        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
        {
            
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            [colorArray addObject:color];
        }
        
        [mutableArray addObject:colorArray];
    }
    
    self.colorArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colorArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    AFTableViewCell *cell = (AFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[AFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(AFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    
    
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
   // cell.backgroundColor = collectionViewArray[indexPath.item];
    
    UILabel *lbl_Carname =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
     UILabel *lbl_CarPrice =[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 100, 40)];
    
    UILabel *lbl_CarDiscription =[[UILabel alloc]initWithFrame:CGRectMake(0, 300, 100, 40)];
    
  //  UILabel *lbl_CarPrice =[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 100, 40)];
       lbl_CarDiscription.text =@"FIAT 500";
        lbl_CarDiscription.textColor =[UIColor darkGrayColor];
       [cell addSubview:lbl_CarDiscription];
    UIImageView *CarImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 300)];
    
    UIImageView *FriendImage =[[UIImageView alloc]initWithFrame:CGRectMake(250, 250, 100, 100)];
     UILabel *lbl_FriendsName =[[UILabel alloc]initWithFrame:CGRectMake(250, 320, 100, 100)];
    lbl_FriendsName.text =@"Gaurav tiwari";
    lbl_FriendsName.textColor =[UIColor darkGrayColor];
    [cell addSubview:lbl_FriendsName];
    FriendImage.image =[UIImage imageNamed:@"car2.png"];
    FriendImage.layer.cornerRadius = FriendImage.frame.size.width / 2;
    FriendImage.clipsToBounds = YES;
    [CarImage addSubview:FriendImage];
    
    CarImage.image =[UIImage imageNamed:@"car1.png"];
    lbl_Carname.text =@"Nexa Scross";
    lbl_Carname.textColor =[UIColor whiteColor];
    [cell addSubview:CarImage];
    lbl_CarPrice.textColor =[UIColor whiteColor];
    lbl_CarPrice.text =@"$10,500";
    [cell addSubview:lbl_CarPrice];

    [CarImage addSubview:lbl_Carname];

    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    AFIndexedCollectionView *collectionView = (AFIndexedCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

@end
