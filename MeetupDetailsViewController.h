//
//  MeetupDetailsViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 6/19/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttendingMeetupTableViewCell.h"
#import "InvitemeetupsTableViewCell.h"
#import "InvitemoremeetupTableViewCell.h"
#import "MeetupDetailCellTableViewCell.h"
@interface MeetupDetailsViewController : UIViewController
@property(nonatomic,strong)InvitemeetupsTableViewCell * Cell_One;
@property(nonatomic,strong)AttendingMeetupTableViewCell * Cell_OneOne;
@property(nonatomic,strong)InvitemoremeetupTableViewCell * Cell_three;
@property(nonatomic,strong)MeetupDetailCellTableViewCell * cell_Details;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView * indicator;
@property(nonatomic,strong)IBOutlet UITableView * Table_Friend;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)NSString * eventidvalue;
@property(nonatomic,strong)NSString * Str_Title;
@property(nonatomic,strong)NSString * Str_Location;
@property(nonatomic,strong)NSString * Str_Datetime;

@property (nonatomic, retain) UIRefreshControl *refreshControl;
-(IBAction)Button_BackView:(id)sender;

-(IBAction)Button_share:(id)sender;
@end
