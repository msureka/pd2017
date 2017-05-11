//
//  DiscoverUserProfileinfoViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/30/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverUserProfileinfoViewController : UIViewController

@property (nonatomic,strong)IBOutlet UIButton* Image_Left;
@property (nonatomic,strong)IBOutlet UIButton* Image_Right;
@property (nonatomic,strong)IBOutlet UIImageView* Back_imageprofile;
@property (nonatomic,strong)IBOutlet UIImageView* Front_imageprofile;
@property (nonatomic,strong)IBOutlet UILabel* Label_Name;
@property (nonatomic,strong)IBOutlet UILabel* Label_CityCountry;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji1;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji2;
@property (nonatomic,strong)IBOutlet UILabel* Label_Emoji3;
@property (nonatomic,strong)IBOutlet UITextView* Label_Desc;
@property (nonatomic,strong)IBOutlet UILabel* Label_Favtitle;

@property (nonatomic,strong)IBOutlet UIView* ViewMainView;

-(IBAction)Back_button:(id)sender;
-(IBAction)Back_buttonView:(id)sender;

@property (strong,nonatomic)NSMutableArray * Array_UserInfo;

///view hidden info

@property (strong,nonatomic)IBOutlet UILabel * Label_English;
@property (strong,nonatomic)IBOutlet UILabel * Label_Arabic;
@property (strong,nonatomic)IBOutlet UILabel * Label_French;

@property (strong,nonatomic)IBOutlet UILabel * Label_Arabic_Exra;
@property (strong,nonatomic)IBOutlet UILabel * Label_French_Extra;

@property (strong,nonatomic)IBOutlet UILabel * Label_LikePllay;
@property (strong,nonatomic)IBOutlet UILabel * Label_LetMeet;

@property (strong,nonatomic)IBOutlet UILabel * Label_Activity1;
@property (strong,nonatomic)IBOutlet UILabel * Label_Activity2;
@property (strong,nonatomic)IBOutlet UILabel * Label_Activity3;

@property (strong,nonatomic)IBOutlet UILabel * Label_Suprhero;

@property (strong,nonatomic)IBOutlet UIImageView * image_likeplay;
@property (strong,nonatomic)IBOutlet UIImageView * image_letmeey;











@end
