//
//  MainProfileViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/2/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "MainProfileViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "TabbarMainProViewController.h"
@interface MainProfileViewController ()
{
    NSUserDefaults * defautls;
    
    
    NSDictionary *urlplist;
    NSURLConnection *Connection_LodingPro;
    NSMutableData *webData_LodingPro;
    NSMutableArray *Array_LodingPro;
    NSString *ptypeString;


    
}
@end

@implementation MainProfileViewController
@synthesize indicatorView,profileImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defautls=[[NSUserDefaults alloc]init];
    
    
    
    UIImage *image = [UIImage imageWithData:[defautls valueForKey:@"Proimage"]];
    
    profileImg.image=image;
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSString * urlstr=[NSString stringWithFormat:@"%@%@%@",[urlplist valueForKey:@"urlname"],[defautls valueForKey:@"fid"],@".jpg"];
    
    NSURL * url=[NSURL URLWithString:urlstr];
    
    //[profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
    [profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                           options:SDWebImageRefreshCached];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: url];
        
        if ( data == nil )
            
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            profileImg.image = [UIImage imageWithData: data];
    
            NSData *imageData = UIImageJPEGRepresentation( profileImg.image, 1.0);
            [defautls setObject:imageData forKey:@"Proimage"];
            [defautls synchronize];
            
        });
        
    });
    NSData *imageData = UIImageJPEGRepresentation( profileImg.image, 1.0);
    [defautls setObject:imageData forKey:@"Proimage"];
    [defautls synchronize];
    [self clientServerComm];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clientServerComm
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Please Note" message:@"Internet Connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        message.tag=100;
//        [message show];
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

        
        
        
    }
    else
    {
        
        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
        NSString *  urlStrLivecount=[urlplist valueForKey:@"lookingprofiles"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defautls valueForKey:@"fid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_LodingPro = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_LodingPro)
            {
                webData_LodingPro =[[NSMutableData alloc]init];
                
                
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
    
    if(connection==Connection_LodingPro)
    {
        [webData_LodingPro setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_LodingPro)
    {
        [webData_LodingPro appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  //  [indicatorView stopAnimating];
    
    if (connection==Connection_LodingPro)
    {
        
        Array_LodingPro=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
     //   Array_LodingPro=[objSBJsonParser objectWithData:webData_LodingPro];
        NSString * ResultString=[[NSString alloc]initWithData:webData_LodingPro encoding:NSUTF8StringEncoding];
      Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_LodingPro options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"looking profile %@",Array_LodingPro);
        for ( int i=0 ; i<Array_LodingPro.count; i++)
        {
             NSLog(@"looking profile %@",[Array_LodingPro objectAtIndex:i]);
        }
//        NSLog(@"looking profil_registration_status %@",[[Array_LodingPro objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"looking profil_ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"nullerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            
//            
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        if ([ResultString isEqualToString:@"nofbid"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        }

        
        
        if (Array_LodingPro.count !=0)
        {
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            TabbarMainProViewController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"TabbarMainProViewController"];
//            Home_add.Array_AllDataPro=Array_LodingPro;
//            [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
            
            

        }
    }
}
@end
