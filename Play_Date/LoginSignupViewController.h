//
//  LoginSignupViewController.h
//  Spiel_Project2
//
//  Created by Spiel's Macmini on 6/16/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FRHyperLabel.h"
@interface LoginSignupViewController : UIViewController<CLLocationManagerDelegate>
-(IBAction)LoginView:(id)sender;
-(IBAction)signUpView:(id)sender;
-(IBAction)FbLogin:(id)sender;
@property(weak,nonatomic)IBOutlet UILabel *Label_DectLoc;
@property(weak,nonatomic)IBOutlet UIButton *loginBt;
@property(weak,nonatomic)IBOutlet UIButton *SinupBt;
@property(strong,nonatomic)IBOutlet UIButton *FbBt;
@property(strong,nonatomic)IBOutlet UIView *LoginSingViewborder;
@property(strong,nonatomic)NSString  *CountryName;
@property(strong,nonatomic)NSString  *CityName;
@property(strong,nonatomic)NSString  *DeviceToken2;
@property(strong,nonatomic)NSString  *ChannelID2;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet FRHyperLabel *termLabel;


@end
