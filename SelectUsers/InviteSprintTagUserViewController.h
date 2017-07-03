//
//  InviteSprintTagUserViewController.h
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 9/1/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTokenInputView.h"


@interface InviteSprintTagUserViewController : UIViewController< UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *Send_Button;
@property (strong, nonatomic)NSMutableArray *Array_InviteUserTags;
//@property (strong, nonatomic) IBOutlet UITableView * Table_ContactView;
-(IBAction)BackButton:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
-(IBAction)SendButtons:(id)sender;
@property(nonatomic,strong)IBOutlet UILabel * label_Result;
//@property (strong, nonatomic) NSMutableArray *selectedNames;

@property(nonatomic,strong)NSString * Str_eventcreate;
@property(nonatomic,strong)NSString * label_day1;
@property(nonatomic,strong)NSString * label_date1;
@property(nonatomic,strong)NSString * label_time1;;
@property(nonatomic,strong)NSString * textview_disc1;
@property(nonatomic,strong)NSString * textfield_meetup1;
@property(nonatomic,strong) NSString * textfield_location1;
@property(nonatomic,strong)IBOutlet NSString * str_checkmorefriends;
@property (strong, nonatomic) NSMutableArray *Names,*Names_UserId;
@end
