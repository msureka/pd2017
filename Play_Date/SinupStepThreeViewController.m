//
//  SinupStepThreeViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "SinupStepThreeViewController.h"

@interface SinupStepThreeViewController ()
{
      NSUserDefaults *defaults;
}
@end

@implementation SinupStepThreeViewController
@synthesize OutdoorButton,IndoorButton,EveryWhereButton,HeadTopView,Next_Button,selectCatNew,OutdoorButton_Label,IndoorButton_Label,EveryWhereButton_Label;
- (void)viewDidLoad {
    defaults=[[NSUserDefaults alloc]init];
    [super viewDidLoad];
    OutdoorButton.clipsToBounds=YES;
    OutdoorButton.layer.cornerRadius=OutdoorButton.frame.size.height/2;
//    OutdoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    OutdoorButton.layer.borderWidth=2.0f;
    
    IndoorButton.clipsToBounds=YES;
    IndoorButton.layer.cornerRadius=IndoorButton.frame.size.height/2;
//    IndoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    IndoorButton.layer.borderWidth=2.0f;
    
    EveryWhereButton.clipsToBounds=YES;
    EveryWhereButton.layer.cornerRadius=EveryWhereButton.frame.size.height/2;
//    EveryWhereButton.layer.borderColor=[UIColor blackColor].CGColor;
//    EveryWhereButton.layer.borderWidth=2.0f;
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    selectCatNew=[defaults valueForKey:@"icanmeet"];
    if ([[defaults valueForKey:@"settingpage"] isEqualToString:@"yes"])
    {
  
        
        if ([[defaults valueForKey:@"icanmeet"] isEqualToString:@"Mornings"] || [[defaults valueForKey:@"icanmeet"] isEqualToString:@"After School"] || [[defaults valueForKey:@"icanmeet"] isEqualToString:@"Anytime"] )
        {
            if ([[defaults valueForKey:@"icanmeet"] isEqualToString:@"Mornings"] )
            {
                [self OutdoorButtonAct:nil];
            }
            else  if ([[defaults valueForKey:@"icanmeet"] isEqualToString:@"After School"])
            {
                [self IndoorButtonAct:nil];
            }
            else  if ( [[defaults valueForKey:@"icanmeet"] isEqualToString:@"Anytime"] )
            {
                [self EveryWhereButtonAct:nil];
            }
            
            Next_Button.enabled=YES;
             [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        }
        else
        {
            
            Next_Button.enabled=NO;
             [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }

    }
    else
    {
    if ([selectCatNew isEqualToString:@"Mornings"] || [selectCatNew isEqualToString:@"After School"] || [selectCatNew isEqualToString:@"Anytime"] )
    {
        if ([selectCatNew isEqualToString:@"Mornings"] )
        {
            [self OutdoorButtonAct:nil];
        }
        else  if ([selectCatNew isEqualToString:@"After School"])
        {
            [self IndoorButtonAct:nil];
        }
        else  if ( [selectCatNew isEqualToString:@"Anytime"] )
        {
            [self EveryWhereButtonAct:nil];
        }
       
        Next_Button.enabled=YES;
         [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    }
    else
    {
        Next_Button.enabled=NO;
         [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)OutdoorButtonAct:(id)sender
{
      Next_Button.enabled=YES;
    SelectCategory2=@"Mornings";
    
     [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
//    OutdoorButton.backgroundColor=[UIColor yellowColor];
//    IndoorButton.backgroundColor=[UIColor clearColor];
//    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
    

    
    OutdoorButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    IndoorButton.backgroundColor=[UIColor clearColor];
    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    
    
    
    
    
    
    
    [defaults setObject:@"Mornings" forKey:@"icanmeet"];
    [defaults synchronize];
}
-(IBAction)IndoorButtonAct:(id)sender
{
      Next_Button.enabled=YES;
     [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    SelectCategory2=@"After School";
//    OutdoorButton.backgroundColor=[UIColor clearColor];
//    IndoorButton.backgroundColor=[UIColor yellowColor];
//    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    
   
    
    
    OutdoorButton.backgroundColor=[UIColor clearColor];
    IndoorButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    
    
    [defaults setObject:@"After School" forKey:@"icanmeet"];
    [defaults synchronize];
}
-(IBAction)EveryWhereButtonAct:(id)sender
{
      Next_Button.enabled=YES;
     [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    SelectCategory2=@"Anytime";
    
    
//    OutdoorButton.backgroundColor=[UIColor clearColor];
//    IndoorButton.backgroundColor=[UIColor clearColor];
//    EveryWhereButton.backgroundColor=[UIColor yellowColor];
    
    OutdoorButton.backgroundColor=[UIColor clearColor];
    IndoorButton.backgroundColor=[UIColor clearColor];
    EveryWhereButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    
    [defaults setObject:@"Anytime" forKey:@"icanmeet"];
    [defaults synchronize];
}



-(IBAction)BackView:(id)sender
{
   
    
 
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)NextView:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SinupStepFourViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepFourViewController"];
    [self.navigationController pushViewController:set animated:YES];
    
}

@end
