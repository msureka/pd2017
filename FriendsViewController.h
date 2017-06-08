//
//  FriendsViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsSecTwoTableViewCell.h"
#import "FriendsSeconeTableViewCell.h"

@interface FriendsViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(strong,nonatomic)IBOutlet UIScrollView * myscrollView;
@property(nonatomic,strong)IBOutlet UITableView * Table_Friend;
@property(nonatomic,strong)FriendsSecTwoTableViewCell * Cell_Two;
@property(nonatomic,strong)FriendsSeconeTableViewCell * Cell_One;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
- (IBAction)Button_Plus:(id)sender;
-(void)calculate;
@end
