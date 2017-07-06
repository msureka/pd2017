//
//  SinupStepFourViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "SinupStepFourViewController.h"

@interface SinupStepFourViewController ()
{
    NSInteger Count;
    NSUserDefaults * defaults;
    NSString * checkView;
    NSArray * Addvalues;
    
}
@end

@implementation SinupStepFourViewController
@synthesize SportButton,SwimmingButton,BakingButton,BoadgameButton,BikeRidesButton,AnimalButton,ParkButton,PlanningButton,MovieButton,HeadTopView,Next_Button,Sport_Label,Park_Label,Planning_Label,Movie_Label,Swimmingn_Label,Baking_Label,BikeRides_Label,Boadgamen_Label,Animal_Label,CrawlingButton,Crawling_Label,BlocksButton,Blocks_Label,SandpitButton,Sandpit_Label;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    CALayer *borderBottom = [CALayer layer];
    Count=0;
  
    borderBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
    [HeadTopView.layer addSublayer:borderBottom];
    
    SportButton.clipsToBounds=YES;
    SportButton.layer.cornerRadius=SportButton.frame.size.height/2;
//    SportButton.layer.borderColor=[UIColor blackColor].CGColor;
//    SportButton.layer.borderWidth=2.0f;
  
    SwimmingButton.clipsToBounds=YES;
    SwimmingButton.layer.cornerRadius=SwimmingButton.frame.size.height/2;
//    SwimmingButton.layer.borderColor=[UIColor blackColor].CGColor;
//    SwimmingButton.layer.borderWidth=2.0f;

    BakingButton.clipsToBounds=YES;
    BakingButton.layer.cornerRadius=BakingButton.frame.size.height/2;
//    BakingButton.layer.borderColor=[UIColor blackColor].CGColor;
//    BakingButton.layer.borderWidth=2.0f;

    BoadgameButton.clipsToBounds=YES;
    BoadgameButton.layer.cornerRadius=BoadgameButton.frame.size.height/2;
//    BoadgameButton.layer.borderColor=[UIColor blackColor].CGColor;
//    BoadgameButton.layer.borderWidth=2.0f;
    
    BikeRidesButton.clipsToBounds=YES;
    BikeRidesButton.layer.cornerRadius=BikeRidesButton.frame.size.height/2;
//    BikeRidesButton.layer.borderColor=[UIColor blackColor].CGColor;
//    BikeRidesButton.layer.borderWidth=2.0f;
    
    AnimalButton.clipsToBounds=YES;
    AnimalButton.layer.cornerRadius=AnimalButton.frame.size.height/2;
//    AnimalButton.layer.borderColor=[UIColor blackColor].CGColor;
//    AnimalButton.layer.borderWidth=2.0f;

    ParkButton.clipsToBounds=YES;
    ParkButton.layer.cornerRadius=ParkButton.frame.size.height/2;
//    ParkButton.layer.borderColor=[UIColor blackColor].CGColor;
//    ParkButton.layer.borderWidth=2.0f;

    MovieButton.clipsToBounds=YES;
    MovieButton.layer.cornerRadius=MovieButton.frame.size.height/2;
//    MovieButton.layer.borderColor=[UIColor blackColor].CGColor;
//    MovieButton.layer.borderWidth=2.0f;

    PlanningButton.clipsToBounds=YES;
    PlanningButton.layer.cornerRadius=PlanningButton.frame.size.height/2;
//    PlanningButton.layer.borderColor=[UIColor blackColor].CGColor;
//    PlanningButton.layer.borderWidth=2.0f;
    
    
    CrawlingButton.clipsToBounds=YES;
    CrawlingButton.layer.cornerRadius=CrawlingButton.frame.size.height/2;
    
    BlocksButton.clipsToBounds=YES;
    BlocksButton.layer.cornerRadius=BlocksButton.frame.size.height/2;
    
    SandpitButton.clipsToBounds=YES;
    SandpitButton.layer.cornerRadius=SandpitButton.frame.size.height/2;
    
    
    
    
    
    checkView=[defaults valueForKey:@"Count"];
    
   
     [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
       Next_Button.enabled=NO;
    if ([[defaults valueForKey:@"settingpage"] isEqualToString:@"yes"])
    {
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Movies"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Movies"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Movies"])
        {
            
            MovieButton.tag=1;
            MovieButton.selected=NO;
            [self   MovieButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Beach"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Beach"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Beach"])
        {
            
            
            SwimmingButton.tag=2;
            
            SwimmingButton.selected=NO;
            [self SwimmingButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Board game"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Board game"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Board game"])
        {
            
            BoadgameButton.tag=3;
            
            BoadgameButton.selected=NO;
            [self BoadgameButtonAct:nil];
            
            
        }
        if([[defaults valueForKey:@"activity1"] isEqualToString:@"Bike rides"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Bike rides"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Bike rides"])
        {
            
            
            BikeRidesButton.tag=4;
            
            BikeRidesButton.selected=NO;
            [self BikeRidesButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Baking"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Baking"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Baking"])
        {
            
            BakingButton.tag=5;
            
            BakingButton.selected=NO;
            [self BakingButton:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Park"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Park"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Park"])
        {
            ParkButton.tag=6;
            ParkButton.selected=NO;
            [self ParkButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Animals"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Animals"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Animals"])
        {
            AnimalButton.tag=7;
            
            AnimalButton.selected=NO;
            
            
            
            [self AnimalButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Sports"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Sports"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Sports"])
        {
            
            SportButton.tag=8;
            SportButton.selected=NO;
            
            
            [self SportButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Painting"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Painting"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Painting"])
        {
            PlanningButton.tag=9;
            
            PlanningButton.selected=NO;
            [self PlanningButtonAct:nil];
        }
        
 
        
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Crawling"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Crawling"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Crawling"])
        {
            CrawlingButton.tag=10;
            
            CrawlingButton.selected=NO;
            [self CrawlingButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Blocks"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Blocks"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Blocks"])
        {
            BlocksButton.tag=11;
            
            BlocksButton.selected=NO;
            [self BlocksButtonAct:nil];
        }
        if ([[defaults valueForKey:@"activity1"] isEqualToString:@"Sandpit"] || [[defaults valueForKey:@"activity2"] isEqualToString:@"Sandpit"] ||[[defaults valueForKey:@"activity3"] isEqualToString:@"Sandpit"])
        {
            SandpitButton.tag=12;
            
            SandpitButton.selected=NO;
            [self SandpitButtonAct:nil];
        }



    
    }
    else
    {
    
    if ([checkView isEqualToString:@"0"])
    {
        ParkButton.tag=0;
        MovieButton.tag=0;
        SwimmingButton.tag=0;
        BoadgameButton.tag=0;
        BikeRidesButton.tag=0;
        BakingButton.tag=0;
        AnimalButton.tag=0;
        SportButton.tag=0;
        PlanningButton.tag=0;
        CrawlingButton.tag = 0;
        BlocksButton.tag = 0;
        SandpitButton.tag = 0;
        Next_Button.enabled=NO;
        [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else
    {
         [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([[defaults valueForKey:@"tag1"] isEqualToString:@"1"])
        {
         
            
                    MovieButton.tag=1;
                    MovieButton.selected=NO;
            [self   MovieButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag2"]isEqualToString:@"2"])
        {
      
           
                    SwimmingButton.tag=2;
            
                    SwimmingButton.selected=NO;
            [self SwimmingButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag3"]isEqualToString:@"3"])
        {
   
                    BoadgameButton.tag=3;
                    
                     BoadgameButton.selected=NO;
            [self BoadgameButtonAct:nil];
            
                
        }
     if ([[defaults valueForKey:@"tag4"]isEqualToString:@"4"])
        {
            
             
                    BikeRidesButton.tag=4;
                    
                    BikeRidesButton.selected=NO;
              [self BikeRidesButtonAct:nil];
        }
      if ([[defaults valueForKey:@"tag5"]isEqualToString:@"5"])
        {
           
                    BakingButton.tag=5;
                
                    BakingButton.selected=NO;
             [self BakingButton:nil];
        }
        if ([[defaults valueForKey:@"tag6"]isEqualToString:@"6"])
        {
            ParkButton.tag=6;
            ParkButton.selected=NO;
            [self ParkButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag7"]isEqualToString:@"7"])
        {
            AnimalButton.tag=7;
                  
          AnimalButton.selected=NO;
                    
               
            
             [self AnimalButtonAct:nil];
        }
         if ([[defaults valueForKey:@"tag8"]isEqualToString:@"8"])
        {
           
                SportButton.tag=8;
                SportButton.selected=NO;
                
            
            [self SportButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag9"]isEqualToString:@"9"])
        {
           PlanningButton.tag=9;
                   
                    PlanningButton.selected=NO;
            [self PlanningButtonAct:nil];
        }
        

        
        if ([[defaults valueForKey:@"tag10"]isEqualToString:@"10"])
        {
            CrawlingButton.tag=10;
            
            CrawlingButton.selected=NO;
            [self CrawlingButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag11"]isEqualToString:@"11"])
        {
            BlocksButton.tag=11;
            
            BlocksButton.selected=NO;
            [self BlocksButtonAct:nil];
        }
        if ([[defaults valueForKey:@"tag12"]isEqualToString:@"12"])
        {
            SandpitButton.tag=12;
            
            SandpitButton.selected=NO;
            [self SandpitButtonAct:nil];
        }
        
      }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ParkButtonAct:(id)sender
{
    if(ParkButton.isSelected==NO)
    {
        
        ParkButton.tag=6;
        //ParkButton.backgroundColor=[UIColor yellowColor];
        
       ParkButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
                Park_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        
        Count=Count+1;
        ParkButton.selected=YES;
         [defaults setObject:@"6" forKey:@"tag6"];
        
    }
    
    else
    {
         [defaults setObject:@"0" forKey:@"tag6"];
        ParkButton.tag=0;
        ParkButton.backgroundColor=[UIColor clearColor];
        Park_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        ParkButton.selected=NO;
    }
    [defaults synchronize];
    [self SelectItems];
}
-(IBAction)MovieButtonAct:(id)sender
{
    if(MovieButton.isSelected==NO)
    {
       [defaults setObject:@"1" forKey:@"tag1"];
        MovieButton.tag=1;
            //MovieButton.backgroundColor=[UIColor yellowColor];
        
        MovieButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Movie_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
                    Count=Count+1;
            MovieButton.selected=YES;

        }
    
    else
    {
         [defaults setObject:@"0" forKey:@"tag1"];
        MovieButton.tag=0;
      MovieButton.backgroundColor=[UIColor clearColor];
         Movie_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
         Count=Count-1;
         MovieButton.selected=NO;
    }
    [defaults synchronize];
   [self SelectItems];
    
}
-(IBAction)SwimmingButtonAct:(id)sender
{
    if(SwimmingButton.isSelected==NO)
    {
        
       [defaults setObject:@"2" forKey:@"tag2"];
      SwimmingButton.tag=2;
           // SwimmingButton.backgroundColor=[UIColor yellowColor];
        SwimmingButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Swimmingn_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        
                 Count=Count+1;
            SwimmingButton.selected=YES;
        
        }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag2"];
         SwimmingButton.tag=0;
        SwimmingButton.backgroundColor=[UIColor clearColor];
         Swimmingn_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
          Count=Count-1;
        SwimmingButton.selected=NO;
    }
    [defaults synchronize];
 [self SelectItems];
}

-(IBAction)BoadgameButtonAct:(id)sender
{
    if(BoadgameButton.isSelected==NO)
    {
        [defaults setObject:@"3" forKey:@"tag3"];
        BoadgameButton.tag=3;
        
       // BoadgameButton.backgroundColor=[UIColor yellowColor];
        BoadgameButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Boadgamen_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        
        Count=Count+1;
        BoadgameButton.selected=YES;
       
    }
    
    else
    {
         [defaults setObject:@"0" forKey:@"tag3"];
            BoadgameButton.tag=0;
        BoadgameButton.backgroundColor=[UIColor clearColor];
     
        Boadgamen_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        
        Count=Count-1;
        BoadgameButton.selected=NO;
    }
 [defaults synchronize];
    [self SelectItems];
}
-(IBAction)BikeRidesButtonAct:(id)sender
{
    
    
    if(BikeRidesButton.isSelected==NO)
    {
        [defaults setObject:@"4" forKey:@"tag4"];
        BikeRidesButton.tag=4;
        
       // BikeRidesButton.backgroundColor=[UIColor yellowColor];
        BikeRidesButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        BikeRides_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        
        Count=Count+1;
        BikeRidesButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag4"];
           BikeRidesButton.tag=0;
        BikeRidesButton.backgroundColor=[UIColor clearColor];
      
        BikeRides_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];

        
        Count=Count-1;
        BikeRidesButton.selected=NO;
    }
    
     [defaults synchronize];
   [self SelectItems];
}
-(IBAction)BakingButton:(id)sender
{
    if(BakingButton.isSelected==NO)
    {
        
        [defaults setObject:@"5" forKey:@"tag5"];
        BakingButton.tag=5;
      //  BakingButton.backgroundColor=[UIColor yellowColor];
        BakingButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Baking_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];

        
        Count=Count+1;
        BakingButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag5"];
        BakingButton.tag=0;
        BakingButton.backgroundColor=[UIColor clearColor];
       
        Baking_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        
        Count=Count-1;
        BakingButton.selected=NO;
    }
     [defaults synchronize];
     [self SelectItems];
}

-(IBAction)AnimalButtonAct:(id)sender
{
    if(AnimalButton.isSelected==NO)
    {
        [defaults setObject:@"7" forKey:@"tag7"];
        AnimalButton.tag=7;
        
        //AnimalButton.backgroundColor=[UIColor yellowColor];
        
        AnimalButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Animal_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        AnimalButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag7"];
          AnimalButton.tag=0;
        AnimalButton.backgroundColor=[UIColor clearColor];
       
        Animal_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        AnimalButton.selected=NO;
    }
     [defaults synchronize];
  [self SelectItems];
}
-(IBAction)SportButtonAct:(id)sender
{
    if(SportButton.isSelected==NO)
    {
        
    [defaults setObject:@"8" forKey:@"tag8"];
        SportButton.tag=8;
      //  SportButton.backgroundColor=[UIColor yellowColor];
        SportButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Sport_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        SportButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag8"];
          SportButton.tag=0;
        SportButton.backgroundColor=[UIColor clearColor];
       
        Sport_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        
        Count=Count-1;
        SportButton.selected=NO;
    }
     [defaults synchronize];
   [self SelectItems];
}
-(IBAction)PlanningButtonAct:(id)sender
{
    if(PlanningButton.isSelected==NO)
    {
        [defaults setObject:@"9" forKey:@"tag9"];
        PlanningButton.tag=9;
        
        //PlanningButton.backgroundColor=[UIColor yellowColor];
        PlanningButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Planning_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        PlanningButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag9"];
           PlanningButton.tag=0;
        PlanningButton.backgroundColor=[UIColor clearColor];
        
        Planning_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        PlanningButton.selected=NO;
    }
     [defaults synchronize];
  [self SelectItems];
}

#pragma mark - buttons

-(IBAction)CrawlingButtonAct:(id)sender;
{
    if(CrawlingButton.isSelected==NO)
    {
        [defaults setObject:@"10" forKey:@"tag10"];
        CrawlingButton.tag=10;
        
        CrawlingButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Crawling_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        CrawlingButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag10"];
        CrawlingButton.tag=0;
        CrawlingButton.backgroundColor=[UIColor clearColor];
        
        Crawling_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        CrawlingButton.selected=NO;
    }
    [defaults synchronize];
    [self SelectItems];
    
}
-(IBAction)BlocksButtonAct:(id)sender;
{
    if(BlocksButton.isSelected==NO)
    {
        [defaults setObject:@"11" forKey:@"tag11"];
        BlocksButton.tag=11;
        
        BlocksButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Blocks_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        BlocksButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag11"];
        BlocksButton.tag=0;
        BlocksButton.backgroundColor=[UIColor clearColor];
        
        Blocks_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        BlocksButton.selected=NO;
    }
    [defaults synchronize];
    [self SelectItems];
    
}
-(IBAction)SandpitButtonAct:(id)sender;
{
    
    if(SandpitButton.isSelected==NO)
    {
        [defaults setObject:@"12" forKey:@"tag12"];
        SandpitButton.tag=12;
        
        SandpitButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Sandpit_Label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        Count=Count+1;
        SandpitButton.selected=YES;
        
    }
    
    else
    {
        [defaults setObject:@"0" forKey:@"tag12"];
        SandpitButton.tag=0;
        SandpitButton.backgroundColor=[UIColor clearColor];
        
        Sandpit_Label.font=[UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        Count=Count-1;
        SandpitButton.selected=NO;
    }
    [defaults synchronize];
    [self SelectItems];
    
}



-(void)SelectItems
{
    [defaults setObject:[NSString stringWithFormat:@"%ld",(long)Count] forKey:@"Count"];
    
    if (Count==3)
    {
        
        Next_Button.enabled=YES;
        
        if (ParkButton.tag==6)
        {
            ParkButton.enabled=YES;
        }
        else
        {
            ParkButton.enabled=NO;
        }
        
        if (MovieButton.tag==1)
        {
            MovieButton.enabled=YES;
            
            
        }
        else
        {
            MovieButton.enabled=NO;
        }
        
        
        if (SwimmingButton.tag==2)
        {
            SwimmingButton.enabled=YES;
        }
        else
        {
            SwimmingButton.enabled=NO;
        }
        
        if (BoadgameButton.tag==3)
        {
            BoadgameButton.enabled=YES;
        }
        else
        {
            BoadgameButton.enabled=NO;
        }
        if (BikeRidesButton.tag==4)
        {
            BikeRidesButton.enabled=YES;
        }
        else
        {
            BikeRidesButton.enabled=NO;
        }
        if (BakingButton.tag==5)
        {
            BakingButton.enabled=YES;
        }
        else
        {
            BakingButton.enabled=NO;
        }
        
        if (AnimalButton.tag==7)
        {
            AnimalButton.enabled=YES;
        }
        else
        {
            AnimalButton.enabled=NO;
        }
        
        if (SportButton.tag==8)
        {
            SportButton.enabled=YES;
        }
        else
        {
            SportButton.enabled=NO;
        }
        
        if (PlanningButton.tag==9)
        {
            PlanningButton.enabled=YES;
        }
        else
        {
            PlanningButton.enabled=NO;
        }
        
        if (CrawlingButton.tag==10)
        {
            CrawlingButton.enabled=YES;
        }
        else
        {
            CrawlingButton.enabled=NO;
        }
        
        if (BlocksButton.tag==11)
        {
            BlocksButton.enabled=YES;
        }
        else
        {
            BlocksButton.enabled=NO;
        }
        
        if (SandpitButton.tag==12)
        {
            SandpitButton.enabled=YES;
        }
        else
        {
            SandpitButton.enabled=NO;
        }
        
        
        [Next_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        [defaults synchronize];
        
    }
    else
    {
        [Next_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        Next_Button.enabled=NO;
        
        ParkButton.enabled=YES;
        
        MovieButton.enabled=YES;
        
        SwimmingButton.enabled=YES;
        
        BoadgameButton.enabled=YES;
        
        BikeRidesButton.enabled=YES;
        
        BakingButton.enabled=YES;
        
        AnimalButton.enabled=YES;
        
        SportButton.enabled=YES;
        
        PlanningButton.enabled=YES;
        
        CrawlingButton.enabled = YES;
        
        BlocksButton.enabled = YES;
        
        SandpitButton.enabled = YES;
        
        
        
    }

 }
-(IBAction)BackView:(id)sender
{


    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)NextView:(id)sender
{
    

    NSMutableArray *ConctsSrings1=[[NSMutableArray alloc]init];
    

    if (MovieButton.tag==1)
    {
      
        [ConctsSrings1 addObject:@"Movies"];
    }
 
    
    if (SwimmingButton.tag==2)
    {
     
         [ConctsSrings1 addObject:@"Beach"];
    }
  
    
    if (BoadgameButton.tag==3)
    {
        
         [ConctsSrings1 addObject:@"Board game"];
    }
   
    if (BikeRidesButton.tag==4)
    {
        
         [ConctsSrings1 addObject:@"Bike rides"];
    }
   
    if (BakingButton.tag==5)
    {
 
           [ConctsSrings1 addObject:@"Baking"];
    }
    if (ParkButton.tag==6)
    {
       
        
         [ConctsSrings1 addObject:@"Park"];
        
        
    }

    if (AnimalButton.tag==7)
    {
        
         [ConctsSrings1 addObject:@"Animals"];
    }
   
    
    if (SportButton.tag==8)
    {
     
        [ConctsSrings1 addObject:@"Sports"];
    }
   
    if (PlanningButton.tag==9)
    {
 
            [ConctsSrings1 addObject:@"Painting"];
    }
    
    if (CrawlingButton.tag==10)
    {
        
        [ConctsSrings1 addObject:@"Crawling"];
    }
    
    if (BlocksButton.tag==11)
    {
        
        [ConctsSrings1 addObject:@"Blocks"];
    }
    
    if (SandpitButton.tag==12)
    {
        
        [ConctsSrings1 addObject:@"Sandpit"];
    }
    
    
    
    NSLog(@"ConctsSrings1===%@",ConctsSrings1);
    [defaults setObject:[NSString stringWithFormat:@"%ld",(long)Count] forKey:@"Count"];
    [defaults setObject:ConctsSrings1 forKey:@"Activitys"];
    
    
    [defaults setObject:[ConctsSrings1 objectAtIndex:0]forKey:@"activity1"];
    [defaults setObject:[ConctsSrings1 objectAtIndex:1]forKey:@"activity2"];
    [defaults setObject:[ConctsSrings1 objectAtIndex:2]forKey:@"activity3"];
    [defaults synchronize];
    
    
    NSLog(@"defaultsActivitys===%@",[defaults valueForKey:@"Activitys"]);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SinupStepFiveViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepFiveViewController"];
    [self.navigationController pushViewController:set animated:YES];
    
}

@end
