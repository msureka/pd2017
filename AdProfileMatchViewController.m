//
//  AdProfileMatchViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 2/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "AdProfileMatchViewController.h"
#import "UIImageView+WebCache.h";
#import "FriendCahtingViewController.h"
@interface AdProfileMatchViewController ()
{
     NSUserDefaults * defaults;
}
@end

@implementation AdProfileMatchViewController
@synthesize Labelname,profileImg1,Button_letchat1,AllArray_data;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString * urlstr=[[AllArray_data valueForKey:@"gagapic"]objectAtIndex:0];
    NSURL *url=[NSURL URLWithString:urlstr];
    
    
     
        [profileImg1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil]
                                options:SDWebImageRefreshCached];
 
    Button_letchat1.clipsToBounds=YES;
    Button_letchat1.layer.cornerRadius=Button_letchat1.frame.size.height/2;
    
 //   Labelname.text =@"dbdjkhjkshk";


       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Button_Thanks:(id)sender;
{
    [self dismissModalViewControllerAnimated:YES];
    
    
    
    /* old segue to chat
    
    [defaults setObject:@"yes" forKey:@"letsChatAd"];
    [defaults synchronize];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
    set.AllDataArray=AllArray_data;
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:set];
    
     */
    
    //
    ////    NSDictionary * dic=[Array_Match objectAtIndex:(long)imageView.tag];
    ////    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    ////    [array_new addObject:dic];
    //    set.AllDataArray=AllArray_data;
    //
    //     [self presentViewController:set animated:YES completion:nil];
    //   [self dismissModalViewControllerAnimated:YES];
    
}

@end
