//
//  ProfileUserViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"

@interface ProfileUserViewController : UIViewController<UIScrollViewDelegate>
@property(strong,nonatomic)IBOutlet UIImageView * profileImg;
@property(strong,nonatomic)IBOutlet UIImageView * profileImg1;
@property(strong,nonatomic)IBOutlet UILabel * LabelName;
@property(strong,nonatomic)IBOutlet UILabel * LabelLocation;
@property(strong,nonatomic)IBOutlet UILabel * LabelEmoji;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
-(IBAction)Button_Setting:(id)sender;
- (IBAction)Button_Help:(id)sender;

@property (nonatomic, strong)IBOutlet UIScrollView *startScreenScrollView;

- (IBAction)TextField_Emoji11:(id)sender;
- (IBAction)TextField_Emoji22:(id)sender;
- (IBAction)TextFileld_Emoji33:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji11;
@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji22;
@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji33;


@property (strong, nonatomic) IBOutlet UIButton *TextField_Emoji11bb;
@property (strong, nonatomic) IBOutlet UIButton *TextField_Emoji22bb;
@property (strong, nonatomic) IBOutlet UIButton *TextField_Emoji33bb;


@end
