//
//  SinupStepOneViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinupStepTwoViewController.h"
#import "NameView1ViewController.h"
#import "DOBView2ViewController.h"
#import "GenderView3ViewController.h"
#import "LocationView4ViewController.h"
#import "LanguagesView5ViewController.h"
#import "AboutView6ViewController.h"

@interface SinupStepOneViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)IBOutlet UIButton * ProfileImgButton;
@property(nonatomic,strong)IBOutlet UIButton * nextButton;

@property(nonatomic,strong)IBOutlet UIImageView * ProfileBackImg;

@property(nonatomic,strong)IBOutlet UIButton * Male_Button;
@property(nonatomic,strong)IBOutlet UIButton * Female_Button;

@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)IBOutlet UIView * ViewTap1;
@property(nonatomic,strong)IBOutlet UIView * ViewTap2;
@property(nonatomic,strong)IBOutlet UIView * ViewTap3;
@property(nonatomic,strong)IBOutlet UIView * ViewTap4;
@property(nonatomic,strong)IBOutlet UIView * ViewTap5;
@property(nonatomic,strong)IBOutlet UIView * ViewTap6;


@property(nonatomic,strong)IBOutlet UILabel * Label_AddPic;
@property(nonatomic,strong)IBOutlet UILabel * Label_MumadI;

@property(nonatomic,strong)IBOutlet UILabel * LabelEmoji;
- (IBAction)TextField_Emoji11:(id)sender;
- (IBAction)TextField_Emoji22:(id)sender;
- (IBAction)TextFileld_Emoji33:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji11;
@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji22;
@property (strong, nonatomic) IBOutlet UITextField *TextField_Emoji33;

@property (strong, nonatomic) IBOutlet UIView *TextField_Emoji11View;
@property (strong, nonatomic) IBOutlet UIView *TextField_Emoji22View;
@property (strong, nonatomic) IBOutlet UIView *TextField_Emoji33View;



@property(nonatomic,strong)IBOutlet UILabel * Labelname;
@property(nonatomic,strong)IBOutlet UILabel * LabelGender;
@property(nonatomic,strong)IBOutlet UILabel * LabelDOB;
@property(nonatomic,strong)IBOutlet UILabel * LabelSpeak;
@property(nonatomic,strong)IBOutlet UILabel * LabelAbout;
@property(nonatomic,strong)IBOutlet UILabel * LabelLives;
-(IBAction)ChangeImageProfile:(id)sender;
-(IBAction)NextView:(id)sender;
-(IBAction)Button_Male:(id)sender;
-(IBAction)Button_Female:(id)sender;
@end
