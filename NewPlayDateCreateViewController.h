//
//  NewPlayDateCreateViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 6/15/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPlayDateCreateViewController : UIViewController
- (IBAction)Cancel_Button:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)IBOutlet UILabel * label_hederTop;
@property(nonatomic,strong)IBOutlet UILabel * label_day;
@property(nonatomic,strong)IBOutlet UILabel * label_date;
@property(nonatomic,strong)IBOutlet UILabel * label_time;
@property(nonatomic,strong)IBOutlet UILabel * label_placeholder;

@property(nonatomic,strong)IBOutlet UITextView * textview_disc;

@property(nonatomic,strong)IBOutlet UITextField * textfield_meetup;
@property(nonatomic,strong)IBOutlet UITextField * textfield_location;

@property(nonatomic,strong)IBOutlet UIDatePicker * Picker_date;
@property(nonatomic,strong)IBOutlet UIButton * Button_invite;

- (IBAction)Invite_Button:(id)sender;
- (IBAction)TextField_Actions:(id)sender;



@end
