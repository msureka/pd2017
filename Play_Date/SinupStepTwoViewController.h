//
//  SinupStepTwoViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinupStepOneViewController.h"
#import "SinupStepThreeViewController.h"

@interface SinupStepTwoViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIButton * OutdoorButton;
@property(nonatomic,strong)IBOutlet UIButton * IndoorButton;
@property(nonatomic,strong)IBOutlet UIButton * EveryWhereButton;

@property(nonatomic,strong)IBOutlet UIButton * Next_Button;

@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)NSString * SelctedViewButton;

-(IBAction)OutdoorButtonAct:(id)sender;
-(IBAction)IndoorButtonAct:(id)sender;
-(IBAction)EveryWhereButtonAct:(id)sender;

@property(nonatomic,strong)IBOutlet UILabel * OutdoorButton_Label;
@property(nonatomic,strong)IBOutlet UILabel * IndoorButton_Label;
@property(nonatomic,strong)IBOutlet UILabel * EveryWhereButton_Label;

-(IBAction)BackView:(id)sender;
-(IBAction)NextView:(id)sender;

@end
