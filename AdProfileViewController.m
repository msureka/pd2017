//
//  AdProfileViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 2/9/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "AdProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "FriendCahtingViewController.h"
@interface AdProfileViewController ()
{
    NSUserDefaults *defaults;
}
@end

@implementation AdProfileViewController
@synthesize Image_TopcompnyImage;;
@synthesize Label_AddressComp,Label_AddressCompBG;
@synthesize Label_TitleCompany;
@synthesize Textview_DescCompany;
@synthesize Image_compnyLogo1;
@synthesize Image_compnyLogo2;
@synthesize Image_compnyLogo3,Array_LodingPro,label_fname;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat red,green,blue;
    defaults=[[NSUserDefaults alloc]init];
    red=[[[Array_LodingPro valueForKey:@"colourred"] objectAtIndex:0]floatValue];
    green=[[[Array_LodingPro valueForKey:@"colourgreen"] objectAtIndex:0]floatValue];
    blue=[[[Array_LodingPro valueForKey:@"colourblue"] objectAtIndex:0]floatValue];
    NSURL *url_imagetitle,*url_imagelogo1,*url_imagelogo2,*url_imagelogo3;
    
   
    
    url_imagetitle=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagetitle"] objectAtIndex:0]];
    url_imagelogo1=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0]];
    url_imagelogo2=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0]];
    url_imagelogo3=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0]];
    
     label_fname.text=[[Array_LodingPro valueForKey:@"fname"] objectAtIndex:0];
    //        Image_compnyLogo1=[[UIImageView alloc]initWithFrame:CGRectMake(16,505,86,86)];
    //
    //
    //        Image_compnyLogo2=[[UIImageView alloc]initWithFrame:CGRectMake(144,505,86,86)];
    //
    //
    //        Image_compnyLogo3=[[UIImageView alloc]initWithFrame:CGRectMake(273,505,86,86)];
    //
    
    
    
    
    [Image_TopcompnyImage sd_setImageWithURL:url_imagetitle placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
   Label_AddressComp.text=[[Array_LodingPro valueForKey:@"subtitle"] objectAtIndex:0];
    
    Label_AddressComp.backgroundColor=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
    Label_AddressCompBG.backgroundColor=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
    
    Label_TitleCompany.text=[[Array_LodingPro valueForKey:@"title"] objectAtIndex:0];
    
    Textview_DescCompany.text=[[Array_LodingPro valueForKey:@"addescription"] objectAtIndex:0];
    
    
    
    if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0] isEqualToString:@""])
    {
        Image_compnyLogo2.hidden=YES;
        Image_compnyLogo3.hidden=YES;
        Image_compnyLogo2.hidden=NO;
        Image_compnyLogo3.hidden=YES;
        Image_compnyLogo1.hidden=YES;
        [Image_compnyLogo2 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        //            [draggableView.Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
        //            [draggableView.Image_compnyLogo3 sd_setImageWithURL:url_imagelogo3 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
    }
//    if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0] isEqualToString:@""])
//    {
//       
//        Image_compnyLogo2.hidden=YES;
//        Image_compnyLogo3.hidden=YES;
//        _Image_compnyLogo2_Extra.hidden=YES;
//        _Image_compnyLogo3_Extra.hidden=YES;
//       Image_compnyLogo1.hidden=NO;
//        [Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//        //            [draggableView.Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//        //            [draggableView.Image_compnyLogo3 sd_setImageWithURL:url_imagelogo3 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//    }
    else if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0] isEqualToString:@""]&& ![[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0] isEqualToString:@""])
    {
     
        
        _Image_compnyLogo2_Extra.hidden=NO;
        _Image_compnyLogo3_Extra.hidden=NO;
        
        Image_compnyLogo1.hidden=YES;
        Image_compnyLogo2.hidden=YES;
        Image_compnyLogo3.hidden=YES;
        
        [_Image_compnyLogo2_Extra sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        [_Image_compnyLogo3_Extra sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        
    }
    else if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0] isEqualToString:@""]&& ![[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0] isEqualToString:@""] && ![[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0] isEqualToString:@""])
    {
       Image_compnyLogo1.hidden=NO;
       Image_compnyLogo2.hidden=NO;
       Image_compnyLogo3.hidden=NO;
        _Image_compnyLogo2_Extra.hidden=YES;
        _Image_compnyLogo3_Extra.hidden=YES;
        
        [Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        [Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        [Image_compnyLogo3 sd_setImageWithURL:url_imagelogo3 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
    }
    else if ([[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:0] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:0] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:0] isEqualToString:@""])
    {
       Image_compnyLogo1.hidden=YES;
       Image_compnyLogo2.hidden=YES;
        Image_compnyLogo3.hidden=YES;
        _Image_compnyLogo2_Extra.hidden=YES;
        _Image_compnyLogo3_Extra.hidden=YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)Back_buttonView:(id)sender
{
    if ([[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        
        [self performSegueWithIdentifier:@"BackAd" sender:self];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BackAd"])
    {
        
        FriendCahtingViewController * destViewControlle= segue.destinationViewController;
        destViewControlle.AllDataArray=Array_LodingPro;
    }
}

@end
