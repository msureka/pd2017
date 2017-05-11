//
//  LoginSignupViewController.m
//  Spiel_Project2
//
//  Created by Spiel's Macmini on 6/16/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "LoginSignupViewController.h"
#import "SinupStepOneViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Reachability.h"
#define radius 14.0f;
#import <CoreLocation/CoreLocation.h>
#import "MainProfilenavigationController.h"
#import "UIView+RNActivityView.h"
#import <AirshipKit/AirshipKit.h>
#import "Flurry.h"
@interface LoginSignupViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate>




{
    NSDictionary *urlplist;
    NSURLConnection *Connection_sinupFb;
    NSMutableData *webData_sinupFb;
    NSMutableArray *Array_sinupFb;
    NSString * ptypeString,*EmailIdString,*FbmailId,*FbuserID,*FbFirstname,*Fblastname,*FbuserFullname,*FbprofileImg,*GenderFb,*CityNamestr,*CountryNameStr;
    NSUserDefaults * LoginSession_Check,*defaults;
    UIView * confirmView;
    UIActivityIndicatorView *indicatorAlert;
    CLLocationManager *locationManager ;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    NSString *channelIDglobal;
    BOOL location;
    
}
@property(nonatomic,weak,nullable) id<UARegistrationDelegate> registrationDelegate; //mohit
@end

@implementation LoginSignupViewController
@synthesize loginBt,SinupBt,FbBt,LoginSingViewborder,Label_DectLoc;
- (void)viewDidLoad
{
    [super viewDidLoad];
    location = true;
    
    [UAirship push].registrationDelegate = self;
    
    
    self.tabBarController.tabBar.hidden=YES;
    
    LoginSession_Check=[[NSUserDefaults alloc]init];
    defaults=[[NSUserDefaults alloc]init];
    
    
    locationManager = [[CLLocationManager alloc] init] ;
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy =kCLLocationAccuracyThreeKilometers; //kCLLocationAccuracyNearestTenMeters;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
//    loginBt.layer.borderColor=[UIColor whiteColor].CGColor;
//    SinupBt.layer.borderColor=[UIColor whiteColor].CGColor;
//    loginBt.layer.borderWidth=2.0f;
//    SinupBt.layer.borderWidth=2.0f;
//    SinupBt.layer.cornerRadius=4;
//    loginBt.layer.cornerRadius=4;
//    FbBt.layer.borderColor=[UIColor whiteColor].CGColor;
//    FbBt.layer.borderWidth=2.0f;
    
     FbBt.layer.cornerRadius=FbBt.frame.size.height/2;
    
    LoginSingViewborder.layer.borderColor=[UIColor whiteColor].CGColor;
    LoginSingViewborder.layer.borderWidth=2.0f;
    LoginSingViewborder.layer.cornerRadius=radius;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:SinupBt.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(9.0,9.0)];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.view.bounds;
//    maskLayer.path  = maskPath.CGPath;
//    SinupBt.layer.mask = maskLayer;
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:loginBt.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(9.0,9.0)];
    
//    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//    maskLayer1.frame = self.view.bounds;
//    maskLayer1.path  = maskPath1.CGPath;
//    loginBt.layer.mask = maskLayer1;
    
//    SinupBt.layer.borderColor=[UIColor whiteColor].CGColor;
//    SinupBt.layer.borderWidth=2.0f;
    
    // LnameTxt.layer.cornerRadius=4;
//    loginBt.layer.borderColor=[UIColor whiteColor].CGColor;
//    loginBt.layer.borderWidth=2.0f;
//        SinupBt.clipsToBounds = YES;
//        CALayer *borderBottom = [CALayer layer];
//        borderBottom.backgroundColor = [UIColor whiteColor].CGColor;
//        borderBottom.frame = CGRectMake(0, SinupBt.frame.size.height-2, SinupBt.frame.size.width, 2);
//        [SinupBt.layer addSublayer:borderBottom];
    
//        CALayer *borderTop = [CALayer layer];
//        borderTop.backgroundColor = [UIColor whiteColor].CGColor;
//    
//        borderTop.frame = CGRectMake(0, 0, SinupBt.frame.size.width, 2);
//        [SinupBt.layer addSublayer:borderTop];
//    
//           CALayer *borderLeft = [CALayer layer];
//           borderLeft.backgroundColor = [UIColor whiteColor].CGColor;
//    
//            borderLeft.frame = CGRectMake(0, 0, 2, SinupBt.frame.size.height);
//           [SinupBt.layer addSublayer:borderLeft];
    
            CALayer *borderRight = [CALayer layer];
            borderRight.backgroundColor =[UIColor whiteColor].CGColor;
    
            borderRight.frame = CGRectMake(SinupBt.frame.size.width - 2, 0, 2, SinupBt.frame.size.height);
            [SinupBt.layer addSublayer:borderRight];
    
    
    
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  
   
 
    _loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
   
    
    
    confirmView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    confirmView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    
    UIView * whiteView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100,100)];
    whiteView1.center=confirmView.center;
    [whiteView1 setBackgroundColor:[UIColor blackColor]];
    whiteView1.layer.cornerRadius=9;
    
    indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
    [indicatorAlert startAnimating];
    [indicatorAlert setColor:[UIColor whiteColor]];
    
    UILabel * confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, 100, 20)];
    [confirm setFont:[UIFont systemFontOfSize:12]];
    confirm.textColor=[UIColor whiteColor];
    confirm.text=@"Loading...";
    confirm.textAlignment=NSTextAlignmentCenter;
    [whiteView1 addSubview:confirm];
    [whiteView1 addSubview:indicatorAlert];
    
//    [confirmView addSubview:whiteView1];
//        [self.view addSubview:confirmView];

    [self.view hideActivityViewWithAfterDelay:1];
    NSLog(@"dffff=%@",[defaults valueForKey:@"Cityname"]);
    NSLog(@"fdsee=%@",[defaults valueForKey:@"Countryname"]);
    
  //  FbBt.backgroundColor=[UIColor darkGrayColor];
    
    [FbBt setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    FbBt.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    FbBt.enabled=YES;
    Label_DectLoc.hidden=YES;
    
    
// terms and policy label
    
    FRHyperLabel *label = self.termLabel;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Helvitica" size:12]];
   // UIFont *text1Font = [UIFont fontWithName:@"Helvitica" size:12];
    
    //Step 1: Define a normal attributed string for non-link texts
    
    NSString *string = @"By signing in, you agree to our Terms of Service and Privacy Policy";
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:(40/255.0) green:40/255.0 blue:40/255.0 alpha:1],NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]};
    
    
    label.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    
    //Step 2: Define a selection handler block
    
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring)
    {

        if ([substring isEqualToString:@"Terms of Service"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/terms.html"]];

        }
        if ([substring isEqualToString:@"Privacy Policy"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/privacy.html"]];
            
        }
    };
    
    //Step 3: Add link substrings
    
    [label setLinksForSubstrings:@[@"Terms of Service", @"Privacy Policy"] withLinkHandler:handler];

    
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)LoginView:(id)sender
{
    


    
     }
     
-(IBAction)signUpView:(id)sender
{
   
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
   
    if(connection==Connection_sinupFb)
    {
        [webData_sinupFb setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
       if(connection==Connection_sinupFb)
    {
        [webData_sinupFb appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  
    if (connection==Connection_sinupFb)
    {
        
        Array_sinupFb=[[NSMutableArray alloc]init];
        // SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        // Array_sinup=[objSBJsonParser objectWithData:webData_sinup];
        NSString * ResultString=[[NSString alloc]initWithData:webData_sinupFb encoding:NSUTF8StringEncoding];
        Array_sinupFb=[NSJSONSerialization JSONObjectWithData:webData_sinupFb options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_sinup %@",Array_sinupFb);
          NSLog(@"registration_status %@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"nullerror"])
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
        else if ([ResultString isEqualToString:@"inserterror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in creating your account. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in creating your account. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else if(Array_sinupFb.count!=0)
        {
            if([[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"] isEqualToString:@"NEWUSER"])
            {
//                   [self performSegueWithIdentifier:@"next" sender:self];
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                SinupStepOneViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepOneViewController"];
                [self.navigationController pushViewController:set animated:YES];
                
                [Flurry logEvent:@"Registration" timed:YES];
                
               
            }
            else if([[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"] isEqualToString:@"COMPLETE"])
            {
              

        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             MainProfilenavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
                
             
                
                
            
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"fname"] forKey:@"fname"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"userid"] forKey:@"userid"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emailid"] forKey:@"emailid"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"gender"] forKey:@"gender"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity1"] forKey:@"activity1"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity2"] forKey:@"activity2"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity3"] forKey:@"activity3"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"agegroup"] forKey:@"agegroup"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmatch"] forKey:@"Switch1"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmessage"] forKey:@"Switch2"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"birthdate"] forKey:@"DOB"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"city"] forKey:@"city"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"country"] forKey:@"country"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"description"] forKey:@"description"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"distance"] forKey:@"distance"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] forKey:@"English"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"] forKey:@"French"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"Arabic"];
                
                
                if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&[[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                {
                  
                    [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] forKey:@"language"];
                }
                if ([[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && ![[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&[[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                {
                    
                    [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"] forKey:@"language"];
                }

                if ([[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                {
                    
                    [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"language"];
                }

             
                if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && [[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                {
                     [defaults setObject:[NSString stringWithFormat:@"%@%@%@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]] forKey:@"language"];
                }

           
                
                if (![[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"]isEqualToString:@""] && ![[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]isEqualToString:@""] &&![[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"]isEqualToString:@""] )
                {
                    [defaults setObject:[NSString stringWithFormat:@"%@%@%@%@%@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"],@",",[[Array_sinupFb objectAtIndex:0]valueForKey:@"frenchlang"]] forKey:@"language"];
                }
                
                
                
                
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji1"] forKey:@"emoji1"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji2"] forKey:@"emoji2"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji3"] forKey:@"emoji3"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"icanmeet"] forKey:@"icanmeet"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"liketoplay"] forKey:@"liketoplay"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"makefriendswith"] forKey:@"makefriendswith"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"profilepic"] forKey:@"profilepic"];
                
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"age"] forKey:@"age"];
                
                [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"superhero"] forKey:@"superhero"];
                
                
                [defaults setObject:@"yes" forKey:@"Loginplay"];
                [defaults synchronize];
                [self.view hideActivityViewWithAfterDelay:1];
                
                NSLog(@"ValuesOfSecondView33=%@",[defaults valueForKey:@"liketoplay"]);
                NSLog(@"ValuesOfSecondView33=%@", [defaults valueForKey:@"liketoplay"]);
                NSLog(@"ValuesOfSecondView33=%@", [defaults valueForKey:@"icanmeet"]);
                
            }
        }
        else if(Array_sinupFb.count==0 && [ResultString isEqualToString:@""])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Server has reported an error. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Server has reported an error. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
    }
}
-(IBAction)FbLogin:(id)sender
{
    if (location)
    {
        
    
    
      CityNamestr=[defaults valueForKey:@"Cityname"];
      CountryNameStr=[defaults valueForKey:@"Countryname"];
//    channelID = [defaults valueForKey:@"ChannelId"];
//    NSLog(@"channel id hdghdg=%@",channelID);
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
       confirmView.hidden=NO;
    [self.view showActivityViewWithLabel:@"Loading"];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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

        
        
        
        
        
        
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
  
  
    [login logInWithReadPermissions: @[@"public_profile", @"email"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         NSLog(@"Process result=%@",result);
         NSLog(@"Process error=%@",error);
         if (error)
         {
             [self.view hideActivityViewWithAfterDelay:1];
             confirmView.hidden=YES;
             NSLog(@"Process error");
         }
         else if (result.isCancelled)
         {
             [self.view hideActivityViewWithAfterDelay:1];
             confirmView.hidden=YES;
             NSLog(@"Cancelled");
         }
         else
         {
             
            
             NSLog(@"Logged in");
             NSLog(@"Process result123123=%@",result);
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,first_name,last_name,gender,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     if ([result isKindOfClass:[NSDictionary class]])
                     {
                         NSLog(@"Results=%@",result);
                         FbmailId=[result objectForKey:@"email"];
                         FbuserID=[result objectForKey:@"id"];
                         FbFirstname=[result objectForKey:@"first_name"];
                         Fblastname=[result objectForKey:@"last_name"];
                         FbuserFullname=[result objectForKey:@"name"];
                         GenderFb=[result objectForKey:@"gender"];
                         
                         if ([GenderFb isEqualToString:@"male"])
                         {
                              [Flurry setGender:@"m"];
                         }
                         else
                         {
                             [Flurry setGender:@"f"];
                         }

                        
                         FbprofileImg= [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", FbuserID];
                       
                         NSLog(@"my url DataFBB=%@",result);
                         
                             NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
                         
                             NSString *documentsPath = [paths objectAtIndex:0];
                         
                             NSString *plistPath1 = [documentsPath stringByAppendingPathComponent:@"ImagePlist.plist"];
                         
                         
                             NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects:FbprofileImg,FbFirstname,Fblastname,FbuserFullname,GenderFb ,@"yes",nil] forKeys:[NSArray arrayWithObjects: @"Image",@"Fname",@"Lname",@"FullName",@"Gender",@"FBLogin" ,nil]];
                         
                         
                             NSString *error = nil;
                         
                             NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
                         
                         
                                         if(plistData)
                         
                                         {
                                 
                                             [plistData writeToFile:plistPath1 atomically:YES];
                                             NSLog( @"Data saved sucessfully");;
                                             NSLog( @"nshom=%@",NSHomeDirectory());;
                                         }
                                         else
                                         {
                                             NSLog( @"Data saved nooosucessfully");
                                         }
                         
                         [defaults setObject:CityNamestr forKey:@"Cityname"];
                         [defaults setObject:CountryNameStr forKey:@"Countryname"];
                         [defaults setObject:FbuserID forKey:@"fid"];
                         
                         [defaults synchronize];
                         
                         NSLog(@"citydffff=%@",[defaults valueForKey:@"Cityname"]);
                         NSLog(@"countryfdsee=%@",[defaults valueForKey:@"Countryname"]);
                         [self FbcommunicationServer];

                     }

//                     NSString *nameOfLoginUser = [result valueForKey:@"name"];
//                     NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
//                     NSLog(@"sachh=%@",nameOfLoginUser);
//                     NSLog(@"sachh=%@",[result valueForKey:@"email"]);
//                     NSLog(@"sachh=%@",imageStringOfLoginUser);
                     //              NSURL *url = [[NSURL alloc] initWithURL: imageStringOfLoginUser];
                     //                [self.imageView setImageWithURL:url placeholderImage: nil];
                 }
             }];
             
         }
         
     }];
    
                              
    }
        
        
    }
    else
    {
        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
//                                                        message:@"To re-enable, please go to Settings and turn on Location Service for this app."
//                                                       delegate:self
//                                              cancelButtonTitle:@"Ok"
//                                              otherButtonTitles:nil];
//        alert.tag=7;
//        [alert show];
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"App Permission Denied" message:@"To re-enable, please go to Settings and turn on Location Service for this app." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
            {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    
    
                      
    }

-(void)FbcommunicationServer
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        message.tag=100;
//        [message show];
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                     //  [alertController dismissViewControllerAnimated:YES completion:nil];
                                       exit(0);
                                   }];

        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else
    {
 
    NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
    NSString *  urlStrLivecount=[urlplist valueForKey:@"signupwithfb"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];//Web API Method
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSString *Emailstr= @"emailid";
    NSString *EmailstrValue =FbmailId ;
    NSString *fnamestr= @"fname";
    NSString *fnamestrValue =FbFirstname;
    NSString *lnamestr= @"lname";
    NSString *lnamestrValue =Fblastname;
    NSString *fbId= @"fbid";
    NSString *fbIdValue =FbuserID;
    NSString *ImageUrl= @"imageurl";
    NSString *ImageUrlValues =FbprofileImg;
    NSString *Gender= @"gender";
    NSString *GenderValues =GenderFb;
    
        
        
//        channelID = [UAirship push].channelID;
        NSString *ChanelId= @"devicetoken";
 //       NSString *ChanelIdVAl = channelIDglobal;
//        if ([[UAirship push].channelID isEqualToString:@""])
//        {
//            [defaults valueForKey:@"ChannelId"];
//        }
//        else
//        {
//            ChanelIdVAl=[UAirship push].channelID;
//        }
       
        
        NSString *Platform= @"platform";
        NSString *PlatformVal =@"ios";
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",Emailstr,EmailstrValue,fnamestr,fnamestrValue,lnamestr,lnamestrValue,fbId,fbIdValue,Gender,GenderValues,ImageUrl,ImageUrlValues,ChanelId,channelIDglobal,Platform,PlatformVal];
    
    
    //converting  string into data bytes and finding the lenght of the string.
        
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    Connection_sinupFb = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_sinupFb)
        {
            webData_sinupFb =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
    }
    
}
- (BOOL)schemeAvailable:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    return [application canOpenURL:URL];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==100)
//    {
//        exit(0);
//    }
//    if (alertView.tag==7)
//    {
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    

    
    [Flurry setLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude horizontalAccuracy:currentLocation.horizontalAccuracy verticalAccuracy:currentLocation.verticalAccuracy];

    
    //
    //    if (currentLocation != nil) {
    //        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    //        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    //    }
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0) {
             placemark = [placemarks lastObject];
             NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
             NSLog(@"placemark.country %@",placemark.country);
             NSLog(@"placemark.postalCode %@",placemark.postalCode);
             NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
             NSLog(@"placemark.locality %@",placemark.locality);
             NSLog(@"placemark.subLocality %@",placemark.subLocality);
             NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
             
             
             NSLog(@"placemark.subThoroughfare %@",[defaults valueForKey:@"Cityname"]);
             
             
             if (placemark.locality !=nil && placemark.country !=nil)
             {
                  Label_DectLoc.hidden=YES;
                 FbBt.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
                  FbBt.enabled=YES;
                 [FbBt setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
                 [defaults setObject:placemark.locality forKey:@"Cityname"];
                 [defaults setObject:placemark.country forKey:@"Countryname"];
                 [defaults synchronize];



                 [locationManager stopUpdatingLocation];
             }
             
             
         }
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
     } ];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error
{
    if([CLLocationManager locationServicesEnabled])
    {
        NSLog(@"Location Services Enabled");
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            location = false;
            
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
//                                                            message:@"To re-enable, please go to Settings and turn on Location Service for this app."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            alert.tag=7;
//            [alert show];
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"App Permission Denied" message:@"To re-enable, please go to Settings and turn on Location Service for this app." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                    {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                    }];
            
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

           
        }
 
    
    }

}

- (void)registrationSucceededForChannelID:(NSString *)channelID deviceToken:(nonnull NSString *)deviceToken {
    
    NSLog(@"CHANNELLLLLLLL IDDD= %@",channelID);
    
//    [defauls setObject:channelID forKey:@"ChannelId"];
//    [defauls synchronize];
    
//    NSLog(@"CHANNELLLLLLLL IDDD11111= %@",[defauls valueForKey:@"ChannelId"]);
    channelIDglobal=channelID;
    
}



@end
