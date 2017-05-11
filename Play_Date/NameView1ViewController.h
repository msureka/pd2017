//
//  NameView1ViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameView1ViewController : UIViewController
-(IBAction)BackView:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;

@property(nonatomic,strong)IBOutlet UIButton * Save_Button;

@property(nonatomic,strong)IBOutlet UITextField * Fname_Txt;
@property(nonatomic,strong)IBOutlet UITextField * Lname_Txt;
- (IBAction)TextFielAction:(id)sender;







@end
