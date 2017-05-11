//
//  SinupStepFiveViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinupStepFourViewController.h"
@interface SinupStepFiveViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)IBOutlet UITextField * Type_Txt;
@property(nonatomic,strong)IBOutlet UIButton * LetPlayButton;
@property(nonatomic,strong)IBOutlet UIButton * Save_Button;
-(IBAction)BackView:(id)sender;
-(IBAction)LetPlayButtonAct:(id)sender;
- (IBAction)TypenameAct:(id)sender;
-(IBAction)SaveButton:(id)sender;
@end
