//
//  SinupStepFourViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinupStepThreeViewController.h"
#import "SinupStepFiveViewController.h"
@interface SinupStepFourViewController : UIViewController


@property(nonatomic,strong)IBOutlet UIView * HeadTopView;

@property(nonatomic,strong)IBOutlet UIButton * ParkButton;
@property(nonatomic,strong)IBOutlet UIButton * MovieButton;
@property(nonatomic,strong)IBOutlet UIButton * SwimmingButton;

@property(nonatomic,strong)IBOutlet UIButton * BoadgameButton;
@property(nonatomic,strong)IBOutlet UIButton * BakingButton;
@property(nonatomic,strong)IBOutlet UIButton * BikeRidesButton;

@property(nonatomic,strong)IBOutlet UIButton * AnimalButton;
@property(nonatomic,strong)IBOutlet UIButton * SportButton;
@property(nonatomic,strong)IBOutlet UIButton * PlanningButton;

// uday
@property(nonatomic,strong)IBOutlet UIButton * CrawlingButton;
@property(nonatomic,strong)IBOutlet UIButton * BlocksButton;
@property(nonatomic,strong)IBOutlet UIButton * SandpitButton;




@property(nonatomic,strong)IBOutlet UIButton * Next_Button;

-(IBAction)ParkButtonAct:(id)sender;
-(IBAction)MovieButtonAct:(id)sender;
-(IBAction)SwimmingButtonAct:(id)sender;

-(IBAction)BoadgameButtonAct:(id)sender;
-(IBAction)BikeRidesButtonAct:(id)sender;
-(IBAction)BakingButton:(id)sender;

-(IBAction)AnimalButtonAct:(id)sender;
-(IBAction)SportButtonAct:(id)sender;
-(IBAction)PlanningButtonAct:(id)sender;

// uday
-(IBAction)CrawlingButtonAct:(id)sender;
-(IBAction)BlocksButtonAct:(id)sender;
-(IBAction)SandpitButtonAct:(id)sender;


-(IBAction)BackView:(id)sender;
-(IBAction)NextView:(id)sender;

@property(nonatomic,strong)IBOutlet UILabel * Park_Label;
@property(nonatomic,strong)IBOutlet UILabel * Swimmingn_Label;
@property(nonatomic,strong)IBOutlet UILabel * Movie_Label;

@property(nonatomic,strong)IBOutlet UILabel * Boadgamen_Label;
@property(nonatomic,strong)IBOutlet UILabel * BikeRides_Label;
@property(nonatomic,strong)IBOutlet UILabel * Baking_Label;

@property(nonatomic,strong)IBOutlet UILabel * Animal_Label;
@property(nonatomic,strong)IBOutlet UILabel * Sport_Label;
@property(nonatomic,strong)IBOutlet UILabel * Planning_Label;

// uday
@property(nonatomic,strong)IBOutlet UILabel * Crawling_Label;
@property(nonatomic,strong)IBOutlet UILabel * Blocks_Label;
@property(nonatomic,strong)IBOutlet UILabel * Sandpit_Label;



@end
