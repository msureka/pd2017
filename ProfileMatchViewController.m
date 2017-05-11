//
//  ProfileMatchViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/13/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileMatchViewController.h"
#import "UIImageView+WebCache.h"
#import "FriendCahtingViewController.h"
@interface ProfileMatchViewController ()
{
    NSUserDefaults * defaults;
}
@end

@implementation ProfileMatchViewController
@synthesize Labelname,ImageBack1,profileImg1,Button_later1,Button_letchat1,AllArray_data;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ProfileMatch_Array_Data=%@",AllArray_data);
    defaults=[[NSUserDefaults alloc]init];
    NSString * urlstr=[[AllArray_data valueForKey:@"profilepic"]objectAtIndex:0];
    NSURL *url=[NSURL URLWithString:urlstr];
    
    if ([[[AllArray_data valueForKey:@"gender"]objectAtIndex:0] isEqualToString:@"Boy"])
    {
        
        ImageBack1.image=[UIImage imageNamed:@"boypictureframe 1.png"];
        [profileImg1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultImg.boy"]
                                options:SDWebImageRefreshCached];
    }
    else
    {
        ImageBack1.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
        [profileImg1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]
                                options:SDWebImageRefreshCached];
    }
    Button_letchat1.clipsToBounds=YES;
    Button_letchat1.layer.cornerRadius=Button_letchat1.frame.size.height/2;
    
   
    
    
    
    
   
    
    UIFont *VerdanaFont = [UIFont fontWithName:@"Helvetica" size:18.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:@"You and " attributes:verdanaDict];
   
    
    UIFont *arialFont = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
    NSDictionary *arialDictq = [NSDictionary dictionaryWithObject: arialFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[[AllArray_data valueForKey:@"fname"]objectAtIndex:0] attributes: arialDictq];
    
    UIFont *VerdanaFont3 = [UIFont fontWithName:@"Helvetica" size:18.0];
    NSDictionary *verdanaDict3 = [NSDictionary dictionaryWithObject:VerdanaFont3 forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString3 = [[NSMutableAttributedString alloc]initWithString:@" both want to play!" attributes:verdanaDict3];
    
    [vAttrString appendAttributedString:aAttrString];
     [vAttrString appendAttributedString:vAttrString3];
    Labelname.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    Labelname.attributedText=vAttrString;

    
    
   // Labelname.text=[NSString stringWithFormat:@"%@%@%@",@"You and ",[[AllArray_data valueForKey:@"fname"]objectAtIndex:0],@" both want to play!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(IBAction)Button_letschat:(id)sender
{
    [defaults setObject:@"yes" forKey:@"letsChat"];
    [defaults synchronize];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
    set.AllDataArray=AllArray_data;

    [[UIApplication sharedApplication].keyWindow setRootViewController:set];
  
    //
    ////    NSDictionary * dic=[Array_Match objectAtIndex:(long)imageView.tag];
    ////    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    ////    [array_new addObject:dic];
    //    set.AllDataArray=AllArray_data;
    //
    //     [self presentViewController:set animated:YES completion:nil];
    //   [self dismissModalViewControllerAnimated:YES];

}
-(IBAction)Button_later:(id)sender
{
    [defaults setObject:@"no" forKey:@"letsChat"];
    [defaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}

@end
