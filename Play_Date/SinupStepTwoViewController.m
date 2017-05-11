//
//  SinupStepTwoViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "SinupStepTwoViewController.h"


@interface SinupStepTwoViewController ()
{
    NSString * SelectCategory,*BackViewCheck;
    NSUserDefaults *defaults;
}
@end

@implementation SinupStepTwoViewController
@synthesize OutdoorButton,IndoorButton,EveryWhereButton,HeadTopView,Next_Button,SelctedViewButton,OutdoorButton_Label,IndoorButton_Label,EveryWhereButton_Label;;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    
    OutdoorButton.clipsToBounds=YES;
    OutdoorButton.layer.cornerRadius=OutdoorButton.frame.size.height/2;
//    OutdoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    OutdoorButton.layer.borderWidth=2.0f;
//    
    IndoorButton.clipsToBounds=YES;
    IndoorButton.layer.cornerRadius=IndoorButton.frame.size.height/2;
//    IndoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    IndoorButton.layer.borderWidth=2.0f;
//    
    EveryWhereButton.clipsToBounds=YES;
    EveryWhereButton.layer.cornerRadius=EveryWhereButton.frame.size.height/2;
//    EveryWhereButton.layer.borderColor=[UIColor blackColor].CGColor;
//    EveryWhereButton.layer.borderWidth=2.0f;
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    SelctedViewButton=[defaults valueForKey:@"liketoplay"];
    NSLog(@"ValuesOfSecondView=%@",[defaults valueForKey:@"liketoplay"]);
     NSLog(@"ValuesOfSecondView=%@", [defaults valueForKey:@"liketoplay"]);
     NSLog(@"ValuesOfSecondView=%@", [defaults valueForKey:@"icanmeet"]);
   
    
 
    
    if ([[defaults valueForKey:@"settingpage"] isEqualToString:@"yes"])
    {
       
       
        
        
        if ([[defaults valueForKey:@"liketoplay"] isEqualToString:@"Outdoor"] || [[defaults valueForKey:@"liketoplay"] isEqualToString:@"Indoor"] || [[defaults valueForKey:@"liketoplay"] isEqualToString:@"Everywhere"] )
        {
        
 
        if ([ [defaults valueForKey:@"liketoplay"] isEqualToString:@"Outdoor"] )
        {
            [self OutdoorButtonAct:nil];
        }
        else  if ([[defaults valueForKey:@"liketoplay"] isEqualToString:@"Indoor"])
        {
            [self IndoorButtonAct:nil];
        }
        else  if ( [[defaults valueForKey:@"liketoplay"] isEqualToString:@"Everywhere"] )
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
    
    if ([SelctedViewButton isEqualToString:@"Outdoor"] || [SelctedViewButton isEqualToString:@"Indoor"] || [SelctedViewButton isEqualToString:@"Everywhere"] )
    {
        if ([SelctedViewButton isEqualToString:@"Outdoor"] )
        {
            [self OutdoorButtonAct:nil];
        }
        else  if ([SelctedViewButton isEqualToString:@"Indoor"])
        {
            [self IndoorButtonAct:nil];
        }
        else  if ( [SelctedViewButton isEqualToString:@"Everywhere"] )
        {
            [self EveryWhereButtonAct:nil];
        }
         Next_Button.enabled=YES;
        [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];

       
    }
    else
    {
        [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        Next_Button.enabled=NO;
    }
    
    
    }
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    OutdoorButton.clipsToBounds=YES;
    OutdoorButton.layer.cornerRadius=OutdoorButton.frame.size.height/2;
//    OutdoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    OutdoorButton.layer.borderWidth=2.0f;
//    
    IndoorButton.clipsToBounds=YES;
    IndoorButton.layer.cornerRadius=IndoorButton.frame.size.height/2;
//    IndoorButton.layer.borderColor=[UIColor blackColor].CGColor;
//    IndoorButton.layer.borderWidth=2.0f;
//    
    EveryWhereButton.clipsToBounds=YES;
    EveryWhereButton.layer.cornerRadius=EveryWhereButton.frame.size.height/2;
//    EveryWhereButton.layer.borderColor=[UIColor blackColor].CGColor;
//    EveryWhereButton.layer.borderWidth=2.0f;
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
//    Next_Button.enabled=YES;
    //[Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)OutdoorButtonAct:(id)sender
{
    Next_Button.enabled=YES;
    [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
    
    SelectCategory=@"Outdoor";
    
    OutdoorButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    IndoorButton.backgroundColor=[UIColor clearColor];
    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    
    [defaults setObject:@"Outdoor" forKey:@"liketoplay"];
    [defaults synchronize];
    
    
}
-(IBAction)IndoorButtonAct:(id)sender
{
    Next_Button.enabled=YES;
    [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
    SelectCategory=@"Indoor";
    OutdoorButton.backgroundColor=[UIColor clearColor];
    IndoorButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    EveryWhereButton.backgroundColor=[UIColor clearColor];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    
    [defaults setObject:@"Indoor" forKey:@"liketoplay"];
    [defaults synchronize];
    
}
-(IBAction)EveryWhereButtonAct:(id)sender
{
    Next_Button.enabled=YES;
    [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
    SelectCategory=@"Everywhere";
    OutdoorButton.backgroundColor=[UIColor clearColor];
    IndoorButton.backgroundColor=[UIColor clearColor];
    EveryWhereButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    
    OutdoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    IndoorButton_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    EveryWhereButton_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    
    [defaults setObject:@"Everywhere" forKey:@"liketoplay"];
    [defaults synchronize];
}



-(IBAction)BackView:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
  
}
-(IBAction)NextView:(id)sender
{
  
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        SinupStepThreeViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepThreeViewController"];
        
        [self.navigationController pushViewController:set animated:YES];
    
 
}

@end
