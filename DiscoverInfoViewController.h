//
//  DiscoverInfoViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/9/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverInfoViewController : UIViewController

@property (strong,nonatomic)IBOutlet UILabel * Label_English;
@property (strong,nonatomic)IBOutlet UILabel * Label_Arabic;
@property (strong,nonatomic)IBOutlet UILabel * Label_French;

@property (strong,nonatomic)IBOutlet UILabel * Label_LikePllay;
@property (strong,nonatomic)IBOutlet UILabel * Label_LetMeet;

@property (strong,nonatomic)IBOutlet UILabel * Label_Activity1;
@property (strong,nonatomic)IBOutlet UILabel * Label_Activity2;
@property (strong,nonatomic)IBOutlet UILabel * Label_Activity3;

@property (strong,nonatomic)IBOutlet UILabel * Label_Suprhero;

@property (strong,nonatomic)IBOutlet UIImageView * image_likeplay;
@property (strong,nonatomic)IBOutlet UIImageView * image_letmeey;

@property (strong,nonatomic)NSMutableArray *Alldata_Array;
-(IBAction)Close_Button:(id)sender;

@end
