//
//  FriendRequestViewController.h
//  Play_Date
//
//  Created by Spiel on 25/04/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendRequestViewController : UIViewController

@property (nonatomic,strong)IBOutlet UIImageView* Back_imageprofile;
@property (nonatomic,strong)IBOutlet UIImageView* Front_imageprofile;
@property (nonatomic,strong)IBOutlet UILabel* Label_Name;
@property (nonatomic,strong)IBOutlet UILabel* Label_CityCountry;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji1;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji2;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji3;

@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

@property (weak, nonatomic) IBOutlet UIButton *declineButton;


- (IBAction)Accept_Pressed:(id)sender;
- (IBAction)Decline_Pressed:(id)sender;


@property (strong,nonatomic)NSMutableArray * Array_UserInfo;

@end
