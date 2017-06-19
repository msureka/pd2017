//
//  TabbarMainProViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "TabbarMainProViewController.h"
#import "DiscoverViewController.h"
#import "Reachability.h"

@interface TabbarMainProViewController ()
{
    NSUserDefaults * defautls;
    UITabBarItem *item0,*item1,*item2;
    NSDictionary *urlplist;
    NSURLConnection *Connection_budge;
    NSMutableData *webData_budge;
    NSMutableArray *Array_budge;
}
@end

@implementation TabbarMainProViewController
@synthesize Array_AllDataPro;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defautls=[[NSUserDefaults alloc]init];
    NSLog(@"Array_AllDataProTAb==%@",Array_AllDataPro);
    UITabBar *tabBar = self.tabBar;
    
    CGRect viewFrame = tabBar.frame;
    viewFrame.size.height = 67;
    self.tabBar.frame = viewFrame;
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:14.0f],NSFontAttributeName, nil] forState:UIControlStateSelected];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:14.0f], NSFontAttributeName,nil] forState:UIControlStateNormal];
  
    
    
    
   item0 = [tabBar.items objectAtIndex:0];
   item1 = [tabBar.items objectAtIndex:1];
   item2 = [tabBar.items objectAtIndex:2];
    
    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
      self.tabBar.barTintColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
       
        
   
    }
    else
    {
      self.tabBar.barTintColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
    }
    
//     [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:14.0f],NSFontAttributeName, nil] forState:UIControlStateSelected];
//
//    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:14.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
     [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];

     [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];

    
    item0.selectedImage = [[UIImage imageNamed:@"profile1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item0.image = [[UIImage imageNamed:@"profile.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item0.title = @"Profile";
    
    item1.selectedImage = [[UIImage imageNamed:@"discover1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item1.image = [[UIImage imageNamed:@"discover.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item1.title = @"Discover";
    
    item2.selectedImage = [[UIImage imageNamed:@"friends1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item2.image = [[UIImage imageNamed:@"friends.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item2.title = @"Friends";
    
   
    if ([[defautls valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defautls valueForKey:@"letsChatAd"] isEqualToString:@"yes"] || [[defautls valueForKey:@"tapindex"] isEqualToString:@"yes"])
    {
        [defautls setObject:@"no" forKey:@"letsChat"];
        [defautls setObject:@"no" forKey:@"letsChatAd"];
        [defautls synchronize];
      self.selectedIndex=2;
    }
    else
    {
        self.selectedIndex=1;
    }
    
    
    
    NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:Array_AllDataPro,@"ArrayData", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:self userInfo:theInfo];
      [self communicationServer];

    NSTimer *HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(communicationServer) userInfo:nil  repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (void)viewWillLayoutSubviews
{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 67;
    tabFrame.origin.y = self.view.frame.size.height - 67;
    self.tabBar.frame = tabFrame;
    

    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        self.tabBar.barTintColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
        
        
        
    }
    else
    {
        self.tabBar.barTintColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
    }
   
   
}

-(void)communicationServer
{
Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
if (networkStatus == NotReachable)
{
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    message.tag=100;
//    [message show];
    
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
    NSString *  urlStrLivecount=[urlplist valueForKey:@"friendsticker"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];//Web API Method
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    
    NSString *fbId= @"fbid";
    NSString *fbIdValue = [defautls valueForKey:@"fid"];
    
    
  
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbId,fbIdValue];
    
    
    //converting  string into data bytes and finding the lenght of the string.
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    Connection_budge = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_budge)
        {
            webData_budge =[[NSMutableData alloc]init];
            
            
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
    
    if(connection==Connection_budge)
    {
        [webData_budge setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_budge)
    {
        [webData_budge appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection==Connection_budge)
    {
        
        Array_budge=[[NSMutableArray alloc]init];
    
        NSString * ResultString=[[NSString alloc]initWithData:webData_budge encoding:NSUTF8StringEncoding];
        Array_budge=[NSJSONSerialization JSONObjectWithData:webData_budge options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_budge %@",Array_budge);
       
        NSLog(@"ResultString %@",ResultString);
        if (![ResultString isEqualToString:@""] && ![ResultString isEqualToString:@"0"] )
        {
            item2.badgeValue=ResultString;
        }
        else
        {
            item2.badgeValue=nil;
        }
    }
}
@end
