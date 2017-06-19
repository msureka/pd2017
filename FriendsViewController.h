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
#import "MymeetupsTableViewCell.h"
@interface FriendsViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(strong,nonatomic)IBOutlet UIScrollView * myscrollView;
@property(nonatomic,strong)IBOutlet UITableView * Table_Friend;
@property(nonatomic,strong)FriendsSecTwoTableViewCell * Cell_Two;
@property(nonatomic,strong)FriendsSeconeTableViewCell * Cell_One;
@property(nonatomic,strong)MymeetupsTableViewCell * Cell_Two2;


@property (nonatomic, retain) UIRefreshControl *refreshControl;
- (IBAction)Button_Plus:(id)sender;
@property(nonatomic,strong)IBOutlet UIButton * Button_Plustap;
@property(nonatomic,strong)IBOutlet UILabel * Label_HeadTop;
- (IBAction)Button_Chatscreen:(id)sender;
- (IBAction)Button_PlayDatescreen:(id)sender;
@property(nonatomic,strong)IBOutlet UIButton * Button_chats;
@property(nonatomic,strong)IBOutlet UIButton * Button_playdates;
-(void)calculate;
@end
