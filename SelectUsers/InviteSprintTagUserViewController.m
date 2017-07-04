//
//  InviteSprintTagUserViewController.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 9/1/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "InviteSprintTagUserViewController.h"
#import "CLToken.h"
#import "SBJsonParser.h"
#import "InviteSprintUserTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LCNContactPickerView.h"
#import "UIViewController+KeyboardAnimation.h"
#import "FriendCahtingViewControlleroneViewController.h"
#import "UIView+RNActivityView.h"
@interface InviteSprintTagUserViewController ()<LCNContactPickerViewDelegate>

{
    NSDictionary *urlplist;
    NSURLConnection *Connection_Recomm_GetUser,*Connection_suggested;
    NSMutableData *webData_Recomm_GetUser,*webData_suggested;
    NSMutableArray *Array_Reomm_GetUser,*Array_suggested,*array_createEvent;
    NSMutableArray *Array_SearchData;
    NSArray *Search_Array_Recoom;
    NSString *ResultString_getUser,*ResultString_getUser_send, *strInvite_users,*ResultString_Recomm_getUser,*ResultString_suggested;
    NSMutableDictionary * didselectDic;
    UIView *HeadingView,*sectionView;
    
    UIButton *headerLabel1,*headerLabel2;
    UITableView * Table_ContactView;
    NSUserDefaults * defaults;
    NSString * String_suggested,*string_Keyboardload;
}
@property (nonatomic, strong) LCNContactPickerView *contactPickerView;
@property (strong, nonatomic) NSArray *names;

@property (strong, nonatomic) NSMutableArray *selectedNames;
@property (strong, nonatomic) NSMutableArray *selectedUserid;

@end

@implementation InviteSprintTagUserViewController
@synthesize selectedUserid,selectedNames,Array_InviteUserTags,Send_Button,label_day1,label_date1,label_time1,Str_eventcreate,textfield_location1,textview_disc1,textfield_meetup1,str_checkmorefriends,HeadTopView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
//    CALayer *borderBottom = [CALayer layer];
//    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
//    
//    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
//    [HeadTopView.layer addSublayer:borderBottom];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];


       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived1:) name:@"PassDataArrayBack" object:nil];

  defaults=[[NSUserDefaults alloc]init];
         Array_SearchData=[[NSMutableArray alloc]init];

    Search_Array_Recoom=[[NSMutableArray alloc]init];
   Search_Array_Recoom=[[NSArray alloc]init];
     [[self navigationController] setNavigationBarHidden:YES animated:NO];
    selectedNames = [NSMutableArray arrayWithCapacity:Search_Array_Recoom.count];
    selectedUserid= [NSMutableArray arrayWithCapacity:Search_Array_Recoom.count];
    Table_ContactView.hidden = YES;
    if ([Str_eventcreate isEqualToString:@"yes"])
    {
        Send_Button.enabled=YES;
        [Send_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Send_Button.alpha=1;
    }
    else
    {
        Send_Button.enabled=NO;
        [Send_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        Send_Button.alpha=0.8;
       
    }
   
string_Keyboardload=@"no";
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
  urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
   [self Communication_Invite_user];
    
    [self Communication_SuggestedFriends];
    NSLog(@"Mewwwwww=%@",_Names_UserId);
   
  
    self.contactPickerView = [[LCNContactPickerView alloc] initWithFrame:CGRectMake(10,75, self.view.frame.size.width - 20, 0)];
    
    Table_ContactView=[[UITableView alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, self.view.frame.size.height-100)];
   
    Table_ContactView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:Table_ContactView];
 
    self.contactPickerView.backgroundColor=[UIColor clearColor];

    Table_ContactView.delegate = self;
    Table_ContactView.dataSource = self;
    self.contactPickerView.delegate = self;
Table_ContactView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.contactPickerView];
    self.contactPickerView.hidden=YES;
   
 
    for (int i=0; i<_Names.count; i++)
    {
        [self.contactPickerView addContact:[_Names objectAtIndex:i] withDisplayName:[_Names objectAtIndex:i]];
        NSLog(@"Mewwwwww=%@",[_Names objectAtIndex:i]);
        
        NSLog(@"Mewwwwww=%@",[_Names_UserId objectAtIndex:i]);
        [selectedUserid addObject:[_Names_UserId objectAtIndex:i]];
        [selectedNames addObject:[_Names objectAtIndex:i]];
        
    }
     Table_ContactView.hidden=YES;
    _label_Result.hidden=YES;
   
     String_suggested=@"no";
    
    
    
    
    
    }
-(void)viewDidLayoutSubviews
{
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
}
- (void)keyboardDidShow: (NSNotification *) notif
{
    if ([string_Keyboardload isEqualToString:@"no"])
                    {
                        string_Keyboardload=@"yes";
                    }
                    else
                    {
            [Table_ContactView setFrame:CGRectMake(0, Table_ContactView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-350)];
                    }
}

- (void)keyboardDidHide: (NSNotification *) notif
{
    [Table_ContactView setFrame:CGRectMake(0, Table_ContactView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-100)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
//- (void)subscribeToKeyboard
//{
//    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
//        if (isShowing)
//        {
//            if ([string_Keyboardload isEqualToString:@"no"])
//            {
//                string_Keyboardload=@"yes";
//            }
//            else
//            {
//    [Table_ContactView setFrame:CGRectMake(0, Table_ContactView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-350)];
//            }
//       
//            
//        } else
//        {
//        [Table_ContactView setFrame:CGRectMake(0, Table_ContactView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-100)];
//     }
//        [self.view layoutIfNeeded];
//    } completion:nil];
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self an_unsubscribeKeyboard];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0)
//    {
        if ( [String_suggested isEqualToString:@"yes"])
        {
            return Array_SearchData.count;
          
        }
        else
        {
         return Array_suggested.count;
        }
        
   // }
//    if (section==1)
//    {
//         return Array_SearchData.count;
//    }
 return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
//    switch (indexPath.section)
//    {
//        
//        
//    case 0:
//        {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *Proimage_View=nil;
    UILabel *Labelname=nil;
    
   
        if (cell == nil) {
    
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            Proimage_View=[[UIImageView alloc]initWithFrame:CGRectZero];
            Labelname=[[UILabel alloc]initWithFrame:CGRectZero];
  [Proimage_View setTag:2];
            [Labelname setTag:1];
            
            [[cell contentView] addSubview:Proimage_View];
            [[cell contentView] addSubview:Labelname];
           

          
        }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    [cell addSubview:Proimage_View];
    [cell addSubview:Labelname];
    Proimage_View.frame=CGRectMake(10, 8, 32, 32);
            Proimage_View.clipsToBounds=YES;
            Proimage_View.layer.cornerRadius=Proimage_View.frame.size.height/2;
            Labelname.frame=CGRectMake(50, 0, self.view.frame.size.width-67, 48);
    
//        Proimage_View.backgroundColor=[UIColor greenColor];
//        Labelname.text =@"vvdsdsdsfddfsdsddggdfgdfgdfggdgdfgfgdfgdfgdfgdfgdfgdfgdgdfgsfdsfdsf";
    
    NSMutableDictionary *dict_Sub;
    if ( [String_suggested isEqualToString:@"yes"])
    {
         dict_Sub=[Array_SearchData objectAtIndex:indexPath.row];
       
    }
    else
    {
        dict_Sub=[Array_suggested objectAtIndex:indexPath.row];

  
    }
        NSString *name = [dict_Sub valueForKey:@"fname"];
      NSString *nameTag = [dict_Sub valueForKey:@"fbid"];
    if (!Labelname)
        Labelname = (UILabel*)[cell viewWithTag:1];
    
    [Labelname setText:name];
   
        Labelname.text=name;
    
     NSURL * url=[dict_Sub valueForKey:@"profilepic"];
    if (!Proimage_View)
        Proimage_View = (UIImageView*)[cell viewWithTag:2];
    
        [Proimage_View sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
        if ([self.selectedUserid containsObject:nameTag])
        {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        return cell;
//        }
//        break;
//          
//        case 1:
//            {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//                UIImageView *Proimage_View=nil;
//                UILabel *Labelname=nil;
//                
//                
//                if (cell == nil) {
//                    
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
//                    Proimage_View=[[UIImageView alloc]initWithFrame:CGRectZero];
//                    Labelname=[[UILabel alloc]initWithFrame:CGRectZero];
//                    [Proimage_View setTag:2];
//                    [Labelname setTag:1];
//                    
//                    [[cell contentView] addSubview:Proimage_View];
//                    [[cell contentView] addSubview:Labelname];
//                    
//                    
//                    
//                }
//                
//                [cell addSubview:Proimage_View];
//                [cell addSubview:Labelname];
//                Proimage_View.frame=CGRectMake(10, 8, 32, 32);
//                Proimage_View.clipsToBounds=YES;
//                Proimage_View.layer.cornerRadius=Proimage_View.frame.size.height/2;
//                Labelname.frame=CGRectMake(50, 0, self.view.frame.size.width-67, 48);
//                
//                //        Proimage_View.backgroundColor=[UIColor greenColor];
//                //        Labelname.text =@"vvdsdsdsfddfsdsddggdfgdfgdfggdgdfgfgdfgdfgdfgdfgdfgdfgdgdfgsfdsfdsf";
//                
//                NSString *name = [[Array_SearchData valueForKey:@"name"]objectAtIndex:indexPath.row];
//                NSString *nameTag = [[Array_SearchData valueForKey:@"userid"]objectAtIndex:indexPath.row];
//                if (!Labelname)
//                    Labelname = (UILabel*)[cell viewWithTag:1];
//                
//                [Labelname setText:name];
//                
//                Labelname.text=name;
//                NSMutableDictionary *dict_Sub=[Array_SearchData objectAtIndex:indexPath.row];
//                NSURL * url=[dict_Sub valueForKey:@"profilepic"];
//                if (!Proimage_View)
//                    Proimage_View = (UIImageView*)[cell viewWithTag:2];
//                
//                [Proimage_View sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
//                if ([self.selectedUserid containsObject:nameTag])
//                {
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    
//                }
//                else
//                {
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                }
//                NSLog(@"SEACH CELL  Array_SearchData=%@", Array_SearchData);
//                NSLog(@"SEACH CELL  Array_SearchData=%@", [Array_SearchData objectAtIndex:indexPath.row]);
//                return cell;
//            }
//            break;
//    }
//    
//    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,35)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0f];
        Label1.text=@"Suggested friends";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    
    return  sectionView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        
        if ( [String_suggested isEqualToString:@"yes"])
        {
            return 0;
        }
        else
        {
            if (Array_suggested.count==0)
            {
                return 0;
            }
            else
            {
                return 35;
            }
            
        }
        
        
        //        if (Array_SearchData.count==0)
        //        {
        //            return 0;
        //        }
        //        else
        //        {
        //         return 35;
        //        }
        
        
        
    }
       return 0;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name2,*name1;
    
    NSDictionary *dict_Sub;
    if ( [String_suggested isEqualToString:@"yes"])
    {
        dict_Sub=[Array_SearchData objectAtIndex:indexPath.row];
        
    }
    else
    {
        dict_Sub=[Array_suggested objectAtIndex:indexPath.row];
        
        
    }
    name2= [dict_Sub valueForKey:@"fname"];
    name1 = [dict_Sub valueForKey:@"fbid"];
    
    if ((selectedUserid.count==0 && self.selectedNames.count==0)||![selectedUserid containsObject:name1] )
    {
          Send_Button.enabled=YES;
            Send_Button.alpha=1;
         [Send_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
           // NSString *displayName = name2.text;
    [self.contactPickerView addContact:name2 withDisplayName:name2];
        

//        CLToken *token = [[CLToken alloc] initWithDisplayText:name2 context:nil];
        [selectedUserid addObject:name1];
         [selectedNames addObject:name2];
        
       
//        NSLog(@"tokentokentoken=%@",token);
//        NSLog(@"token1111111=%@",token);
    }
    

    Table_ContactView.hidden=NO;
    
   NSLog(@"didRemoveToken=%@",self.selectedNames);
     NSLog(@"selectedUserid=%@",selectedUserid);
  //String_suggested=@"no";
}
-(void)communication_createEvent
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];

    NSString *fbid1= @"fbid";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    NSString *meetupstitle= @"title";
    
    
    NSString *location= @"location";
  
    
    NSString *friendlist= @"friendlist";
    NSString *friendlistVal =[selectedUserid componentsJoinedByString:@","];
    
    NSString *eventdate= @"eventdate";
 
     NSString *description= @"description";
    
    
    NSString *meetupstitleval=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textfield_meetup1,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    
    NSString *locationVal=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textfield_location1,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    
    
    NSString * descriptionval=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)textview_disc1,NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
    
    
     NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,meetupstitle,meetupstitleval,location,locationVal,friendlist,friendlistVal,eventdate,label_date1,description,descriptionval];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"createevent"];;
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
                                                 
                                                 array_createEvent=[[NSMutableArray alloc]init];
                                                 SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                 array_createEvent=[objSBJsonParser objectWithData:data];
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                               ;
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 NSLog(@"array_createEvent %@",array_createEvent);
                                                 
                                                 
                                                 NSLog(@"array_createEvent ResultString %@",ResultString);
            if (array_createEvent.count !=0)
                        {
                [self.view hideActivityViewWithAfterDelay:1];
                FriendCahtingViewControlleroneViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewControlleroneViewController"];
                            set.AllDataArray=array_createEvent;
                            
                    if ([Str_eventcreate isEqualToString:@"yes"])
                            {
                                if (selectedNames.count==0)
                                {
                                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Share it!" message:@"Since you have not invited any in-app friends, you can share this meet-up with your other friends by going into settings." preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                       style:UIAlertActionStyleDefault
                                                                                     handler:^(UIAlertAction *action)
                                                               {
                                                [self.navigationController pushViewController:set animated:YES];
                                                                
                                                               }];
                                    
                                    [alertController addAction:actionOk];
                                    [self presentViewController:alertController animated:YES completion:nil];
                                }
                                else
                                {
                                  [self.navigationController pushViewController:set animated:YES];
                                }
                                
                            }
                    else
                    {
                         [self.navigationController pushViewController:set animated:YES];
          
                    }
                          
                        

                     [defaults setObject:@"yes" forKey:@"tapindex"];
                        [defaults setObject:@"yes" forKey:@"letsmeet"];
                                [defaults synchronize];
                            
                        }
                        if ([ResultString isEqualToString:@"inserterror"])
                        {
                                                   
                           [self.view hideActivityViewWithAfterDelay:1];
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
     [alertController addAction:actionOk];
                            [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"expired"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Meetups date has been expired. please checkup your enter date and time." preferredStyle:UIAlertControllerStyleAlert];
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
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
-(void)communication_MorefriendsEvent
{
    
    
   // eventdetails_addfriends.php
    
    NSString *fbid1= @"fbid";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    NSString *eventid= @"eventid";
    NSString *eventidval=[defaults valueForKey:@"neweventid"];
    
    NSString *friendlist= @"friendlist";
    NSString *friendlistVal =[selectedUserid componentsJoinedByString:@","];
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidval,friendlist,friendlistVal];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"eventdetails_invitefriends"];;
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
                                                 
                                                 array_createEvent=[[NSMutableArray alloc]init];
                                                 SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                 array_createEvent=[objSBJsonParser objectWithData:data];
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 ;
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 NSLog(@"array_createEvent %@",array_createEvent);
                                                 
                                                 
                                                 NSLog(@"array_createEvent ResultString %@",ResultString);
                                                 if ([ResultString isEqualToString:@"done"])
                                                 {
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                 }
                                                 if (array_createEvent.count !=0)
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     
                                                     
                                                     FriendCahtingViewControlleroneViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewControlleroneViewController"];
                                                     set.AllDataArray=array_createEvent;
                                                     [self.navigationController pushViewController:set animated:YES];
                                                     [defaults setObject:@"yes" forKey:@"tapindex"];
                                                     [defaults setObject:@"yes" forKey:@"letsmeet"];
                                                     [defaults synchronize];
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"inserterror"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"expired"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:1];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Meetups date has been expired. please checkup your enter date and time." preferredStyle:UIAlertControllerStyleAlert];
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
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
-(void)Communication_Invite_user
{
    
    
    
    NSURL *url11;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
    NSString *tagName11=@"fbid";
    NSString *tagnameV11=[defaults valueForKey:@"fid"];
    
    NSString *eventid=@"eventid";
    NSString *eventidval=[defaults valueForKey:@"neweventid"];
    
    NSString *reqStringFUll11;
    NSMutableURLRequest *request11;
    NSString *  urlStrLivecount11;
    if([str_checkmorefriends isEqualToString:@"morefriend"])
    {
        urlStrLivecount11=[urlplist valueForKey:@"eventdetails_addfriends"];
        
        
        reqStringFUll11=[NSString stringWithFormat:@"%@=%@&%@=%@",tagName11,tagnameV11,eventid,eventidval];
    }
    else
    {
        urlStrLivecount11=[urlplist valueForKey:@"createevent_addfriends"];
        
        
        reqStringFUll11=[NSString stringWithFormat:@"%@=%@",tagName11,tagnameV11];
    }
    
    url11 =[NSURL URLWithString:urlStrLivecount11];
    request11 = [NSMutableURLRequest requestWithURL:url11];
    
    [request11 setHTTPMethod:@"POST"];
    
    [request11 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData11 = [NSData dataWithBytes:[reqStringFUll11 UTF8String] length:[reqStringFUll11 length]];
    [request11 setHTTPBody: requestData11];
    
    Connection_Recomm_GetUser = [[NSURLConnection alloc] initWithRequest:request11 delegate:self];
    {
        if( Connection_Recomm_GetUser)
        {
            webData_Recomm_GetUser =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
 

    
}
-(void)Communication_SuggestedFriends
{
    
    
    
    NSURL *url11;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
    
    
    
    NSString *tagName11=@"fbid";
    NSString *tagnameV11=[defaults valueForKey:@"fid"];
    
    NSString *eventid=@"eventid";
    NSString *eventidval=[defaults valueForKey:@"neweventid"];
    
    NSString *reqStringFUll11;
    NSMutableURLRequest *request11;
    NSString *  urlStrLivecount11;
    if([str_checkmorefriends isEqualToString:@"morefriend"])
    {
       urlStrLivecount11=[urlplist valueForKey:@"eventdetails_addfriends"];
        
        
        reqStringFUll11=[NSString stringWithFormat:@"%@=%@&%@=%@",tagName11,tagnameV11,eventid,eventidval];
    }
    else
    {
     urlStrLivecount11=[urlplist valueForKey:@"createevent_addfriends"];
       
        
        reqStringFUll11=[NSString stringWithFormat:@"%@=%@",tagName11,tagnameV11];
    }

    url11 =[NSURL URLWithString:urlStrLivecount11];
    request11 = [NSMutableURLRequest requestWithURL:url11];
    
    [request11 setHTTPMethod:@"POST"];
    
    [request11 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData *requestData11 = [NSData dataWithBytes:[reqStringFUll11 UTF8String] length:[reqStringFUll11 length]];
    [request11 setHTTPBody: requestData11];
    
    Connection_suggested = [[NSURLConnection alloc] initWithRequest:request11 delegate:self];
    {
        if( Connection_suggested)
        {
            webData_suggested =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(connection==Connection_Recomm_GetUser)
    {
        [webData_Recomm_GetUser setLength:0];
        
        
    }
    if(connection==Connection_suggested)
    {
        [webData_suggested setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(connection==Connection_Recomm_GetUser)
    {
        [webData_Recomm_GetUser appendData:data];
    }
    if(connection==Connection_suggested)
    {
        [webData_suggested appendData:data];
    }
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    
    if (connection==Connection_Recomm_GetUser)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];

        ResultString_Recomm_getUser=[[NSString alloc]initWithData:webData_Recomm_GetUser encoding:NSUTF8StringEncoding];
        Array_Reomm_GetUser= [objSBJsonParser objectWithData:webData_Recomm_GetUser];
        Search_Array_Recoom= [objSBJsonParser objectWithData:webData_Recomm_GetUser];
        [Array_SearchData addObjectsFromArray:Search_Array_Recoom];
        ResultString_Recomm_getUser = [ResultString_Recomm_getUser stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_Recomm_getUser = [ResultString_Recomm_getUser stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_Reomm_GetUser== %@",Array_Reomm_GetUser);
        NSLog(@"ResultString_Recomm_getUser %@",ResultString_Recomm_getUser);
        
        
        
            [self checkResult];
       
        
    }
    
    if (connection==Connection_suggested)
    {
        Array_suggested=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        
        ResultString_suggested=[[NSString alloc]initWithData:webData_suggested encoding:NSUTF8StringEncoding];
        Array_suggested= [objSBJsonParser objectWithData:webData_suggested];
       
        ResultString_suggested = [ResultString_suggested stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_suggested = [ResultString_suggested stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_suggested== %@",Array_suggested);
        NSLog(@"ResultString_suggested %@",ResultString_suggested);
       
            [self checkResult];
        
        
        
   
    }

    
   
    
    
  
}
-(void)checkResult
{
    if (Array_Reomm_GetUser.count==0 && Array_suggested.count==0)
    {
        _label_Result.hidden=NO;
        Table_ContactView.hidden=YES;
           self.contactPickerView.hidden=YES;
        [self.view endEditing:YES];

    }
    else
    {
           self.contactPickerView.hidden=NO;
        Table_ContactView.hidden=NO;
        _label_Result.hidden=YES;
         [Table_ContactView reloadData];
    }
}
-(IBAction)BackButton:(id)sender
{
   
//     strInvite_users= [selectedNames componentsJoinedByString:@","];
//    NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:selectedNames,@"desc", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:self
//                                                      userInfo:theInfo];
//    NSDictionary *theInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:selectedUserid,@"descId", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayUserId" object:self
//                                                      userInfo:theInfo1];
//    NSLog(@"concat_UserId ==%@ ",strInvite_users);
//    NSLog(@"concat_UserId ==%@ ",selectedNames);
    [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)SendButtons:(id)sender
{
    [self.view endEditing:YES];
    [self.view showActivityViewWithLabel:@"Loading"];
//    strInvite_users= [selectedNames componentsJoinedByString:@","];
////      [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:[NSDictionary dictionaryWithObject:strInvite_users forKey:@"desc"]];
////     [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:[NSDictionary dictionaryWithObject:strInvite_users forKey:@"desc"]];
//    
//    NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:selectedNames,@"desc", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:self
//userInfo:theInfo];
//    NSDictionary *theInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:selectedUserid,@"descId", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayUserId" object:self
//                                                      userInfo:theInfo1];
//    NSLog(@"concat_UserId ==%@ ",strInvite_users);
//    NSLog(@"concat_UserId ==%@ ",selectedNames);
//       [self.navigationController popViewControllerAnimated:YES];
   if([str_checkmorefriends isEqualToString:@"morefriend"])
   {
       [self communication_MorefriendsEvent];
   }
   else
   {
      [self communication_createEvent];
   }
    
}

-(void)dataReceived1:(NSNotification *)noti
{
    NSLog(@"days1111=%@",noti.object);
   NSArray * Array_Names= [[noti userInfo] objectForKey:@"desc"];
    NSLog(@"theArraytheArray=%@",Array_Names);
   NSString * String_Cont_Name=[Array_Names componentsJoinedByString:@","];
    NSLog(@"strInvite_usersstrInvite_users=%@",String_Cont_Name);
}

- (void)LCNContactPickerTextViewDidChange:(NSString *)textViewText
{
    [Table_ContactView setFrame:CGRectMake(0, Table_ContactView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-350)];
    
    if (textViewText.length==0)
    {
        [Array_SearchData removeAllObjects];
        
        
        [Array_SearchData addObjectsFromArray:Search_Array_Recoom];
        
        Table_ContactView.hidden = NO;
         String_suggested=@"no";
        
    }
    else
        
    {
       String_suggested=@"yes";
        
        [Array_SearchData removeAllObjects];
        
        for (NSDictionary *book in Search_Array_Recoom)
        {
            NSString * string=[book objectForKey:@"fname"];
            NSString * string1=[book objectForKey:@"fname"];
            NSRange r=[string rangeOfString:textViewText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound)
            {
                
                NSLog(@"IMAGE PROBLEM=%@",string1);
                NSLog(@"book PROBLEM=%@",book);
                [Array_SearchData addObject:book];
                
            }
            
        }
         NSLog(@"Array_SearchDataSearch=======%@",Array_SearchData);
        Table_ContactView.hidden = NO;
    }
    
    
    [Table_ContactView reloadData];
    
    
    
    //    NSInteger indexValue = [_selectedNames indexOfObject:name];
    //    NSLog(@"index of contain object didAddToken==%ld",(long)indexValue);
    //    NSLog(@"selectedUserid contain object didAddToken==%@",selectedUserid);
    //    NSLog(@"Array count object didAddToken==%lu",(unsigned long)_selectedNames.count);
    //    NSLog(@"Array count object didAddToken==%lu",(unsigned long)selectedUserid.count);
    
    NSLog(@">>>>>TextChanged:%@",textViewText);
}

- (void)LCNContactPickerDidRemoveContact:(id)contact
{
    NSLog(@"didAddToken=%@",contact);
    NSLog(@">>>>>ContactRemoved");
    String_suggested= @"no";
    if(selectedNames.count !=0)
    {
    if (!contact)
    {
        NSString *name = contact;
        
        NSInteger indexValue = [selectedNames indexOfObject:name];
        NSLog(@"index of contain object didRemoveToken==%ld",(long)indexValue);
        
        [selectedUserid removeObjectAtIndex:indexValue];
        
        NSLog(@"selectedUserid removeObjectAtIndex didRemoveToken==%@",selectedUserid);
        [self.selectedNames removeObjectAtIndex:indexValue];
        
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedNames.count);
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedUserid.count);
    }
    else
    {
//        NSInteger indexValue = [_selectedNames indexOfObject:_selectedNames.count-1];
//        NSLog(@"index of contain object didRemoveToken==%ld",(long)indexValue);
        if(selectedNames !=0)
        {
        [selectedUserid removeObjectAtIndex:selectedNames.count-1];
        
        NSLog(@"selectedUserid removeObjectAtIndex didRemoveToken==%@",selectedUserid);
        [self.selectedNames removeObjectAtIndex:selectedNames.count-1];
        
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedNames.count);
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedUserid.count);
        }
    }
        
        
  
    
    
    }
    if (self.selectedNames.count==0)
    {
        if ([Str_eventcreate isEqualToString:@"yes"])
        {
            Send_Button.enabled=YES;
            [Send_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            Send_Button.alpha=1;
        }
        else
        {
            Send_Button.enabled=NO;
            [Send_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            Send_Button.alpha=0.8;
            [Table_ContactView reloadData];
        }
    }
    else
    {
        Send_Button.enabled=YES;
         [Send_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Send_Button.alpha=1;
    }
    [Table_ContactView reloadData];
}

- (void)LCNContactPickerDidResize:(LCNContactPickerView *)contactPickerView
{
    NSLog(@">>>>>ResizeViewHeight:%f",contactPickerView.frame.size.height);
    Table_ContactView.frame=CGRectMake(0, contactPickerView.frame.size.height+100, self.view.frame.size.width, self.view.frame.size.height-(contactPickerView.frame.size.height+100));
    String_suggested=@"no";
    [Table_ContactView reloadData];
    
}

- (BOOL)LCNContactPickerTextFieldShouldReturn:(LCNTextField *)textField
{
//        NSString *displayName = textField.text;
//        [self.contactPickerView addContact:displayName withDisplayName:displayName];
     //  textField.text = @"";
   String_suggested =@"no";
    
    return YES;
}

- (void)LCNContactPickerDidSelectedContactView:(LCNContactView *)contactView
{
    NSLog(@">>>>>ContactView  selected=%@",contactView);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
