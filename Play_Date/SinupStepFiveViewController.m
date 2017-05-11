//
//  SinupStepFiveViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "SinupStepFiveViewController.h"
#import "Reachability.h"
#import "Base64.h"
#import "MainProfilenavigationController.h"
#import "UIViewController+KeyboardAnimation.h"
#import <AirshipKit/AirshipKit.h>
#import "IntroScreenViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Flurry.h"
@interface SinupStepFiveViewController ()<UITextFieldDelegate,CLLocationManagerDelegate>
{
    NSDictionary *urlplist;
    NSURLConnection *Connection_Reg;
    NSMutableData *webData_Reg;
    NSMutableArray *Array_sinupFb;
     NSString *encodedImage;
    NSUserDefaults *defaults;
    UIView * confirmView;
    UIActivityIndicatorView *indicatorAlert;
    NSMutableArray * Array_Activity;
    CABasicAnimation* animation;
    CLLocationManager *locationManager ;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;

@end

static const CGFloat kButtonSpaceShowed = 90.0f;
static const CGFloat kButtonSpaceHided = 24.0f;
#define kBackgroundColorShowed [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
#define kBackgroundColorHided [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];

@implementation SinupStepFiveViewController
@synthesize LetPlayButton,HeadTopView,Type_Txt,Save_Button;
- (void)viewDidLoad
{
    [super viewDidLoad];
     [UAirship push].registrationDelegate = self;
    defaults=[[NSUserDefaults alloc]init];
    Type_Txt.delegate=self;
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
  [HeadTopView.layer addSublayer:borderBottom];
     [Type_Txt becomeFirstResponder];
    Type_Txt.clipsToBounds=YES;
    Type_Txt.layer.cornerRadius=Type_Txt.frame.size.height/2;
    
    CALayer *borderTop = [CALayer layer];
    borderTop.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    borderTop.frame = CGRectMake(0, 0, LetPlayButton.frame.size.width, 1);
    [LetPlayButton.layer addSublayer:borderTop];
    if ([[defaults valueForKey:@"settingpage"] isEqualToString:@"yes"])
    {
        Type_Txt.text=[defaults valueForKey:@"superhero"];
          LetPlayButton.hidden=YES;
        Save_Button.hidden=NO;
    }
    else
    {
         LetPlayButton.hidden=NO;
         Save_Button.hidden=YES;
         NSLog(@"superhero = %@",[defaults valueForKey:@"superhero"]);
        
        NSString * sup = [defaults valueForKey:@"superhero"];
        
        if (![[defaults valueForKey:@"superhero"] isEqualToString:@""])
    {
        NSLog(@"superhero = %@",[defaults valueForKey:@"superhero"]);
        
        Type_Txt.text=[defaults valueForKey:@"superhero"];
        LetPlayButton.enabled=YES;
    }
    else
    {
     LetPlayButton.enabled=NO;
    }
        
        if ([Type_Txt.text isEqualToString:@""]) {
            LetPlayButton.enabled = NO;
        
        }
        else
        {
            LetPlayButton.enabled = YES;
        }
        
    }
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    Array_Activity=[[NSMutableArray alloc]init];
    Array_Activity=[defaults valueForKey:@"Activitys"];
    
    [self imageUploadOnFrame];
    
  NSData *imageData = [defaults valueForKey:@"Proimage"];
    
    // imageData = UIImageJPEGRepresentation([defaults valueForKey:@"Proimage"], 0.0);
    
    // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImage *image = [UIImage imageWithData:[defaults valueForKey:@"Proimage"]];

   
  
NSData* imageData1 = UIImageJPEGRepresentation(image, 0.0);
      NSString * ImageNSdata= [Base64 encode:imageData1];
   encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));

    
    confirmView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    confirmView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
//    UIActivityIndicatorView *  indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorAlert.frame=CGRectMake( confirmView.center.x, confirmView.center.y+120, 20, 20);
//    //  indicatorAlert.center=confirmView.center;
//    [indicatorAlert startAnimating];
//    [indicatorAlert setColor:[UIColor whiteColor]];
    
#pragma mark  - teddy spin
    
    UIImageView *Image_Animated = [[UIImageView alloc]initWithFrame:CGRectMake(confirmView.center.x-25, confirmView.center.y+100, 50, 50)];
    
    Image_Animated.image = [UIImage imageNamed:@"bearicon"];
    
    Image_Animated.contentMode=UIViewContentModeScaleAspectFit;
    Image_Animated.hidden=NO;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    
   
    
    UILabel * confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, Image_Animated.frame.origin.y+60, self.view.frame.size.width, 40)];
    
    confirm.textColor=[UIColor whiteColor];
    confirm.text=@"Creating Profile...";
    
    confirm.font=[UIFont fontWithName:@"KG Feeling 22" size:30.0f];
    confirm.textAlignment=NSTextAlignmentCenter;
    
    [confirmView addSubview:confirm];

    
   // [confirmView addSubview:indicatorAlert];
    [confirmView addSubview:Image_Animated];
    
    [self.view addSubview:confirmView];
    confirmView.hidden=YES;
    
 
    
#pragma mark -Location
    
    if ([defaults valueForKey:@"Cityname"] == nil)
        
    {
        
    locationManager = [[CLLocationManager alloc] init] ;
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy =kCLLocationAccuracyThreeKilometers; //kCLLocationAccuracyNearestTenMeters;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}
- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            
        } else
        {
            
            self.tabBarBottomSpace.constant = 0.0f;
            
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(IBAction)BackView:(id)sender
{
    [defaults setObject:Type_Txt.text forKey:@"superhero"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)LetPlayButtonAct:(id)sender
{
    if ([defaults valueForKey:@"Cityname"] != nil)
    {
    
    
    [self.view endEditing:YES];
  confirmView.hidden=NO;
    [self clientServerComm];
    }
    else
    {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No location found"
//                                                        message:@"We could not resolve your location. Please make sure you are in active network coverage area or try switching on your Wifi, and try again."
//                                                       delegate:self
//                                              cancelButtonTitle:@"Ok"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No location found" message:@"We could not resolve your location. Please make sure you are in active network coverage area or try switching on your Wifi, and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        

    }
    
}

- (IBAction)TypenameAct:(id)sender
{
    if (Type_Txt.text.length==0)
    {
         LetPlayButton.enabled=NO;
    }
    else
    {
         LetPlayButton.enabled=YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [Type_Txt resignFirstResponder];
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
        [textField resignFirstResponder];
    return YES;
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"signupstep5"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        NSString *fname= @"fname";
        NSString *fnameVal =[defaults valueForKey:@"fname"];
        
        NSString *lname= @"lname";
        NSString *lnameVal =[defaults valueForKey:@"llname"];
        
        NSString *gender= @"gender";
        NSString *genderVal =[defaults valueForKey:@"gender"];
        
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        
       // NSString *currentDateString =[defaults valueForKey:@"DOB"];// @"04-Feb-2018";
        
//        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
//        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
//        
//        NSLog(@"CurrentDate:%@", currentDate);
        
        
        NSString *birthdate= @"birthdate";
        NSString *birthdateVal =[defaults valueForKey:@"DOB"];
        
        NSString *city= @"city";
        NSString *cityVal =[defaults valueForKey:@"Cityname"];

        NSString *country= @"country";
        NSString *countryVal =[defaults valueForKey:@"Countryname"];
        
      // if location is null call method update location

        NSString *ChanelId= @"devicetoken";
        NSString *ChanelIdVAl;
        if ([[UAirship push].channelID isEqualToString:@""])
        {
            [defaults valueForKey:@"ChannelId"];
        }
        else
        {
            ChanelIdVAl=[UAirship push].channelID;
        }
        
        
        NSString *Platform= @"platform";
        NSString *PlatformVal =@"ios";
        
        NSString * arryString=[defaults valueForKey:@"language"];
        NSArray *arr = [arryString componentsSeparatedByString:@","];
        NSMutableArray* Array_addlanguges=[[NSMutableArray alloc]init];
        if (![arryString isEqualToString:@""])
        {
            Array_addlanguges = [NSMutableArray arrayWithArray:arr];
        }
        
        
        NSString *englang= @"englang";
        NSString *englangVal =@"";
        
        NSString *arabiclang= @"arabiclang";
        NSString *arabiclangVal =@"";
        
        NSString *frenchlang= @"frenchlang";
        NSString *frenchlangVal=@"";
        if (Array_addlanguges.count==1)
        {
            
            englangVal =[Array_addlanguges objectAtIndex:0];
            
            
        }
        else if(Array_addlanguges.count==2)
        {
            englangVal =[Array_addlanguges objectAtIndex:0];
            arabiclangVal =[Array_addlanguges objectAtIndex:1];
            
        }
        else if(Array_addlanguges.count==3)
        {
            englangVal =[Array_addlanguges objectAtIndex:0];
            arabiclangVal =[Array_addlanguges objectAtIndex:1];
            frenchlangVal =[Array_addlanguges objectAtIndex:2];
        }
        
        
        NSString *description= @"description";
        NSString *descriptionVal =[defaults valueForKey:@"description"];
        
        
        NSString *iliketoplay= @"liketoplay";
        NSString *iliketoplayVal =[defaults valueForKey:@"liketoplay"];
        
        NSString *icanmeet= @"icanmeet";
        NSString *icanmeetVal =[defaults valueForKey:@"icanmeet"];
        
    
        NSString *activity1= @"activity1";
        NSString *activity1Val =[Array_Activity objectAtIndex:0];
        
        NSString *activity2= @"activity2";
        NSString *activity2Val =[Array_Activity objectAtIndex:1];
        
        NSString *activity3= @"activity3";
        NSString *activity3Val =[Array_Activity objectAtIndex:2];
        
        
        NSString *emoji1= @"emoji1";
        NSString *emoji1Val =[defaults valueForKey:@"emoji1"];
        
        NSString *emoji2= @"emoji2";
        NSString *emoji2Val =[defaults valueForKey:@"emoji2"];
        
        NSString *emoji3= @"emoji3";
        NSString *emoji3Val =[defaults valueForKey:@"emoji3"];
        
        NSString *superhero= @"superhero";
        NSString *superheroVal =Type_Txt.text;

        
        NSString *profileimage= @"profileimage";
        
        NSString *dummy= @"dummy1";
        NSString *dummyVal =@"dummyvalue";
     
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,fname,fnameVal,lname,lnameVal,gender,genderVal,birthdate,birthdateVal,city,cityVal,country,countryVal,englang,englangVal,arabiclang,arabiclangVal,frenchlang,frenchlangVal,description,descriptionVal,iliketoplay,iliketoplayVal,icanmeet,icanmeetVal,activity1,activity1Val,activity2,activity2Val,activity3,activity3Val,emoji1,emoji1Val,emoji2,emoji2Val,emoji3,emoji3Val,superhero,superheroVal,profileimage,encodedImage,Platform,PlatformVal,ChanelId,ChanelIdVAl,dummy,dummyVal];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_Reg = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Reg)
            {
                webData_Reg =[[NSMutableData alloc]init];
                
                
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
    
    if(connection==Connection_Reg)
    {
        [webData_Reg setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Reg)
    {
        [webData_Reg appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     confirmView.hidden=YES;
    
    if (connection==Connection_Reg)
    {
        
        Array_sinupFb=[[NSMutableArray alloc]init];
        // SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        // Array_sinup=[objSBJsonParser objectWithData:webData_sinup];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Reg encoding:NSUTF8StringEncoding];
        Array_sinupFb=[NSJSONSerialization JSONObjectWithData:webData_Reg options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_sinup %@",Array_sinupFb);
        NSLog(@"registration_status %@",[[Array_sinupFb objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString %@",ResultString);
        
        
//-----------------------------------ERROR CODES LETS PLAY START---------------------------------------------------------------
        
        
        if ([ResultString isEqualToString:@"error"])
            
        {
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        else if ([ResultString isEqualToString:@"updateerror"])
            
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in creating your account. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        else if ([ResultString isEqualToString:@"imagenull"])
            
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected a profile image. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        else if ([ResultString isEqualToString:@"imageerror"])
            
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the profile image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        else if ([ResultString isEqualToString:@"selecterror"])
            
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        
        else if ([ResultString isEqualToString:@"nameerror"])
            
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have used some special characters in your child's name. Please use alphabets/numbers only, and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else if ([ResultString isEqualToString:@"descriptionerror"])
            
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have used some special characters in your profile description. Please use alphabets/numbers only, and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        else if ([ResultString isEqualToString:@"superheroerror"])
            
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have used some special characters while entering your favourite superhero. Please use alphabets/numbers only, and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        

        
//------------------------------------ERROR CODES END---------------------------------------------------------------------------
        
        
        else if ((Array_sinupFb.count !=0))
        {
         // [self performSegueWithIdentifier:@"next" sender:self];
            
          
 
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"fname"] forKey:@"fname"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"userid"] forKey:@"userid"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emailid"] forKey:@"emailid"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"gender"] forKey:@"gender"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity1"] forKey:@"activity1"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity2"] forKey:@"activity2"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"activity3"] forKey:@"activity3"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"agegroup"] forKey:@"agegroup"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"Arabic"];
            
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmatch"] forKey:@"Switch1"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"pushmessage"] forKey:@"Switch2"];
            
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"birthdate"] forKey:@"DOB"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"city"] forKey:@"city"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"country"] forKey:@"country"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"description"] forKey:@"description"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"distance"] forKey:@"distance"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"englang"] forKey:@"English"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji1"] forKey:@"emoji1"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji2"] forKey:@"emoji2"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"emoji3"] forKey:@"emoji3"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"icanmeet"] forKey:@"icanmeet"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"liketoplay"] forKey:@"liketoplay"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"makefriendswith"] forKey:@"makefriendswith"];
            
            [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"superhero"] forKey:@"superhero"];
            
            
              [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"profilepic"] forKey:@"profilepic"];
            
             [defaults setObject:[[Array_sinupFb objectAtIndex:0]valueForKey:@"age"] forKey:@"age"];
            [defaults synchronize];
            
            
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
            
            
            
            
            [defaults setObject:@"yes" forKey:@"Loginplay"];
            [defaults synchronize];
            
            [Flurry setUserID:[defaults valueForKey:@"fid"]];
            [Flurry endTimedEvent:@"Registration" withParameters:nil];

            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            IntroScreenViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"IntroScreenViewController"];
            [self.navigationController pushViewController:set animated:YES];
            
            
     
            
            
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            MainProfilenavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
//            [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
        }
    }
}
-(void)imageUploadOnFrame
{
    
}
-(IBAction)SaveButton:(id)sender
{
    [defaults setObject:Type_Txt.text forKey:@"superhero"];
    [defaults synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if (textField == Type_Txt) {
        int lengtha = [Type_Txt.text length];
        NSLog(@"lenghta = %d",lengtha);
        if (lengtha >=20 && ![string isEqualToString:@""])
        {
            Type_Txt.text = [Type_Txt.text substringToIndex:20];
            return NO;
        }
        return YES;
    }
    return YES;
}


#pragma mark - Location delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
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
            //location = false;
            
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
//                                                            message:@"To re-enable, please go to Settings and turn on Location Service for this app."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//           
//            [alert show];
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"App Permission Denied" message:@"To re-enable, please go to Settings and turn on Location Service for this app." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
            
            
        }
        
        
    }
    
}


@end
