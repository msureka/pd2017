//
//  DiscoverViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "DiscoverViewController.h"
#import "UIImageView+WebCache.h"
#import "MainProfilenavigationController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "TabbarMainProViewController.h"
#import "DiscoverInfoViewController.h"
#import "ProfileMatchViewController.h"
#import "AdProfileMatchViewController.h"
#import "WhereViewController.h"

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle

@interface DiscoverViewController ()
{
    NSInteger cardsLoadedIndex;
    NSInteger arrayIndex;
    //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    CABasicAnimation* animation;
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
    
    NSUserDefaults * defautls;
    NSDictionary *urlplist;
    NSURLConnection *Connection_LodingPro,*Connection_Swipe,*Connection_Flag;
    NSMutableData *webData_LodingPro,*webData_Swipe,*webData_Flag;
    NSMutableArray *Array_LodingPro,*Array_Swipe,*Array_Flag;
    NSString *SwipeKeyString,*fid2String;
    DraggableView *draggableView;
    UIView * ViewDetails;
    CGFloat xFromCenter;
    CGFloat yFromCenter;
   CGFloat lang1xx,lang1yy,lang1ww,lang1hh,lang2xx,lang3xx,lang4xx,lang5xx;
    NSString *FlagStatus;
     CGFloat Imagetoplogoxx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh,Imagetoplogo2xx,Imagetoplogo3xx,Imagetoplogo11xx,Imagetoplogo22xx;
    
    NSInteger *count;
    
}
@end

@implementation DiscoverViewController
@synthesize indicatorView,profileImg,Button_Tapped,LabelProf,LabelTapped,LabelProf_No,DiscoverViewInfo,Image_Animated;
@synthesize panGestureRecognizer,labelDiscover,switchCountryButton,bottomLabelDiscover,secondLabelDiscover,bgViewDiscover;

//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater float

static const float CARD_HEIGHT =667; //%%% height of the draggable card
static const float CARD_WIDTH = 375; //%%% width of the draggable card

@synthesize exampleCardLabels;

@synthesize Array_AllDataProDisc;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] == 0)
    {
        NSLog(@"App launch count 0");
    }
    else
    {
        NSLog(@"App launch count %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"]);
    }
    
    
    
    defautls=[[NSUserDefaults alloc]init];
    
    
    
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    
    
    UITapGestureRecognizer  * ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap11Tapped:)];
    [DiscoverViewInfo addGestureRecognizer:ViewTap11];
    DiscoverViewInfo.hidden=YES;
    FlagStatus=@"Flagno";
    
    LabelProf_No.hidden=YES;
    LabelTapped.hidden=YES;
    Button_Tapped.hidden=YES;
    LabelProf.hidden=NO;
    
    
    bgViewDiscover.hidden = YES;
    labelDiscover.hidden = YES;
    secondLabelDiscover.hidden = YES;
    switchCountryButton.hidden = YES;
    bottomLabelDiscover.hidden = YES;
    switchCountryButton.layer.cornerRadius = switchCountryButton.frame.size.height / 2;
    
    NSString * distance = [defautls valueForKey:@"distance"];
    NSLog(@" distance =%@",distance);
    
    if ([distance isEqualToString:@"CITY"])
    {
        
        [switchCountryButton setTitle:@"Search my country" forState:UIControlStateNormal];
        bottomLabelDiscover.text = @"Discover people from your country";
        
    }
    else if ([distance isEqualToString:@"COUNTRY"])
    {
   
        [switchCountryButton setTitle:@"Search the world" forState:UIControlStateNormal];
        bottomLabelDiscover.text = @"Discover people from around the world";
    }
    else
    {
        
    }
    

    
    

    arrayIndex=0;
    
    
    UIImage *image = [UIImage imageWithData:[defautls valueForKey:@"Proimage"]];
    
    profileImg.image=image;
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    NSString * urlstr=[defautls valueForKey:@"profilepic"] ;//[NSString stringWithFormat:@"%@%@%@",[urlplist valueForKey:@"urlname"],[defautls valueForKey:@"fid"],@".jpg"];
    
    NSURL * url=[NSURL URLWithString:urlstr];
    
    //[profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
    
    
    
    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
        _ImageBack1.image=[UIImage imageNamed:@"boypictureframe 1.png"];
        self.tabBarController.tabBar.barTintColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
        [profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]
                               options:SDWebImageRefreshCached];
        
    }
    else
    {
        _ImageBack1.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
        self.tabBarController.tabBar.barTintColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
        [profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]
                               options:SDWebImageRefreshCached];
    }
    
    
    
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
    
    
    
    
    
    
    NSLog(@"Array_AllDataProDisc==%@",Array_AllDataProDisc);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"PassDataArray" object:nil];
    
    
    NSLog(@"Frames sizes from DSH=%f",_ImageBack1.frame.size.height);
    NSLog(@"Frames sizes from DSW=%f",_ImageBack1.frame.size.width);
    NSLog(@"Frames sizes from DSX=%f",_ImageBack1.frame.origin.x);
    NSLog(@"Frames sizes from DSY=%f",_ImageBack1.frame.origin.y);
    
    //    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    //
    //    [self.view addSubview:draggableBackground];
    
    
    
    
    [self setupView];
    
    
    loadedCards = [[NSMutableArray alloc] init];
    _allCards = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    if ([[defautls valueForKey:@"savePressed"] isEqualToString:@"YES"])
    {
    
    NSString * distance = [defautls valueForKey:@"distance"];
    NSLog(@" distance =%@",distance);
    
    if ([distance isEqualToString:@"CITY"])
    {
        
        [switchCountryButton setTitle:@"Search my country" forState:UIControlStateNormal];
        bottomLabelDiscover.text = @"Discover people from your country";
        [self loadProfileMethod];
        
    }
    else if ([distance isEqualToString:@"COUNTRY"])
    {
        
        [switchCountryButton setTitle:@"Search the world" forState:UIControlStateNormal];
        bottomLabelDiscover.text = @"Discover people from around the world";
        
        [self loadProfileMethod];
    }
    else
    {
        bgViewDiscover.hidden = YES;
        labelDiscover.hidden = YES;
        secondLabelDiscover.hidden = YES;
        switchCountryButton.hidden = YES;
        bottomLabelDiscover.hidden = YES;
        
        [self loadProfileMethod];
    }
         [defautls setObject:@"no" forKey:@"savePressed"];
        
    }
    else
    {
        
    }
    
    
    
    Image_Animated.hidden=NO;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    
    if(LabelProf.hidden)
    {
          Image_Animated.hidden=YES;
        //here button1 is hidden , so you can write code accordingly...
    }else
    {
        //here button1 is  not hidden , so you can write code accordingly...
          Image_Animated.hidden=NO;
    }
    
    if ([[defautls valueForKey:@"settingDone"] isEqualToString:@"yes"])
    {
        
    
        Image_Animated.hidden=NO;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: M_PI/2];
        animation.duration = 0.3;
        animation.repeatCount = INFINITY;
        animation.autoreverses=YES;
        
        [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
  
    
    if (arrayIndex==0)
    {
         [self swipeLeft];
        arrayIndex=1;
    }
    for (int i=0; i<arrayIndex; i++)
    {
        [self swipeLeft];
       
    }
 
        

    
        [loadedCards removeAllObjects];
        [_allCards removeAllObjects];
        
        cardsLoadedIndex = 0;
        UITapGestureRecognizer  * ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap11Tapped:)];
        [DiscoverViewInfo addGestureRecognizer:ViewTap11];
        DiscoverViewInfo.hidden=YES;
        FlagStatus=@"Flagno";
        
        LabelProf_No.hidden=YES;
        LabelTapped.hidden=YES;
        Button_Tapped.hidden=YES;
        LabelProf.hidden=NO;
        
        bgViewDiscover.hidden = YES;
        labelDiscover.hidden = YES;
        secondLabelDiscover.hidden = YES;
        switchCountryButton.hidden = YES;
        bottomLabelDiscover.hidden = YES;
        
        
        
        arrayIndex=0;
    
    
    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
        _ImageBack1.image=[UIImage imageNamed:@"boypictureframe 1.png"];
    }
    else
    {
        _ImageBack1.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
    }
    
    UIImage *image = [UIImage imageWithData:[defautls valueForKey:@"Proimage"]];
    
    profileImg.image=image;
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    NSString * urlstr=[defautls valueForKey:@"profilepic"] ;//[NSString stringWithFormat:@"%@%@%@",[urlplist valueForKey:@"urlname"],[defautls valueForKey:@"fid"],@".jpg"];
    
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
        
        
        [defautls setObject:@"no" forKey:@"settingDone"];
        [defautls synchronize];
        
        
        
        [self clientServerComm];
        
        
        NSLog(@"Array_AllDataProDisc==%@",Array_AllDataProDisc);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"PassDataArray" object:nil];
        
        
        NSLog(@"Frames sizes from DSH=%f",_ImageBack1.frame.size.height);
        NSLog(@"Frames sizes from DSW=%f",_ImageBack1.frame.size.width);
        NSLog(@"Frames sizes from DSX=%f",_ImageBack1.frame.origin.x);
        NSLog(@"Frames sizes from DSY=%f",_ImageBack1.frame.origin.y);
    }
    
}
-(void)clientServerComm
{
    [indicatorView startAnimating];
    LabelProf_No.hidden=YES;
    LabelTapped.hidden=YES;
    Button_Tapped.hidden=YES;
    LabelProf.hidden=NO;
    bgViewDiscover.hidden = YES;
    labelDiscover.hidden = YES;
    secondLabelDiscover.hidden = YES;
    switchCountryButton.hidden = YES;
    bottomLabelDiscover.hidden = YES;
    
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"lookingprofiles"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defautls valueForKey:@"fid"];
        
        NSString *distance= @"distance";
        NSString *distanceVal = [defautls valueForKey:@"distance"];

        NSString *agegroup= @"agegroup";
        NSString *agegroupVal = [defautls valueForKey:@"agegroup"];

        NSString *makefriendswith= @"makefriendswith";
        NSString *makefriendswithVal = [defautls valueForKey:@"makefriendswith"];
        
        NSString *city= @"city";
        NSString *cityVal = [defautls valueForKey:@"city"];
        
        NSString *country= @"country";
        NSString *countryVal = [defautls valueForKey:@"country"];
        
        NSString *birthdate= @"birthdate";
        NSString *birthdateVal = [defautls valueForKey:@"DOB"];
        
         NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,distance,distanceVal,agegroup,agegroupVal,makefriendswith,makefriendswithVal,city,cityVal,birthdate,birthdateVal,country,countryVal];
        
#pragma mark - nsurlsession
/*
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,distance,distanceVal,agegroup,agegroupVal,makefriendswith,makefriendswithVal,city,cityVal,birthdate,birthdateVal,country,countryVal];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
       
        
        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
        NSString *  urlStrLivecount=[urlplist valueForKey:@"lookingprofiles"];
        
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                                             
    if(data)
            {
                
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = httpResponse.statusCode;
            if(statusCode == 200)
            {
               // Array_LodingPro=[[NSMutableArray alloc]init];
                
                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                Array_LodingPro=[objSBJsonParser objectWithData:data];
                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             //   Array_LodingPro=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
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
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                    [message show];
                    Image_Animated.hidden=YES;
                }
                
                if ([ResultString isEqualToString:@"nullerror"])
                {
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                    
                    [message show];
                    Image_Animated.hidden=YES;
                }
                
                if ([ResultString isEqualToString:@"nofbid"])
                {
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                    
                    [message show];
                    Image_Animated.hidden=YES;
                }
                
                
                
                if ([ResultString isEqualToString:@"noprofiles"])
                {
                    LabelProf_No.hidden=NO;
                    LabelTapped.hidden=NO;
                    Button_Tapped.hidden=NO;
                    LabelProf.hidden=YES;
                    [indicatorView stopAnimating];
                    Image_Animated.hidden=YES;
                    
                }
                
                
                
                if (Array_LodingPro.count !=0)
                {
                    Image_Animated.hidden=YES;
                    Array_AllDataProDisc=Array_LodingPro;
                    [self loadCards];
                    
                    
                }

                                                     
                                                     
                                                     
            }
                                                 
            }
           else if(error)
             {
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                 NSInteger statusCode = httpResponse.statusCode;
                 
                  NSLog(@"error looking Profiles .......%@ %ld",error,(long)statusCode);
              }
                    
            }];
        
        [dataTask resume];
        
        
        
        
*/
        
        
        
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


-(void)SwipeclientServerComm
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
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

        
        
        
    }
    else
    {
        
        
        NSString *fbid1= @"fbid1";
        NSString *fbid1Val = [defautls valueForKey:@"fid"];;
        
        NSString *fbid2= @"fbid2";
        NSString *fbid2Val =fid2String;// [defautls valueForKey:@""];
        
        NSString *SwipeKey= @"swipe";
        NSString *SwipeKeyVal = SwipeKeyString;
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,fbid2,fbid2Val,SwipeKey,SwipeKeyVal];
        

        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
        NSString *  urlStrLivecount=[urlplist valueForKey:@"swipe"];
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
       
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            
         if(data)
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             NSInteger statusCode = httpResponse.statusCode;
             if(statusCode == 200)
             {
  //               webData_Swipe =[[NSMutableData alloc]init];
                 
                 Array_Swipe=[[NSMutableArray alloc]init];
                 SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                 Array_Swipe=[objSBJsonParser objectWithData:data];
                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                 //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                 
                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                 
                 NSLog(@"Array_SwipeArray_Swipe %@",Array_Swipe);
                 
                 
                 NSLog(@"SwipeArray_Swipe ResultString %@",ResultString);
                 if ([ResultString isEqualToString:@"error"])
                 {
//                     UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//                     [message show];
                     
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:nil];
                     [alertController addAction:actionOk];
                     [self presentViewController:alertController animated:YES completion:nil];
                     
                     
                 }
                 if ([ResultString isEqualToString:@"nullerror"])
                 {
//                     UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//                     
//                     [message show];
                     
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:nil];
                     [alertController addAction:actionOk];
                     [self presentViewController:alertController animated:YES completion:nil];

                     
                     
                     
                 }
                 if ([ResultString isEqualToString:@"nofbid"])
                 {
//                     UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//                     
//                     [message show];
                     
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:nil];
                     [alertController addAction:actionOk];
                     [self presentViewController:alertController animated:YES completion:nil];
                     
                 }
                 
                 
                 
                 if(Array_Swipe.count !=0)
                 {
                     if ([[[Array_Swipe valueForKey:@"profiletype"]objectAtIndex:0] isEqualToString:@"PROFILE"])
                     {
                         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         ProfileMatchViewController *   set= [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileMatchViewController"];
                         set.AllArray_data=Array_Swipe;
                         [self presentViewController:set animated:YES completion:nil];
                     }
                     else
                     {
                         if ([[[Array_Swipe valueForKey:@"adstatus"]objectAtIndex:0] isEqualToString:@"ACTIVE"])
                         {
                         
                         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         
                         AdProfileMatchViewController *  set= [mainStoryboard instantiateViewControllerWithIdentifier:@"AdProfileMatchViewController"];
                         set.AllArray_data=Array_Swipe;
                         
                         [self presentViewController:set animated:YES completion:nil];
                             
                             }
                         
                         else  if ([[[Array_Swipe valueForKey:@"adstatus"]objectAtIndex:0] isEqualToString:@"DEACTIVE"])
                         {
                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have missed out on the promotion! Better luck next time!" preferredStyle:UIAlertControllerStyleAlert];
                             
                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                style:UIAlertActionStyleDefault
                                                                              handler:nil];
                             [alertController addAction:actionOk];
                             [self presentViewController:alertController animated:YES completion:nil];
                         }
                         
                         else  if ([[[Array_Swipe valueForKey:@"adstatus"]objectAtIndex:0] isEqualToString:@"OVER"])
                         {
                             
                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have missed out on the promotion as it has been sold-out! Better luck next time!" preferredStyle:UIAlertControllerStyleAlert];
                             
                             UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                style:UIAlertActionStyleDefault
                                                                              handler:nil];
                             [alertController addAction:actionOk];
                             [self presentViewController:alertController animated:YES completion:nil];
                             
                         }

                         
                     }
                     
                     
                     //            [[UIApplication sharedApplication].keyWindow setRootViewController:set];
                 }
                 
                 
                 
             }
             
             else
             {
                 NSLog(@" error swipe ---%ld",(long)statusCode);
                 
             }
             

         }
            else if(error)
            {
                NSLog(@"error swipe.......%@",error.description);
            }
            
            
        }];
        [dataTask resume];

                                         
        
        //converting  string into data bytes and finding the lenght of the string.
//        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        
//        Connection_Swipe = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        {
//            if( Connection_Swipe)
//            {
//                webData_Swipe =[[NSMutableData alloc]init];
//                
//                
//            }
//            else
//            {
//                NSLog(@"theConnection is NULL");
//            }
//        }
        
    }
    
}

-(void)Flagcommunication
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
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

        
        
    }
    else
    {

        
#pragma mark - flag session
        
        
//        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
//        NSString *  urlStrLivecount=[urlplist valueForKey:@"flagprofile"];
//        url =[NSURL URLWithString:urlStrLivecount];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        
//        [request setHTTPMethod:@"POST"];//Web API Method
//        
//        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        
        NSString *fbid1= @"fbid1";
        NSString *fbid1Val = [defautls valueForKey:@"fid"];;
        
        NSString *fbid2= @"fbid2";
        NSString *fbid2Val =[[Array_LodingPro objectAtIndex:arrayIndex]valueForKey:@"fbid"];// [defautls valueForKey:@""];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,fbid2,fbid2Val];
        
        
        
        
        
        //converting  string into data bytes and finding the lenght of the string.
//        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
//        [request setHTTPBody: requestData];
//        
//        Connection_Flag = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        {
//            if( Connection_Flag)
//            {
//                webData_Flag =[[NSMutableData alloc]init];
//                
//                
//            }
//            else
//            {
//                NSLog(@"theConnection is NULL");
//            }
//        }
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"flagprofile"];
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                                             
             if(data)
                {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSInteger statusCode = httpResponse.statusCode;
                if(statusCode == 200)
                {
                                                     
                   // Array_Swipe=[[NSMutableArray alloc]init];
                    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                    Array_Swipe=[objSBJsonParser objectWithData:data];
                    
                    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    
                    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                    
                                                     
                                                     
                }
                else
                {
                  NSLog(@"Error...   %ld",(long)statusCode);
                }
                                             
            }
                else if (error)
                {
                    NSLog(@"flag error=%@",error.description);
                }
                    
                                         
                                         
        }];
       
        [dataTask resume];
        
        
        
        
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
    if(connection==Connection_LodingPro)
    {
        [webData_LodingPro setLength:0];
        
        
    }
    if(connection==Connection_Swipe)
    {
        [webData_Swipe setLength:0];
        
        
    }
    
    if(connection==Connection_Flag)
    {
        [webData_Flag setLength:0];
        
        
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_LodingPro)
    {
        [webData_LodingPro appendData:data];
    }

    if(connection==Connection_Swipe)
    {
        [webData_Swipe appendData:data];
    }
    if(connection==Connection_Flag)
    {
        [webData_Flag appendData:data];
    }
    

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  
    
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
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
    
            Image_Animated.hidden=YES;
        }
        
        if ([ResultString isEqualToString:@"nullerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

             Image_Animated.hidden=YES;
        }
        if ([ResultString isEqualToString:@"nofbid"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
 
             Image_Animated.hidden=YES;
        }
        

        
        if ([ResultString isEqualToString:@"noprofiles"])
        {
            LabelProf_No.hidden=NO;
            LabelTapped.hidden=NO;
            Button_Tapped.hidden=NO;
            LabelProf.hidden=YES;
            
            
            [indicatorView stopAnimating];
            Image_Animated.hidden=YES;
            
            
            NSString * distance = [defautls valueForKey:@"distance"];
            NSLog(@" distance =%@",distance);
            
            if ([distance isEqualToString:@"CITY"])
            {
                [switchCountryButton setTitle:@"Search my country" forState:UIControlStateNormal];
                bottomLabelDiscover.text = @"Discover people from your country";
                bgViewDiscover.hidden = NO;
                labelDiscover.hidden = NO;
                secondLabelDiscover.hidden = NO;
                switchCountryButton.hidden = NO;
                bottomLabelDiscover.hidden = NO;
            }
            else if ([distance isEqualToString:@"COUNTRY"])
            {
                [switchCountryButton setTitle:@"Search the world" forState:UIControlStateNormal];
                bottomLabelDiscover.text = @"Discover people from around the world";
                bgViewDiscover.hidden = NO;
                labelDiscover.hidden = NO;
                secondLabelDiscover.hidden = NO;
                switchCountryButton.hidden = NO;
                bottomLabelDiscover.hidden = NO;
            }
            else
            {
                bgViewDiscover.hidden = YES;
                labelDiscover.hidden = YES;
                secondLabelDiscover.hidden = YES;
                switchCountryButton.hidden = YES;
                bottomLabelDiscover.hidden = YES;

        
            }
            
        }
        
       
        
        if (Array_LodingPro.count !=0)
        {
            Image_Animated.hidden=YES;
            Array_AllDataProDisc=Array_LodingPro;
       [self loadCards];
          
            
        }
    }
    
    
    if (connection==Connection_Swipe)
    {
        
//        Array_Swipe=[[NSMutableArray alloc]init];
//        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
//           Array_Swipe=[objSBJsonParser objectWithData:webData_Swipe];
//        NSString * ResultString=[[NSString alloc]initWithData:webData_Swipe encoding:NSUTF8StringEncoding];
////        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
//        
//        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        
//        NSLog(@"Array_SwipeArray_Swipe %@",Array_Swipe);
//       
//   
//        NSLog(@"SwipeArray_Swipe ResultString %@",ResultString);
//        if ([ResultString isEqualToString:@"error"])
//        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [message show];
//        }
//        if ([ResultString isEqualToString:@"nullerror"])
//        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            
//            [message show];
//        }
//        if ([ResultString isEqualToString:@"nofbid"])
//        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            
//            [message show];
//            
//        }
//
//        
//        
//        if(Array_Swipe.count !=0)
//        {
//            if ([[[Array_Swipe valueForKey:@"profiletype"]objectAtIndex:0] isEqualToString:@"PROFILE"])
//            {
//                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                ProfileMatchViewController *   set= [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileMatchViewController"];
//                set.AllArray_data=Array_Swipe;
//                [self presentViewController:set animated:YES completion:nil];
//            }
//            else
//            {
//                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//             AdProfileMatchViewController *  set= [mainStoryboard instantiateViewControllerWithIdentifier:@"AdProfileMatchViewController"];
//                set.AllArray_data=Array_Swipe;
//                [self presentViewController:set animated:YES completion:nil];
//            }
//           
//       
////            [[UIApplication sharedApplication].keyWindow setRootViewController:set];
//        }
    }
    
    if (connection==Connection_Flag)
    {
        
        Array_Swipe=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Swipe=[objSBJsonParser objectWithData:webData_Flag];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Flag encoding:NSUTF8StringEncoding];
      
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
      
    
    }

    
    
}

-(void)dataReceived:(NSNotification *)noti
{
    NSLog(@"days1111=%@",[[noti userInfo] objectForKey:@"ArrayData"]);
     NSLog(@"Array_AllDataProDisc==%@",Array_AllDataProDisc);
    Array_AllDataProDisc=[[noti userInfo] objectForKey:@"ArrayData"] ;
 
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupView
{
#warning customize all of this.  These are just place holders to make it look pretty
  
}

-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
         draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0,0,320,568)];
    }
 else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
        {
            draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0,0,375, 667)];
        }

         else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
            {
                 draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0,0,414, 736)];
            }
    else
    {
        
        
         draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0,0,320,568)];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@Oops" message:@"sorry! this app is not compatible with ipads use it on iphone" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [alert show];
    }
  
    draggableView.tag=index;
    
    
    
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
               lang1xx=14.0,lang1yy=83.0,lang1ww=92.0,lang1hh=29.0,lang2xx=41.0,lang3xx=114.0,lang4xx=172.0,lang5xx=213.0;
          Imagetoplogoxx=14.0,Imagetoplogoyy=425.0,Imagetoplogoww=73.0,Imagetoplogohh=73.0,Imagetoplogo2xx=123.0,Imagetoplogo3xx=233.0,Imagetoplogo11xx=76.0,Imagetoplogo22xx=178.0;
        
      
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
    {
      
        lang1xx=16.0,lang1yy=98.0,lang1ww=108.0,lang1hh=34.0,lang2xx=48.0,lang3xx=134.0,lang4xx=202.0,lang5xx=250.0;
        
         Imagetoplogoxx=16.0,Imagetoplogoyy=505.0,Imagetoplogoww=86.0,Imagetoplogohh=86.0,Imagetoplogo2xx=144.0,Imagetoplogo3xx=273.0,Imagetoplogo11xx=89.0,Imagetoplogo22xx=209.0;
        
    }
    
    else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
    {
        
     
        lang1xx=18.0,lang1yy=108.0,lang1ww=119.0,lang1hh=38.0,lang2xx=53.0,lang3xx=148.0,lang4xx=223.0,lang5xx=276.0;
        
        Imagetoplogoxx=18.0,Imagetoplogoyy=557.0,Imagetoplogoww=95.0,Imagetoplogohh=95.0,Imagetoplogo2xx=159.0,Imagetoplogo3xx=301.0,Imagetoplogo11xx=98.0,Imagetoplogo22xx=231.0;
        
    }
    else
    {
        lang1xx=14.0,lang1yy=83.0,lang1ww=92.0,lang1hh=29.0,lang2xx=41.0,lang3xx=114.0,lang4xx=172.0,lang5xx=213.0;
        Imagetoplogoxx=14.0,Imagetoplogoyy=425.0,Imagetoplogoww=73.0,Imagetoplogohh=73.0,Imagetoplogo2xx=123.0,Imagetoplogo3xx=233.0,Imagetoplogo11xx=76.0,Imagetoplogo22xx=178.0;
    }
    

    if ([[[Array_LodingPro valueForKey:@"profiletype"] objectAtIndex:index] isEqualToString:@"PROFILE"])
    {
        
    
        
        
        draggableView.tap.enabled=YES;
        draggableView.tap1.enabled = YES;
        
        
        draggableView.Image_TopcompnyImage.hidden=YES;
        draggableView.Label_AddressComp.hidden=YES;;
        draggableView.Label_AddressCompbg.hidden=YES;;
        draggableView.Image_ribbon.hidden=YES;
        draggableView.Label_TitleCompany.hidden=YES;;
        draggableView.Textview_DescCompany.hidden=YES;;
        draggableView.Image_compnyLogo1.hidden=YES;;
        draggableView.Image_compnyLogo2.hidden=YES;;
        draggableView.Image_compnyLogo3.hidden=YES;;
        
        
        draggableView.Image_Left.hidden=NO;;
        draggableView.Image_Right.hidden=NO;;
        draggableView.Back_imageprofile.hidden=NO;;
        draggableView.Front_imageprofile.hidden=NO;;
        draggableView.Label_Name.hidden=NO;;
        draggableView.Label_CityCountry.hidden=NO;;
        draggableView.Label_Emoji1.hidden=NO;
        draggableView.Label_Emoji2.hidden=NO;;
        draggableView.Label_Emoji3.hidden=NO;;
        draggableView.Label_Desc.hidden=NO;;
        draggableView.Label_Favtitle.hidden=NO;;
        
        
        
        
    NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"%@",[dateFormatter1 stringFromDate:[NSDate date]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    
    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init] ;
    [dateFormatte setDateFormat:@"yyyy-MM-dd"];
    NSDate *date2 = [dateFormatte dateFromString:[[Array_LodingPro valueForKey:@"birthdate"] objectAtIndex:index]];
    
    NSDateComponents *components,*components1;
    NSCalendarUnit units,units1;
    NSCalendar *calendar,*calendar1;
    
    calendar = [[NSCalendar alloc]
                initWithCalendarIdentifier:NSGregorianCalendar];
    units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    components = [calendar components:units fromDate:date1];
    
    
    calendar1 = [[NSCalendar alloc]
                 initWithCalendarIdentifier:NSGregorianCalendar];
    units1 = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    components1 = [calendar1 components:units1 fromDate:date2];
    
    
    
    
    NSLog(@"YEARRR--%ld",(long)[components year]);
    
    
    NSLog(@"YEARRR--%ld",(long)[components1 year]);
    draggableView.Label_Favtitle.tag=index;
    
    
//    draggableView.Label_Name.text =[NSString stringWithFormat:@"%@%@%ld%@",[[Array_LodingPro valueForKey:@"fname"] objectAtIndex:index],@", ",([components year]-[components1 year]),@"y"];;
    
     draggableView.Label_Name.text =[NSString stringWithFormat:@"%@%@%@",[[Array_LodingPro valueForKey:@"fname"] objectAtIndex:index],@", ",[[Array_LodingPro valueForKey:@"age"] objectAtIndex:index]];    

    draggableView.Label_CityCountry.text =[NSString stringWithFormat:@"%@%@%@",[[Array_LodingPro valueForKey:@"city"] objectAtIndex:index],@", ",[[Array_LodingPro valueForKey:@"country"] objectAtIndex:index]];//
    draggableView.Label_Desc.text =[[Array_LodingPro valueForKey:@"description"] objectAtIndex:index];
    draggableView.Label_Emoji1.text =[[Array_LodingPro valueForKey:@"emoji1"] objectAtIndex:index];
    draggableView.Label_Emoji2.text =[[Array_LodingPro valueForKey:@"emoji2"] objectAtIndex:index];
    draggableView.Label_Emoji3.text =[[Array_LodingPro valueForKey:@"emoji3"] objectAtIndex:index];
    
       draggableView.Front_imageprofile.tag=index;
     draggableView.Image_Left.tag=index;
    [draggableView.Image_Left addTarget:self action:@selector(Button_Flag:) forControlEvents:UIControlEventTouchDown];
    draggableView.overlayView1.image_flag.tag=index;
    [draggableView.overlayView1.image_flag addTarget:self action:@selector(Button_Flag:) forControlEvents:UIControlEventTouchDown];
    
    NSURL * url=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"profilepic"] objectAtIndex:index]];
    if([[[Array_LodingPro valueForKey:@"gender"]objectAtIndex:index] isEqualToString:@"Boy"])
    {
        
        draggableView.Back_imageprofile.image=[UIImage imageNamed:@"boypictureframe 1.png"];
        [draggableView.Front_imageprofile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]
                                                     options:SDWebImageRefreshCached];
    }
    else
    {
        draggableView.Back_imageprofile.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
        [draggableView.Front_imageprofile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultgirl.jpg"]
                                                     options:SDWebImageRefreshCached];
    }
   
    draggableView.Front_imageprofile.tag=index;
     draggableView.Front_imageprofile.userInteractionEnabled = YES;

   NSString * English_str=[[Array_LodingPro valueForKey:@"englang"] objectAtIndex:index];
  NSString *  Arabic_str= [[Array_LodingPro valueForKey:@"arabiclang"] objectAtIndex:index];
  NSString *  French_str=[[Array_LodingPro valueForKey:@"frenchlang"] objectAtIndex:index];
    
 
  
    
    
    if (![English_str isEqualToString:@""] && [Arabic_str isEqualToString:@""]  && [French_str isEqualToString:@""])
    {
        draggableView.overlayView1.Label_English.frame=CGRectMake(lang3xx,lang1yy,lang1ww, lang1hh);
        draggableView.overlayView1.Label_English.text=English_str;
        
       
    }
        
    
    else if (![English_str isEqualToString:@""] && ![Arabic_str isEqualToString:@""] && ![French_str isEqualToString:@""])
    {
        draggableView.overlayView1.Label_English.frame=CGRectMake(lang1xx,lang1yy,lang1ww, lang1hh);
        draggableView.overlayView1.Label_Arabic.frame=CGRectMake(lang3xx,lang1yy,lang1ww, lang1hh);
        draggableView.overlayView1.Label_French.frame=CGRectMake(lang5xx,lang1yy,lang1ww, lang1hh);
        
        draggableView.overlayView1.Label_English.text=English_str;
        draggableView.overlayView1.Label_Arabic.text=Arabic_str;
        draggableView.overlayView1.Label_French.text=French_str;
        
        
    }
    
    else if(![English_str isEqualToString:@""] && ![Arabic_str isEqualToString:@""] && [French_str isEqualToString:@""])                                                                              {
        
        draggableView.overlayView1.Label_English.frame=CGRectMake(lang2xx,lang1yy,lang1ww, lang1hh);
        draggableView.overlayView1.Label_Arabic.frame=CGRectMake(lang4xx,lang1yy,lang1ww, lang1hh);
        
        draggableView.overlayView1.Label_English.text=English_str;
        draggableView.overlayView1.Label_Arabic.text=Arabic_str;
        
        
    }
       
    
    
    
    draggableView.overlayView1.Label_English.textAlignment=NSTextAlignmentCenter;
    draggableView.overlayView1.Label_English.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    draggableView.overlayView1.Label_English.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    draggableView.overlayView1.Label_English.clipsToBounds=YES;
    draggableView.overlayView1.Label_English.layer.cornerRadius=draggableView.overlayView1.Label_English.frame.size.height/2;
    
    draggableView.overlayView1.Label_Arabic.textAlignment=NSTextAlignmentCenter;
    draggableView.overlayView1.Label_Arabic.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    draggableView.overlayView1.Label_Arabic.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    draggableView.overlayView1.Label_Arabic.clipsToBounds=YES;
    draggableView.overlayView1.Label_Arabic.layer.cornerRadius=draggableView.overlayView1.Label_Arabic.frame.size.height/2;
    
    
    draggableView.overlayView1.Label_French.textAlignment=NSTextAlignmentCenter;
    draggableView.overlayView1.Label_French.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    draggableView.overlayView1.Label_French.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
    draggableView.overlayView1.Label_French.clipsToBounds=YES;
    draggableView.overlayView1.Label_French.layer.cornerRadius=draggableView.overlayView1.Label_French.frame.size.height/2;
    
 
    
      draggableView.overlayView1.Label_Suprhero.text =[[Array_LodingPro valueForKey:@"superhero"] objectAtIndex:index];
      draggableView.overlayView1.Label_Activity1.text =[[Array_LodingPro valueForKey:@"activity1"] objectAtIndex:index];
      draggableView.overlayView1.Label_Activity2.text =[[Array_LodingPro valueForKey:@"activity2"] objectAtIndex:index];
      draggableView.overlayView1.Label_Activity3.text =[[Array_LodingPro valueForKey:@"activity3"] objectAtIndex:index];
    if ([[[Array_LodingPro valueForKey:@"liketoplay"] objectAtIndex:index] isEqualToString:@"Outdoor"])
    {
        draggableView.overlayView1.image_likeplay.image=[UIImage imageNamed:@"outdoor.png"];
    }
    else if ([[[Array_LodingPro valueForKey:@"liketoplay"] objectAtIndex:index] isEqualToString:@"Everywhere"])
    {
          draggableView.overlayView1.image_likeplay.image=[UIImage imageNamed:@"everywhere.png"];
    }
    else if ([[[Array_LodingPro valueForKey:@"liketoplay"] objectAtIndex:index] isEqualToString:@"Indoor"])
    {
          draggableView.overlayView1.image_likeplay.image=[UIImage imageNamed:@"indoor.png"];
    }
    
    if ([[[Array_LodingPro valueForKey:@"icanmeet"] objectAtIndex:index] isEqualToString:@"Mornings"])
    {
          draggableView.overlayView1.image_letmeey.image=[UIImage imageNamed:@"mornings.png"];
    }
    else if ([[[Array_LodingPro valueForKey:@"icanmeet"] objectAtIndex:index] isEqualToString:@"Anytime"])
    {
          draggableView.overlayView1.image_letmeey.image=[UIImage imageNamed:@"anytime.png"];
    }
    else if ([[[Array_LodingPro valueForKey:@"icanmeet"] objectAtIndex:index] isEqualToString:@"After School"])
    {
          draggableView.overlayView1.image_letmeey.image=[UIImage imageNamed:@"afterschool.png"];
    }
    
     draggableView.overlayView1.label_Indoor.text =[[Array_LodingPro valueForKey:@"liketoplay"] objectAtIndex:index];
    
     draggableView.overlayView1.label_Outdoor.text =[[Array_LodingPro valueForKey:@"icanmeet"] objectAtIndex:index];
    
    }
    else
    {
        draggableView.Image_TopcompnyImage.hidden=NO;
        draggableView.Label_AddressComp.hidden=NO;;
        draggableView.Label_AddressCompbg.hidden=NO;
        draggableView.Label_TitleCompany.hidden=NO;;
        draggableView.Textview_DescCompany.hidden=NO;;
        draggableView.Image_compnyLogo1.hidden=NO;;
        draggableView.Image_compnyLogo2.hidden=NO;;
        draggableView.Image_compnyLogo3.hidden=NO;;
        
        
        draggableView.Image_Left.hidden=YES;;
        draggableView.Image_Right.hidden=YES;;
        draggableView.Back_imageprofile.hidden=YES;;
        draggableView.Front_imageprofile.hidden=YES;;
        draggableView.Label_Name.hidden=YES;;
        draggableView.Label_CityCountry.hidden=YES;;
        draggableView.Label_Emoji1.hidden=YES;
        draggableView.Label_Emoji2.hidden=YES;;
        draggableView.Label_Emoji3.hidden=YES;;
        draggableView.Label_Desc.hidden=YES;;
        draggableView.Label_Favtitle.hidden=YES;;
        
       
//        adid = ad1;
//        colourblue = 96;
//        colourgreen = 156;
//        colourred = 244;
//      
//        profiletype = AD;
       
        CGFloat red,green,blue;
        red=[[[Array_LodingPro valueForKey:@"colourred"] objectAtIndex:index]floatValue];
        green=[[[Array_LodingPro valueForKey:@"colourgreen"] objectAtIndex:index]floatValue];
        blue=[[[Array_LodingPro valueForKey:@"colourblue"] objectAtIndex:index]floatValue];
        NSURL *url_imagetitle,*url_imagelogo1,*url_imagelogo2,*url_imagelogo3;
        
       
         url_imagetitle=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagetitle"] objectAtIndex:index]];
         url_imagelogo1=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index]];
         url_imagelogo2=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index]];
         url_imagelogo3=[NSURL URLWithString:[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index]];
        
        
//        Image_compnyLogo1=[[UIImageView alloc]initWithFrame:CGRectMake(16,505,86,86)];
//      
//        
//        Image_compnyLogo2=[[UIImageView alloc]initWithFrame:CGRectMake(144,505,86,86)];
//        
//        
//        Image_compnyLogo3=[[UIImageView alloc]initWithFrame:CGRectMake(273,505,86,86)];
//        

        
        
        
        [draggableView.Image_TopcompnyImage sd_setImageWithURL:url_imagetitle placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        draggableView.Label_AddressComp.text=[[Array_LodingPro valueForKey:@"subtitle"] objectAtIndex:index];
        
        draggableView.Label_AddressCompbg.backgroundColor=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
        
        draggableView.Label_AddressComp.backgroundColor=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];

        draggableView.Label_TitleCompany.text=[[Array_LodingPro valueForKey:@"title"] objectAtIndex:index];

        draggableView.Textview_DescCompany.text=[[Array_LodingPro valueForKey:@"addescription"] objectAtIndex:index];

        
        
        if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index] isEqualToString:@""])
        {
            
          
            
            draggableView.Image_compnyLogo1.frame=CGRectMake(Imagetoplogo2xx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh);
            draggableView.Image_compnyLogo2.hidden=YES;
             draggableView.Image_compnyLogo3.hidden=YES;
            draggableView.Image_compnyLogo1.hidden=NO;
            [draggableView.Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];

        }
//        if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index] isEqualToString:@""])
//        {
//            draggableView.Image_compnyLogo1.frame=CGRectMake(144,505,86,86);
//            draggableView.Image_compnyLogo2.hidden=YES;
//            draggableView.Image_compnyLogo3.hidden=YES;
//            draggableView.Image_compnyLogo1.hidden=NO;
//            [draggableView.Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//            //            [draggableView.Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//            //            [draggableView.Image_compnyLogo3 sd_setImageWithURL:url_imagelogo3 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
//        }
       else if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index] isEqualToString:@""]&& ![[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index] isEqualToString:@""])
        {
            
            
            draggableView.Image_compnyLogo1.frame=CGRectMake(Imagetoplogo11xx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh);
            draggableView.Image_compnyLogo2.frame=CGRectMake(Imagetoplogo22xx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh);

            
            draggableView.Image_compnyLogo1.hidden=NO;
            draggableView.Image_compnyLogo2.hidden=NO;
            draggableView.Image_compnyLogo3.hidden=YES;
            
            [draggableView.Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
            [draggableView.Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
          
        }
        else if (![[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index] isEqualToString:@""]&& ![[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index] isEqualToString:@""] && ![[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index] isEqualToString:@""])
        {
             draggableView.Image_compnyLogo1.hidden=NO;
            draggableView.Image_compnyLogo2.hidden=NO;
            draggableView.Image_compnyLogo3.hidden=NO;
           
            
            [draggableView.Image_compnyLogo1 sd_setImageWithURL:url_imagelogo1 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
            [draggableView.Image_compnyLogo2 sd_setImageWithURL:url_imagelogo2 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
         [draggableView.Image_compnyLogo3 sd_setImageWithURL:url_imagelogo3 placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
        }
        else if ([[[Array_LodingPro valueForKey:@"imagelogo1"] objectAtIndex:index] isEqualToString:@""]&& [[[Array_LodingPro valueForKey:@"imagelogo2"] objectAtIndex:index] isEqualToString:@""] && [[[Array_LodingPro valueForKey:@"imagelogo3"] objectAtIndex:index] isEqualToString:@""])
        {
            draggableView.Image_compnyLogo1.hidden=YES;
            draggableView.Image_compnyLogo2.hidden=YES;
            draggableView.Image_compnyLogo3.hidden=YES;
        }

        draggableView.tap.enabled=NO;
        draggableView.tap1.enabled = NO;
      


        
        
    }
    
    
    
    
    
    draggableView.delegate = self;
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
     NSLog(@"Array_AllDataProDiscCount==%lu",(unsigned long)Array_LodingPro.count);
    if([Array_LodingPro count] > 0) {
        NSInteger numLoadedCardsCap =(([Array_LodingPro count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[Array_AllDataProDisc count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[Array_LodingPro count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [_allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self.view insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self.view addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
}

#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    
       
    
    //-------------------------------------------------------------------------------------------------------------------
    
    
    SwipeKeyString=@"LEFT";
    arrayIndex++;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a
    
    if (cardsLoadedIndex < [_allCards count])
    { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[_allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self.view insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    NSLog(@"Index Of left==%@",[Array_LodingPro objectAtIndex:arrayIndex-1]);
    fid2String=[[Array_LodingPro objectAtIndex:arrayIndex-1]valueForKey:@"fbid"];
    
    if ([FlagStatus isEqualToString:@"Flagyes"] ||[[defautls valueForKey:@"settingDone"] isEqualToString:@"yes"])
    {
        FlagStatus=@"Flagno";
    }
    else
    {
        [self SwipeclientServerComm];
    }
    
    NSLog(@"Index Of left==%ld",(long)arrayIndex);
    if (loadedCards.count==0)
    {
        arrayIndex=0;
#pragma mark - teddy spin
        
        Image_Animated.hidden=NO;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: M_PI/2];
        animation.duration = 0.3;
        animation.repeatCount = INFINITY;
        animation.autoreverses=YES;
        
        [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
        
        [self clientServerComm];
        
    }
   
   
  
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
  
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    SwipeKeyString=@"RIGHT";
     arrayIndex++;
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [_allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[_allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self.view insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    fid2String=[[Array_LodingPro objectAtIndex:arrayIndex-1]valueForKey:@"fbid"];
    
    Image_Animated.hidden=NO;
   animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    
    [self SwipeclientServerComm];
    
    NSLog(@"Index Of left==%@",[Array_LodingPro objectAtIndex:arrayIndex-1]);
    NSLog(@"Index Of Right==%@",loadedCards);
    NSLog(@"Index Of Right==%ld",(long)arrayIndex);
    if (loadedCards.count==0)
    {
        arrayIndex=0;
      [self clientServerComm];
    }
   
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.3 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.3 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    
    [dragView leftClickAction];
 //   [dragView leftAction];

}
-(IBAction)Button_pressed:(id)sender
{
    Image_Animated.hidden=NO;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    [self clientServerComm];
}

-(void)loadProfileMethod
{
    Image_Animated.hidden=NO;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
    animation.duration = 0.3;
    animation.repeatCount = INFINITY;
    animation.autoreverses=YES;
    
    [Image_Animated.layer addAnimation:animation forKey:@"SpinAnimation"];
    [self clientServerComm];
    
}




- (void) myFunction:(UIGestureRecognizer *)sender
{
//    UIView *view = sender.view; //cast pointer to the derived class if needed
//    NSLog(@"indextuches:==%ld", (long)view.tag);
//    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
   NSLog(@"indextuches1:==%ld", (long)imageView.tag);

     DiscoverViewInfo.hidden=NO;

}



-(IBAction)Button_Flag:(id)sender
{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Flag as inappropriate",nil];
    popup.tag = 3;
    [popup showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex== 0)
    {
        FlagStatus=@"Flagyes";
        [self swipeLeft];
        [self Flagcommunication];
        
    }
   
}
- (void)ViewTap11Tapped:(UITapGestureRecognizer *)recognizer
{
    
    DiscoverViewInfo.hidden=YES;
    
    
}

- (IBAction)switchWhereButton:(id)sender
{
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    WhereViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"WhereViewController"];
//    
//    [self.navigationController pushViewController:set animated:YES];
    
    WhereViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WhereViewController"];
    [self.navigationController presentModalViewController:tvc animated:YES];
    
    [defautls setObject:@"YES" forKey:@"switchPressed"];
    [defautls setObject:@"YES" forKey:@"savePressed"];

}
@end
