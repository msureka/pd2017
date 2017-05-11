//
//  ProfileUserViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileUserViewController.h"
#import "UIImageView+WebCache.h"
#import "YSHYClipViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "Base64.h"


@interface ProfileUserViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ClipViewControllerDelegate,UITextFieldDelegate>
{
    NSUserDefaults *defautls;
  NSDictionary *urlplist;
    UITapGestureRecognizer *profileImgTapped;
    
    UIImagePickerController * imagePicker;
    UIButton * btn;
    ClipType clipType;
    UIButton * circleBtn;
    UIButton * squareBtn;
    UITextField * textField ;
    CGFloat radius;
    
    
    NSURLConnection *Connection_Profile,*Connection_Emoji;
    NSMutableData *webData_Profile,*webData_Emoji;
    NSMutableArray *Array_Profile,*Array_Emoji;

    NSString * urlstr,*encodedImage;
    
    NSURL * url;
    
}
@end

@implementation ProfileUserViewController
@synthesize profileImg,LabelName,LabelEmoji,LabelLocation,HeadTopView,profileImg1,TextField_Emoji11bb,TextField_Emoji22bb,TextField_Emoji33bb;
- (void)viewDidLoad {
    [super viewDidLoad];
    defautls=[[NSUserDefaults alloc]init];

 
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
    LabelEmoji.clipsToBounds=YES;
    LabelEmoji.layer.cornerRadius=LabelEmoji.frame.size.height/2;
    
    _TextField_Emoji11.delegate=self;
    _TextField_Emoji22.delegate=self;
    _TextField_Emoji33.delegate=self;
    _startScreenScrollView.delegate=self;
    
    self.TextField_Emoji11.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji11.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji11.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
    
    self.TextField_Emoji22.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji22.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji22.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
    
    self.TextField_Emoji33.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji33.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji33.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
   
//    _TextField_Emoji11.tag=1;
//    _TextField_Emoji22.tag=2;
//    _TextField_Emoji33.tag=3;
    
    profileImg1.userInteractionEnabled=YES;
    profileImgTapped =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(profileImgTapped1:)];
    [profileImg1 addGestureRecognizer:profileImgTapped];
    
    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
         profileImg1.image=[UIImage imageNamed:@"boypictureframe 1.png"];
    }
    else
    {
        profileImg1.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
    }
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    urlstr=[defautls valueForKey:@"profilepic"];//[NSString stringWithFormat:@"%@%@%@",[urlplist valueForKey:@"urlname"],[defautls valueForKey:@"fid"],@".jpg"];
    
   url=[NSURL URLWithString:urlstr];
    
  // [profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
   [profileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                          options:SDWebImageRefreshCached];
    
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        NSData * data = [[NSData alloc] initWithContentsOfURL: url];
//        
//        if ( data == nil )
//            
//            return;
//    dispatch_async(dispatch_get_main_queue(), ^{
//       
//        profileImg.image = [UIImage imageWithData: data];
        NSData *imageData = UIImageJPEGRepresentation( profileImg.image, 1.0);
        [defautls setObject:imageData forKey:@"Proimage"];
        [defautls synchronize];


    
LabelName.text=[NSString stringWithFormat:@"%@%@%@",[defautls valueForKey:@"fname"],@", ",[defautls valueForKey:@"age"]];
  //  LabelEmoji.text=@""
    LabelLocation.text=[NSString stringWithFormat:@"%@%@%@",[defautls valueForKey:@"Cityname"],@", ",[defautls valueForKey:@"Countryname"]];
    
    
    
    CALayer *borderBottom1 = [CALayer layer];
    borderBottom1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
   
    
    
    CALayer *borderBottom11 = [CALayer layer];
    borderBottom11.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom11.frame = CGRectMake(4, TextField_Emoji11bb.frame.size.height - 4, TextField_Emoji11bb.frame.size.width-8, 4);
    [TextField_Emoji11bb.layer addSublayer:borderBottom11];
    
    CALayer *borderBottom2 = [CALayer layer];
    borderBottom2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom2.frame = CGRectMake(4, TextField_Emoji22bb.frame.size.height - 4, TextField_Emoji22bb.frame.size.width-8, 4);
    [TextField_Emoji22bb.layer addSublayer:borderBottom2];
    
    CALayer *borderBottom3= [CALayer layer];
    borderBottom3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom3.frame = CGRectMake(4, TextField_Emoji33bb.frame.size.height - 4, TextField_Emoji33bb.frame.size.width-8,4);
    [TextField_Emoji33bb.layer addSublayer:borderBottom3];
    
    _TextField_Emoji11.text=[defautls valueForKey:@"emoji1"];
    _TextField_Emoji22.text=[defautls valueForKey:@"emoji2"];
    _TextField_Emoji33.text=[defautls valueForKey:@"emoji3"];
    
#define kPreferencesFilePath @"/private/var/mobile/Library/Preferences/com.apple.Preferences.plist"
#define kEmojiKey @"KeyboardEmojiEverywhere"
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:kPreferencesFilePath];
    if (!dict) return;
    // Toggle the setting from on to off or vice versa
    BOOL isSet = [[dict objectForKey:kEmojiKey] boolValue];
    if (!isSet) {
        [dict setObject:[NSNumber numberWithBool:YES] forKey:kEmojiKey];
        [dict writeToFile:kPreferencesFilePath atomically:NO];
    }
    
      [self ConfigUI];
    
 
   
    
}


- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
   
    
    
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:true];
   
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}




-(void)viewWillAppear:(BOOL)animated
{
    

 [self registerForKeyboardNotifications];
    
    if ([[defautls valueForKey:@"gender"] isEqualToString:@"Boy"])
    {
        
        profileImg1.image=[UIImage imageNamed:@"boypictureframe 1.png"];
          self.tabBarController.tabBar.barTintColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
    }
    else
    {
        profileImg1.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
         self.tabBarController.tabBar.barTintColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
    }
//    NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
//    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSLog(@"%@",[dateFormatter1 stringFromDate:[NSDate date]]);
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date1 = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
//    
//    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init] ;
//    [dateFormatte setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date2 = [dateFormatte dateFromString:[defautls valueForKey:@"DOB"]];
//    
//    NSDateComponents *components,*components1;
//    NSCalendarUnit units,units1;
//    NSCalendar *calendar,*calendar1;
//    
//    calendar = [[NSCalendar alloc]
//                initWithCalendarIdentifier:NSGregorianCalendar];
//    units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    components = [calendar components:units fromDate:date1];
//    
//    
//    calendar1 = [[NSCalendar alloc]
//                 initWithCalendarIdentifier:NSGregorianCalendar];
//    units1 = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    components1 = [calendar1 components:units1 fromDate:date2];
//    
//    
//    
//    
//    NSLog(@"YEARRR--%ld",(long)[components year]);
//    
//    
//    NSLog(@"YEARRR--%ld",(long)[components1 year]);
    
    
    //    unsigned int unitFlags = NSDayCalendarUnit;
    //
    //    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    //    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date1  toDate:date2  options:0];
    //
    //    int days = [comps year];
    //    NSLog(@"oneeeee=%d",days);
    //
    //
    
    //[defaults valueForKey:@"DOB"];
    
    LabelName.text=[NSString stringWithFormat:@"%@%@%@",[defautls valueForKey:@"fname"],@", ",[defautls valueForKey:@"age"]];
    //  LabelEmoji.text=@""
    LabelLocation.text=[NSString stringWithFormat:@"%@%@%@",[defautls valueForKey:@"Cityname"],@", ",[defautls valueForKey:@"Countryname"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)profileImgTapped1:(UITapGestureRecognizer *)recognizer
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 3;
    [popup showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex== 0)
    {
        
        [defautls setObject:@"yes" forKey:@"CheckedView"];
        [defautls synchronize];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        //  [self.navigationController pushViewController:picker animated:YES];
        // [self.navigationController presentModalViewController:picker animated:YES];
    }
    if (buttonIndex== 1)
    {
        
        [defautls setObject:@"no" forKey:@"CheckedView"];
        [defautls synchronize];
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }
}
-(void)ConfigUI
{
    
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/ 2 - 110, 300, 210, 25)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.borderStyle = UITextBorderStyleRoundedRect;
   
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    
    YSHYClipViewController * clipView = [[YSHYClipViewController alloc]initWithImage:image];
    clipView.delegate = self;
    clipView.clipType = clipType; //支持圆形:CIRCULARCLIP 方形裁剪:SQUARECLIP   默认:圆形裁剪
//    if(![textField.text isEqualToString:@""])
//    {
//        radius =textField.text.intValue;
    clipView.radius =120;// radius;   //设置 裁剪框的半径  默认120
//    }
    //   clipView.scaleRation = 5;// 图片缩放的最大倍数 默认为10
    [picker pushViewController:clipView animated:YES];
    
}

#pragma mark - ClipViewControllerDelegate
-(void)ClipViewController:(YSHYClipViewController *)clipViewController FinishClipImage:(UIImage *)editImage
{
  
    profileImg.image=editImage;
    NSData *imageData = UIImageJPEGRepresentation(editImage, 1.0);
    [defautls setObject:imageData forKey:@"Proimage"];
    [defautls synchronize];
    [clipViewController dismissViewControllerAnimated:YES completion:^{
        //[ProfileImgButton setImage:editImage forState:UIControlStateNormal];
        
        
        //        NSData *imageData = UIImageJPEGRepresentation(editImage, 1);
        //
        //        // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
        //
        //
        //        // Store path in NSUserDefaults
        //
        //        [defaults setObject:imageData forKey:@"Proimage"];
        //        // Sync user defaults
        //        [defaults synchronize];
        //
        
         profileImg.image=editImage;
        
        NSLog(@"ImageCheck==%@",[defautls valueForKey:@"Proimage"]);
//        [ProfileImgButton setTitle:@"" forState:UIControlStateNormal];
//        [ProfileImgButton setBackgroundImage:editImage forState:UIControlStateNormal];
        
    }];;
    
    
   // UIImage *image = [UIImage imageWithData:[defautls valueForKey:@"Proimage"]];
    
    
    NSData* imageData1 = UIImageJPEGRepresentation(editImage, 0.0);
    NSString * ImageNSdata= [Base64 encode:imageData1];
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    [self ProfileChangeServerComm];
}
-(void)ClipViewController1:(YSHYClipViewController *)clipViewController
{
    [clipViewController dismissViewControllerAnimated:YES completion:nil];;
    //    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
    //    //picker.allowsEditing = NO;
    //    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [self presentViewController:picker animated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

      [self.view endEditing:YES];
}


-(IBAction)Button_Setting:(id)sender
{
     [self performSegueWithIdentifier:@"next" sender:self];
}
#pragma mark- Button help

- (IBAction)Button_Help:(id)sender
{
    TutorialViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    [self.navigationController presentModalViewController:tvc animated:YES];
  //  [self.navigationController pushViewController:tvc animated:YES];
    
    [defautls setObject:@"YES" forKey:@"tutseen"];
    
    
}
-(void)ProfileChangeServerComm
{
    
    
    
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            message.tag=100;
//            [message show];
            
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
            NSString *  urlStrLivecount=[urlplist valueForKey:@"savepicture"];
            url =[NSURL URLWithString:urlStrLivecount];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            [request setHTTPMethod:@"POST"];//Web API Method
            
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            
            
            
            NSString *fbid1= @"fbid";
            NSString *fbid1Val = [defautls valueForKey:@"fid"];
            
            NSString *profileimage= @"profileimage";

            
            NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,profileimage,encodedImage];
            
            
            //converting  string into data bytes and finding the lenght of the string.
            NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
            [request setHTTPBody: requestData];
            
            Connection_Profile = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            {
                if( Connection_Profile)
                {
                    webData_Profile =[[NSMutableData alloc]init];
                    
                    
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
        
        if(connection==Connection_Profile)
        {
            [webData_Profile setLength:0];
            
            
        }
        
        if(connection==Connection_Emoji)
        {
            [webData_Emoji setLength:0];
            
            
        }
        
    }
    - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
    {
        if(connection==Connection_Profile)
        {
            [webData_Profile appendData:data];
        }
        if(connection==Connection_Emoji)
        {
            [webData_Emoji appendData:data];
        }
        
    }
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //  [indicatorView stopAnimating];
    
    if (connection==Connection_Profile)
    {
        
        Array_Profile=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Profile=[objSBJsonParser objectWithData:webData_Profile];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Profile encoding:NSUTF8StringEncoding];
        //  Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_LodingPro options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"cwebData_Profilec %@",Array_Profile);
        
         [defautls setObject:[[Array_Profile objectAtIndex:0]valueForKey:@"profilepic"] forKey:@"profilepic"];
        
        NSLog(@"webData_Profile %@",[[Array_Profile objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"webData_Profile %@",ResultString);
       
        if ([ResultString isEqualToString:@"imagenull"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You seem to have not selected a profile image. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected a profile image. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
               
        if ([ResultString isEqualToString:@"imageerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not upload the profile image you have selected. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the profile image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }

        
        if ([ResultString isEqualToString:@"nullerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
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

        
        
        
        if ([ResultString isEqualToString:@"imageupdated"])
        {
    

            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: url];
                
                if ( data == nil )
                    
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    profileImg.image = [UIImage imageWithData: data];
                    
                    
                    
                });
                
            });
 
        }
    }
    
    
    
    if (connection==Connection_Emoji)
    {
        
        Array_Emoji=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Emoji=[objSBJsonParser objectWithData:webData_Emoji];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Emoji encoding:NSUTF8StringEncoding];
        
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_EmojiArray_Emoji %@",Array_Emoji);
          NSLog(@"Array_EmojiResultString %@",ResultString);
        
        if ([ResultString isEqualToString:@"done"])
        {
//            [defautls setObject:self.TextField_Emoji11.text forKey:@"emoji1"];
//            
//            [defautls setObject:self.TextField_Emoji22.text forKey:@"emoji2"];
//            
//            [defautls setObject:self.TextField_Emoji33.text forKey:@"emoji3"];
//            [defautls synchronize];

        }
        
        
        if ([ResultString isEqualToString:@"nullerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
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
        
        if ([ResultString isEqualToString:@"updateerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in updating your emojis. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in updating your emojis. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        if ([ResultString isEqualToString:@"selecterror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        }


        
    }
    
}

-(IBAction)Label_Emoji11:(id)sender
{  
}
-(IBAction)Label_Emoji22:(id)sender
{
//  [Label_EmojiTxt becomeFirstResponder];
}
-(IBAction)Label_Emoji33:(id)sender
{
 // [textField becomeFirstResponder];
}





- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  ;
    UITextInputMode *textInput = [UITextInputMode currentInputMode];
    NSString *primaryLanguage = textInput.primaryLanguage;
    NSLog(@"Current text input is: %@", primaryLanguage);
    
    //        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"] )
    //        {
    //            return YES;
    //        }
    //        else
    //        {
    //            return NO;
    //        }
  
   
    
if (textField == self.TextField_Emoji11)
    {
//        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"] )
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
//        
        NSString *str = self.TextField_Emoji11.text;
        
        NSArray *arr = [str componentsSeparatedByString:@""];
        NSString *temp;
        for (int i = 0; i < arr.count; i++) {
            
            temp = [arr objectAtIndex:i];
            
            if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
            {
                
                NSLog(@"coun emojjj==== %d",i);
                NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            }
            
            
            
        }
   
        if (temp.length >= 2 && ![string isEqualToString:@""])
        {
            return NO;
        }
        else
        {
            self.TextField_Emoji11.text=@"";
        return YES;
        }
        
    }
    else if (textField == self.TextField_Emoji22)
    {
//        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"] )
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
        NSString *str = self.TextField_Emoji22.text;
        
        NSArray *arr = [str componentsSeparatedByString:@""];
        NSString *temp;
        for (int i = 0; i < arr.count; i++) {
            
            temp = [arr objectAtIndex:i];
            
            if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
            {
                
                NSLog(@"coun emojjj==== %d",i);
                NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            }
            
            
            
        }
        
        if (temp.length >= 2 && ![string isEqualToString:@""])
        {
            return NO;
        }
        else
        {
            self.TextField_Emoji22.text=@"";
            return YES;
        }

       
    }
    else if (textField == self.TextField_Emoji33)
    {

        NSString *str = self.TextField_Emoji33.text;
        
        NSArray *arr = [str componentsSeparatedByString:@""];
        NSString *temp;
        for (int i = 0; i < arr.count; i++) {
            
            temp = [arr objectAtIndex:i];
            
            if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
            {
                
                NSLog(@"coun emojjj==== %d",i);
                NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            }
            
            
            
        }
        
        if (temp.length >= 2 && ![string isEqualToString:@""])
        {
            return NO;
        }
        else
        {
              self.TextField_Emoji33.text=@"";
            return YES;
        }
        
    }

    return YES;
}




- (IBAction)TextField_Emoji11:(id)sender
{
    
    self.TextField_Emoji11.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji11.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji11.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
   
    NSLog(@"Length11==%@",self.TextField_Emoji11.text);
    
    NSString *str = self.TextField_Emoji11.text;
    
    NSArray *arr = [str componentsSeparatedByString:@""];
    NSString *temp;
    for (int i = 0; i < arr.count; i++) {
        
       temp = [arr objectAtIndex:i];
        
        if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
        {
            
            NSLog(@"coun emojjj==== %d",i);
            NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            
            
        }
       
        
        
    }
    
    
    
    if (temp.length>=1)
    {
        
        [_TextField_Emoji22 becomeFirstResponder];
        [self TextField_Emoji22:nil];
    }
    else if(temp.length>=2)
    {
         [_TextField_Emoji22 becomeFirstResponder];
       [self TextField_Emoji22:nil];
    }
    
}
- (IBAction)TextField_Emoji22:(id)sender
{
    self.TextField_Emoji22.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji22.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji22.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
    NSLog(@"Length22==%lu",self.TextField_Emoji22.text.length);
    NSString *str = self.TextField_Emoji22.text;
    
    NSArray *arr = [str componentsSeparatedByString:@""];
    NSString *temp;
    for (int i = 0; i < arr.count; i++) {
        
        temp = [arr objectAtIndex:i];
        
        if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
        {
            
            NSLog(@"coun emojjj==== %d",i);
            NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            
            
        }
    
    }

  
    if (temp.length>=1)
    {
        [_TextField_Emoji33 becomeFirstResponder];
       [self TextFileld_Emoji33:nil];
    }
    else if(temp.length>=2)
    {
         [_TextField_Emoji33 becomeFirstResponder];
      [self TextFileld_Emoji33:nil];
    }
    
}



- (IBAction)TextFileld_Emoji33:(id)sender
{
    self.TextField_Emoji33.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    self.TextField_Emoji33.textAlignment=NSTextAlignmentCenter;
    self.TextField_Emoji33.font=[UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
    
    NSString *str = self.TextField_Emoji33.text;
    
    NSArray *arr = [str componentsSeparatedByString:@""];
    NSString *temp;
    for (int i = 0; i < arr.count; i++) {
        
        temp = [arr objectAtIndex:i];
        
        if ( ![temp canBeConvertedToEncoding:NSASCIIStringEncoding])
        {
            
            NSLog(@"coun emojjj==== %d",i);
            NSLog(@"coun emojjj====%lu",(unsigned long)temp.length);
            
            
        }
        
        
        
    }
    
    if (temp.length>=1)
    {
        
          [_TextField_Emoji33 resignFirstResponder];
       
    }
    else if(temp.length>=2)
    {
          [_TextField_Emoji33 resignFirstResponder];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [self.startScreenScrollView setContentOffset:CGPointMake(0,150) animated:YES];
    
    [textField becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    //[self.startScreenScrollView setContentOffset:CGPointMake(0,0) animated:YES];
   
    [textField resignFirstResponder];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)clinentserverEmoji_Comm
{
    
    [defautls setObject:self.TextField_Emoji11.text forKey:@"emoji1"];
    
    [defautls setObject:self.TextField_Emoji22.text forKey:@"emoji2"];
    
    [defautls setObject:self.TextField_Emoji33.text forKey:@"emoji3"];
    [defautls synchronize];
    
    
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
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else
    {
        [defautls setObject:self.TextField_Emoji11.text forKey:@"emoji1"];
        
        [defautls setObject:self.TextField_Emoji22.text forKey:@"emoji2"];
        
        [defautls setObject:self.TextField_Emoji33.text forKey:@"emoji3"];
        [defautls synchronize];
        
        NSURL *url;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
        NSString *  urlStrLivecount=[urlplist valueForKey:@"saveemoji"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defautls valueForKey:@"fid"];
        
        NSString *Emoji1= @"emoji1";
        NSString *Emoji1Val =self.TextField_Emoji11.text;
        
        NSString *Emoji2= @"emoji2";
        NSString *Emoji2Val=self.TextField_Emoji22.text;
        
        NSString *Emoji3= @"emoji3";
        NSString *Emoji3Val =self.TextField_Emoji33.text;
        
        NSString *Emoji4= @"emoji34";
        NSString *Emoji4Val =@"abc";

        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,Emoji1,Emoji1Val,Emoji2,Emoji2Val,Emoji3,Emoji3Val,Emoji4,Emoji4Val];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_Emoji= [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Emoji)
            {
                webData_Emoji =[[NSMutableData alloc]init];
                
                
            }
            else
            {
                NSLog(@"theConnection is NULL");
            }
        }
        
    }
    
    
}



- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
    
 
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
      [self.startScreenScrollView setContentOffset:CGPointMake(0,0) animated:YES];
     [self clinentserverEmoji_Comm];
}








@end
