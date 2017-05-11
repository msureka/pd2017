//
//  ProfileMatchViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/13/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileMatchViewController : UIViewController

@property (strong,nonatomic)IBOutlet UIImageView * ImageBack1;

@property(strong,nonatomic)IBOutlet UIImageView * profileImg1;

@property (strong,nonatomic)IBOutlet UILabel * Labelname;


@property (strong,nonatomic)IBOutlet UIView * DiscoverViewInfo;

@property (strong,nonatomic)IBOutlet UIButton * Button_letchat1;
@property (strong,nonatomic)IBOutlet UIButton * Button_later1;
-(IBAction)Button_letschat:(id)sender;
-(IBAction)Button_later:(id)sender;
@property (strong,nonatomic)NSMutableArray * AllArray_data;

@end
