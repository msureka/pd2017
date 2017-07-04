//
//  NewPlayDateCreateViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 6/15/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "NewPlayDateCreateViewController.h"
#import "InviteSprintTagUserViewController.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "UIView+RNActivityView.h"

@interface NewPlayDateCreateViewController ()<UITextViewDelegate>
{
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
}
@end

@implementation NewPlayDateCreateViewController
@synthesize HeadTopView,label_day,label_date,label_time,label_placeholder,textview_disc,textfield_meetup,Picker_date,Button_invite,textfield_location,label_hederTop;
- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    textfield_meetup.tag=101;
    textfield_meetup.delegate=self;

    textfield_location.delegate=self;
    
   
    
    
   
    
    Picker_date.date = [NSDate date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
   // NSDate *currDate = [NSDate date];
    
    
    
    NSDate*  currDate= [NSDate date];
    
    
    
//    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
//    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
//    
//    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:currDate1];
//    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:currDate1];
//    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
//    
//    NSDate *currDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:currDate1] ;
    
    
    
    
//    NSTimeZone* currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    NSTimeZone* nowTimeZone = [NSTimeZone systemTimeZone];
//    
//    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:currDate1];
//    NSInteger nowGMTOffset = [nowTimeZone secondsFromGMTForDate:currDate1];
//    
//    NSTimeInterval interval = nowGMTOffset - currentGMTOffset;
//    NSDate* currDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:currDate1];
    
   
    
    [Picker_date addTarget:self
                   action:@selector(LabelChange1:)
         forControlEvents:UIControlEventValueChanged];
    
    
      [Picker_date setMinimumDate:currDate];
    NSDateFormatter *showdf,*showdftime,*showdfday;
    showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"d-LLLL-yyyy"];
    
    showdftime= [[NSDateFormatter alloc]init];
    [showdftime setDateFormat:@"h:mm a"];
    
    showdfday= [[NSDateFormatter alloc]init];
    [showdfday setDateFormat:@"EEEE"];
    
  //  NSString *dates=[defaults valueForKey:@"eventdateformat"];
    
    if([  [defaults valueForKey:@"checkview"] isEqualToString:@"edit"])
    {
        textfield_meetup.text=[defaults valueForKey:@"textfield_title"];
        textfield_location.text=[defaults valueForKey:@"textfield_location"];
        textview_disc.text=[defaults valueForKey:@"textview_disc"];;
        
       // eventdateformat=[defaults valueForKey:@"textview_disc"];;
        label_placeholder.hidden=YES;
         NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       NSDate *currDate1=[df1 dateFromString:[defaults valueForKey:@"eventdateformat"]];
        [Picker_date setDate:currDate1];
        Button_invite.enabled=YES;
        [Button_invite setTitle:@"Save" forState:UIControlStateNormal];
        [Button_invite setBackgroundColor:[UIColor colorWithRed:255/255.0  green:242/255.0 blue:82/255.0 alpha:1]];
           label_hederTop.text=@"Edit Play:Date";
    }
    else
    {
         [textfield_meetup becomeFirstResponder];
            textview_disc.text=@"";
        textfield_meetup.text=@"";;
        textfield_location.text=@"";
        [df setDateFormat:@"yyyy-MM-dd h:mm:ss a"];
        label_placeholder.hidden=NO;
        Button_invite.enabled=NO;
        [Button_invite setTitle:@"Invite friends" forState:UIControlStateNormal];
       [Button_invite setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        label_hederTop.text=@"New Play:Date";
        
      
    }
    

    
    label_date.text = [NSString stringWithFormat:@"%@",
                       [showdf stringFromDate:Picker_date.date]];
    
    label_time.text =[NSString stringWithFormat:@"%@",
                      [showdftime stringFromDate:Picker_date.date]];
    
    label_day.text =[NSString stringWithFormat:@"%@",
                     [showdfday stringFromDate:Picker_date.date]];

    
  //  Picker_date.backgroundColor=[UIColor lightGrayColor];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
     textfield_location.delegate=self;
}
- (IBAction)Invite_Button:(id)sender
{
    if([  [defaults valueForKey:@"checkview"] isEqualToString:@"edit"])
    {
        [self.view endEditing:YES];
        [self Communication_Editevent];
       
    }
    else
    {
        [self.view endEditing:YES];
        InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
        set.label_time1=label_time.text;
        set.label_day1=label_day.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        set.label_date1=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:Picker_date.date]];//[NSString stringWithFormat:@"%@",Picker_date.date];;
        set.textfield_meetup1=textfield_meetup.text;
        set.textfield_location1=textfield_location.text;
        set.textview_disc1=textview_disc.text;
         set.str_checkmorefriends=@"allmorefriend";
        set.Str_eventcreate=@"yes";
        
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
    
}
- (IBAction)Cancel_Button:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
 
    
//    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    
    
    
}
- (void)LabelChange1:(UIDatePicker *)datePicker
{
    
#pragma mark - Date DD MM YYYY
    
    NSDateFormatter *showdf,*showdftime,*showdfday;
    showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"d-LLLL-yyyy"];
    
    showdftime= [[NSDateFormatter alloc]init];
     [showdftime setDateFormat:@"h:mm a"];
   
    showdfday= [[NSDateFormatter alloc]init];
    [showdfday setDateFormat:@"EEEE"];
    
    label_date.text = [NSString stringWithFormat:@"%@",
                          [showdf stringFromDate:datePicker.date]];
    
    label_time.text =[NSString stringWithFormat:@"%@",
                      [showdftime stringFromDate:datePicker.date]];
    
    label_day.text =[NSString stringWithFormat:@"%@",
                     [showdfday stringFromDate:datePicker.date]];
    
    
   
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    if (textView.text.length==0)
//    {
//     
//        label_placeholder.hidden=YES;
//        
//    }

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0)
    {
    
        label_placeholder.hidden=NO;
        
    }
    else
    {
     label_placeholder.hidden=YES;
    }

 
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0)
    {
      label_placeholder.hidden=NO;
    }
    else
    {
      label_placeholder.hidden=YES;
       
    }
  
}
- (IBAction)TextField_Actions:(id)sender
{
    if (textfield_location.text.length==0 || textfield_meetup.text.length==0)
    {
        Button_invite.enabled=NO;
        [Button_invite setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    else
    {
        Button_invite.enabled=YES;
        [Button_invite setBackgroundColor:[UIColor colorWithRed:255/255.0  green:242/255.0 blue:82/255.0 alpha:1]];
    }
    
    
    
}
-(void)notificationData:(NSNotification*)notification
{
    
    
//    Array = [[NSMutableArray alloc]init];
//    Array = [[notification userInfo] objectForKey:@"array_Data"];
    
    NSLog(@"gsafdgh%@",notification);
 
}
-(void)Communication_Editevent
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];
    
    NSString *fbid1= @"fbid";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    NSString *meetupstitle= @"title";
    
    NSString *meetupstitleval=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textfield_meetup.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    NSString *location= @"location";
    
    NSString *locationVal=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textfield_location.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    NSString *eventdate= @"eventdate";
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
   
    NSString *eventdateval=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:Picker_date.date]];
    
    NSString *description= @"description";
    NSString * descriptionval=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textview_disc.text,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;

    NSString *eventid= @"eventid";
    
    NSString *eventival= [defaults valueForKey:@"neweventid"];;

    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,meetupstitle,meetupstitleval,location,locationVal,eventdate,eventdateval,description,descriptionval,eventid,eventival];
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"editevent"];;
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
                                                 
                                               
                                                 
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 ;
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                    
                                                 
                                                 NSLog(@"array_createEvent ResultString %@",ResultString);
                                                 if ([ResultString isEqualToString:@"noeventid"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"noeventid." preferredStyle:UIAlertControllerStyleAlert];
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"inserterror"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"done"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                 }
                                                 
                                             }
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                 [self.view hideActivityViewWithAfterDelay:1];
                                                 
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:1];
                                             
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   

    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 50;
        
}

@end
