//
//  DOBView2ViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOBView2ViewController : UIViewController
{
  //  IBOutlet UIDatePicker *datePicker;
    IBOutlet UILabel *datelabel;
}
-(IBAction)BackView:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;

@property(nonatomic,strong)IBOutlet UIButton * Save_Button;
//@property(nonatomic,retain) UIDatePicker *datePicker;
@property(nonatomic,retain) IBOutlet UILabel *datelabel;

@property(nonatomic,retain) IBOutlet UIButton *datelabel_Button;
@property(nonatomic,retain) IBOutlet UITextField *datelabel_txt;


@end
