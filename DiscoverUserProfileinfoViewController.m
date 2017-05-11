//
//  DiscoverUserProfileinfoViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/30/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "DiscoverUserProfileinfoViewController.h"
#import "UIImageView+WebCache.h"
#import "FriendCahtingViewController.h"
@interface DiscoverUserProfileinfoViewController ()
{
    NSUserDefaults *defaults;
    UITapGestureRecognizer *tap,*tap1;
    NSString *checkstr;
}
@end

@implementation DiscoverUserProfileinfoViewController
@synthesize Image_Left,Image_Right,Back_imageprofile,Front_imageprofile,Label_Name,Label_CityCountry,Label_Emoji1,Label_Emoji2,Label_Emoji3,Label_Desc,Label_Favtitle,ViewMainView, Label_Arabic_Exra,Label_French_Extra;
@synthesize Label_Arabic,Label_French,Label_English,Label_LetMeet,Label_Suprhero,Label_Activity1,Label_Activity2,Label_Activity3,Label_LikePllay,image_letmeey,image_likeplay,Array_UserInfo;
- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    checkstr=@"yes";
    
   

    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
    [self.view addGestureRecognizer:tap];
    
    

    ViewMainView.hidden=YES;
    
    //        Label_Favtitle= [[UILabel alloc]initWithFrame:CGRectMake(16,0, self.frame.size.width-32, 44)];
    //        Label_Favtitle.text = @"Sachin xzccasas";
    //        [Label_Favtitle setTextAlignment:NSTextAlignmentCenter];
    //        Label_Favtitle.backgroundColor=[UIColor redColor];
    //        Label_Favtitle.textColor = [UIColor blackColor];
    //        Label_Favtitle.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0f];
    //   [self addSubview:Label_Favtitle];
    

    Label_Name.text =[NSString stringWithFormat:@"%@%@%@",[[Array_UserInfo valueForKey:@"fname"] objectAtIndex:0],@", ",[[Array_UserInfo valueForKey:@"age"] objectAtIndex:0]];
    
    [Label_Name setTextAlignment:NSTextAlignmentCenter];
    Label_Name.textColor = [UIColor blackColor];
    Label_Name.font=[UIFont fontWithName:@"KG Feeling 22" size:44.0f];
    Label_Name.backgroundColor=[UIColor clearColor];
 
  


    Label_CityCountry.backgroundColor=[UIColor clearColor];
    Label_CityCountry.text =[NSString stringWithFormat:@"%@%@%@",[[Array_UserInfo valueForKey:@"city"] objectAtIndex:0],@", ",[[Array_UserInfo valueForKey:@"country"] objectAtIndex:0]];
    [Label_CityCountry setTextAlignment:NSTextAlignmentCenter];
    Label_CityCountry.textColor = [UIColor blackColor];
    Label_CityCountry.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
    
//    Label_Emoji1 = [[UILabel alloc]initWithFrame:CGRectMake(99,387,48, 52)];
    Label_Emoji1.backgroundColor=[UIColor clearColor];
    Label_Emoji1.text =[[Array_UserInfo valueForKey:@"emoji1"] objectAtIndex:0];
    [Label_Emoji1 setTextAlignment:NSTextAlignmentCenter];
    Label_Emoji1.textColor = [UIColor blackColor];
    Label_Emoji1.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
    
//    Label_Emoji2 = [[UILabel alloc]initWithFrame:CGRectMake(163,387,48,52)];
    Label_Emoji2.text =[[Array_UserInfo valueForKey:@"emoji2"] objectAtIndex:0];
    [Label_Emoji2 setTextAlignment:NSTextAlignmentCenter];
    Label_Emoji2.textColor = [UIColor blackColor];
    Label_Emoji2.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
    Label_Emoji2.backgroundColor=[UIColor clearColor];
    
   // Label_Emoji3 = [[UILabel alloc]initWithFrame:CGRectMake(227,387,48,52)];
    Label_Emoji3.text = [[Array_UserInfo valueForKey:@"emoji3"] objectAtIndex:0];
    [Label_Emoji3 setTextAlignment:NSTextAlignmentCenter];
    Label_Emoji3.textColor = [UIColor blackColor];
    Label_Emoji3.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
    Label_Emoji3.backgroundColor=[UIColor clearColor];
    
    Label_Desc.text =[[Array_UserInfo valueForKey:@"description"] objectAtIndex:0];;
    Label_Desc.editable=NO;
    Label_Desc.selectable=NO;
    Label_Desc.scrollEnabled=NO;
    [Label_Desc setTextAlignment:NSTextAlignmentCenter];
    Label_Desc.backgroundColor=[UIColor clearColor];
    Label_Desc.textColor = [UIColor blackColor];
    Label_Desc.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
    Label_Desc.backgroundColor=[UIColor clearColor];
   
    Image_Left=[[UIButton alloc]initWithFrame:CGRectMake(10,24,28,28)];
    Image_Left.backgroundColor=[UIColor clearColor];
    [Image_Left setImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
    Image_Left.backgroundColor=[UIColor clearColor];
   
 
    Image_Right.backgroundColor=[UIColor clearColor];
    [Image_Right setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    Image_Right.backgroundColor=[UIColor clearColor];
  
    
 
    Front_imageprofile.backgroundColor=[UIColor clearColor];
    Front_imageprofile.image=[UIImage imageNamed:@"10154143609282724.jpg"];
    Front_imageprofile.backgroundColor=[UIColor clearColor];
   
    Back_imageprofile.backgroundColor=[UIColor clearColor];
 
    
    Front_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
    Back_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
    
    Back_imageprofile.backgroundColor=[UIColor clearColor];

    
    
    tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
    [Front_imageprofile addGestureRecognizer:tap1];
    
    [self fireScrollRectToVisible:nil];
    
    
    
    NSURL * url=[NSURL URLWithString:[[Array_UserInfo valueForKey:@"profilepic"] objectAtIndex:0]];
    if([[[Array_UserInfo valueForKey:@"gender"]objectAtIndex:0] isEqualToString:@"Boy"])
    {
        
        Back_imageprofile.image=[UIImage imageNamed:@"boypictureframe 1.png"];
    }
    else
    {
       Back_imageprofile.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
    }
    [Front_imageprofile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
   Front_imageprofile.tag=0;
    Front_imageprofile.userInteractionEnabled = YES;
  
    Label_Arabic.hidden=YES;
    Label_French.hidden=YES;
    Label_English.hidden=YES;
    
    NSString * English_str=[[Array_UserInfo valueForKey:@"englang"] objectAtIndex:0];
    NSString *  Arabic_str= [[Array_UserInfo valueForKey:@"arabiclang"] objectAtIndex:0];
    NSString *  French_str=[[Array_UserInfo valueForKey:@"frenchlang"] objectAtIndex:0];
    
    
    
    if (![English_str isEqualToString:@""] && [Arabic_str isEqualToString:@""]  && [French_str isEqualToString:@""])
    {
        
     Label_Arabic.text=English_str;
        
        
        Label_Arabic_Exra.hidden=YES;
        Label_French_Extra.hidden=YES;
        
        Label_Arabic.hidden=NO;
        Label_French.hidden=YES;
        Label_English.hidden=YES;
        
        
    }
    
   
    
    else if (![English_str isEqualToString:@""] && ![Arabic_str isEqualToString:@""] && ![French_str isEqualToString:@""])
    {
    
        
        Label_English.text=English_str;
        Label_Arabic.text=Arabic_str;
        Label_French.text=French_str;
        
        Label_Arabic.hidden=NO;
        Label_French.hidden=NO;
        Label_English.hidden=NO;
        
        Label_Arabic_Exra.hidden=YES;
        Label_French_Extra.hidden=YES;
        
        
        
    }
    
    else if(![English_str isEqualToString:@""] && ![Arabic_str isEqualToString:@""] && [French_str isEqualToString:@""])                                                                              {
        
        Label_Arabic_Exra.hidden=NO;
        Label_French_Extra.hidden=NO;
        
       Label_Arabic_Exra.text=English_str;
         Label_French_Extra.text=Arabic_str;
        
        Label_Arabic.hidden=YES;
        Label_French.hidden=YES;
        Label_English.hidden=YES;
        
    }
    
    Label_Arabic_Exra.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    Label_Arabic_Exra.clipsToBounds=YES;
    Label_Arabic_Exra.layer.cornerRadius=Label_Arabic_Exra.frame.size.height/2;
    
    Label_French_Extra.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    Label_French_Extra.clipsToBounds=YES;
    Label_French_Extra.layer.cornerRadius=Label_French_Extra.frame.size.height/2;
  
  
    Label_English.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    Label_English.clipsToBounds=YES;
    Label_English.layer.cornerRadius=Label_English.frame.size.height/2;
    
  

    Label_Arabic.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    Label_Arabic.clipsToBounds=YES;
   Label_Arabic.layer.cornerRadius=Label_Arabic.frame.size.height/2;
    
    
    
   Label_French.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
   Label_French.clipsToBounds=YES;
    Label_French.layer.cornerRadius=Label_French.frame.size.height/2;
    
    Label_Suprhero.clipsToBounds=YES;
    Label_Suprhero.textAlignment=NSTextAlignmentCenter;
   
     Label_Suprhero.layer.cornerRadius=Label_Suprhero.frame.size.height/2;
    Label_Suprhero.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    Label_Suprhero.text =[[Array_UserInfo valueForKey:@"superhero"] objectAtIndex:0];
    Label_Activity1.text =[[Array_UserInfo valueForKey:@"activity1"] objectAtIndex:0];
    Label_Activity2.text =[[Array_UserInfo valueForKey:@"activity2"] objectAtIndex:0];
    Label_Activity3.text =[[Array_UserInfo valueForKey:@"activity3"] objectAtIndex:0];
    Label_LikePllay.text =[[Array_UserInfo valueForKey:@"liketoplay"] objectAtIndex:0];
    Label_LetMeet.text =[[Array_UserInfo valueForKey:@"icanmeet"] objectAtIndex:0];
    
    if ([[[Array_UserInfo valueForKey:@"liketoplay"] objectAtIndex:0] isEqualToString:@"Outdoor"])
    {
        image_likeplay.image=[UIImage imageNamed:@"outdoor.png"];
    }
    else if ([[[Array_UserInfo valueForKey:@"liketoplay"] objectAtIndex:0] isEqualToString:@"Everywhere"])
    {
      image_likeplay.image=[UIImage imageNamed:@"everywhere.png"];
    }
    else if ([[[Array_UserInfo valueForKey:@"liketoplay"] objectAtIndex:0] isEqualToString:@"Indoor"])
    {
       image_likeplay.image=[UIImage imageNamed:@"indoor.png"];
    }
    
    if ([[[Array_UserInfo valueForKey:@"icanmeet"] objectAtIndex:0] isEqualToString:@"Mornings"])
    {
       image_letmeey.image=[UIImage imageNamed:@"mornings.png"];
    }
    else if ([[[Array_UserInfo valueForKey:@"icanmeet"] objectAtIndex:0] isEqualToString:@"Anytime"])
    {
        image_letmeey.image=[UIImage imageNamed:@"anytime.png"];
    }
    else if ([[[Array_UserInfo valueForKey:@"icanmeet"] objectAtIndex:0] isEqualToString:@"Afterschool"])
    {
      image_letmeey.image=[UIImage imageNamed:@"afterschool.png"];
    }
    
    
    
 
}
- (void) fireScrollRectToVisible:(UIGestureRecognizer *) gesture
{
    if([checkstr isEqualToString:@"yes"])
    {
        
      ViewMainView.hidden=YES;
        checkstr=@"no";
    }
    else
    {
        ViewMainView.hidden=NO;
        checkstr=@"yes";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Back_button:(id)sender;
{
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"])
    {
       
        [self performSegueWithIdentifier:@"Back" sender:self];
    }
    else
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
}
-(IBAction)Back_buttonView:(id)sender;
{
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"])
    {
   ;
        [self performSegueWithIdentifier:@"Back" sender:self];
    }
    else
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Back"])
    {
        
        FriendCahtingViewController * destViewController= segue.destinationViewController;
        destViewController.AllDataArray=Array_UserInfo;
    }
}
@end
