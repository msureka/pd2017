//
//  FriendRequestViewController.m
//  Play_Date
//
//  Created by Spiel on 25/04/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendRequestViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "DiscoverInfoViewController.h"
#import "DiscoverUserProfileinfoViewController.h"
#import "FriendCahtingViewController.h"

@interface FriendRequestViewController ()
{
    NSUserDefaults *defaults;
    UITapGestureRecognizer *tap,*tap1;
    NSString *checkstr;
    NSDictionary *urlplist;
    NSURLConnection *Connection_Accept;
    NSMutableData *webData_Accept;
    NSMutableArray *Array_Accept;
}

@end

@implementation FriendRequestViewController
@synthesize Back_imageprofile,Front_imageprofile,Label_Name,Label_CityCountry,Label_Emoji1,Label_Emoji2,Label_Emoji3,acceptButton,declineButton,    Array_UserInfo;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults=[[NSUserDefaults alloc]init];
        
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    acceptButton.layer.cornerRadius = acceptButton.frame.size.height/2;
    
//    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
//    [self.view addGestureRecognizer:tap];
   
    
    
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
    
    
       
    Front_imageprofile.backgroundColor=[UIColor clearColor];
    Front_imageprofile.image=[UIImage imageNamed:@"10154143609282724.jpg"];
    Front_imageprofile.backgroundColor=[UIColor clearColor];
    
    Back_imageprofile.backgroundColor=[UIColor clearColor];
    
    
    Front_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
    Back_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
    
    Back_imageprofile.backgroundColor=[UIColor clearColor];
    
    
    
    tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
    [Front_imageprofile addGestureRecognizer:tap1];
    
   
    
    
    
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
    
    
    
}


- (void) fireScrollRectToVisible:(UIGestureRecognizer *) gesture
{
    
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        DiscoverUserProfileinfoViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DiscoverUserProfileinfoViewController"];
        
        set.Array_UserInfo = Array_UserInfo;
        
        [self.navigationController pushViewController:set animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AcceptDecline Connection

-(void)acceptDeclineConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        //        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        message.tag=100;
        //        [message show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
        NSString *  urlStrLivecount=[urlplist valueForKey:@"acceptdecline"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        
        NSString *fbid1= @"fbid1";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        NSString *fbid2 = @"fbid2";
        NSString *fbid2Val = [[Array_UserInfo objectAtIndex:0] valueForKey:@"matchedfbid"];
        
        NSString *req = @"request";
        NSString *reqVal = [defaults valueForKey:@"requestType"];
        
        
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,fbid2,fbid2Val,req,reqVal];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_Accept = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        {
            if( Connection_Accept)
            {
                webData_Accept =[[NSMutableData alloc]init];
                
                
            }
            else
            {
                NSLog(@"theConnection is NULL");
            }
        }
        
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
    
    if(connection==Connection_Accept)
    {
        [webData_Accept setLength:0];
        
        
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Accept)
    {
        [webData_Accept appendData:data];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection == Connection_Accept)
    {
        
  
    
    Array_Accept=[[NSMutableArray alloc]init];
    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
    Array_Accept=[objSBJsonParser objectWithData:webData_Accept];
    NSString * ResultString=[[NSString alloc]initWithData:webData_Accept encoding:NSUTF8StringEncoding];
       
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        if (Array_Accept.count != 0) {
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
            
            
            
                set.AllDataArray=Array_Accept;
            
            [defaults setObject:@"yes" forKey:@"friendRequest"];
            [defaults synchronize];
            
            
            
            [self.navigationController pushViewController:set animated:YES];

            
            
        }
        else
        {
            
            [self.navigationController popViewControllerAnimated:NO];

            
        }

    }
}


- (IBAction)Accept_Pressed:(id)sender {
    
    [defaults setObject:@"ACCEPT" forKey:@"requestType"];
    
    [self acceptDeclineConnection];
    
    //[self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)Decline_Pressed:(id)sender {
    
     [defaults setObject:@"DECLINE" forKey:@"requestType"];
    
    [self acceptDeclineConnection];

    
//[self.navigationController popViewControllerAnimated:NO];
    
    }
@end
