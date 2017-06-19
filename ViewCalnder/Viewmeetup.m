//
//  Viewmeetup.m
//  demotest
//
//  Created by Spiel's Macmini on 6/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "Viewmeetup.h"

@implementation Viewmeetup


-(void)awakeFromNib
{
    [super awakeFromNib];
    _Button_AddCalnder.clipsToBounds=YES;
    _Button_AddCalnder.layer.cornerRadius=_Button_AddCalnder.frame.size.height/2;
    _Button_AddCalnder.layer.borderColor=[UIColor blackColor].CGColor;
    _Button_AddCalnder.layer.borderWidth=1.0f;
    self.clipsToBounds=YES;
    self.layer.cornerRadius=15.0f;
    _Button_cantgo.clipsToBounds=YES;
    _Button_cantgo.layer.cornerRadius=_Button_AddCalnder.frame.size.height/2;
    
    _Button_IM.clipsToBounds=YES;
    _Button_IM.layer.cornerRadius=_Button_AddCalnder.frame.size.height/2;
    
 //   [_textfield becomeFirstResponder];

}



-(void)setupDefaultValues
{
    _Button_AddCalnder.clipsToBounds=YES;
    _Button_AddCalnder.layer.cornerRadius=_Button_AddCalnder.frame.size.height/2;
    _Button_AddCalnder.layer.borderColor=[UIColor blackColor].CGColor;
    _Button_AddCalnder.layer.borderWidth=1.5f;
    [_textfield becomeFirstResponder];
}





    - (IBAction)viewAction:(id)sender
{
    NSLog(@"sachin mokashi");
}
- (IBAction)close:(id)sender
{
    [self removeFromSuperview];
     }

@end
