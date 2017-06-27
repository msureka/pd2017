//
//  MeetupDetailsViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 6/19/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "MeetupDetailsViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "MainProfilenavigationController.h"
#import "NavigationNewPlayDateViewController.h"
#import "InviteSprintTagUserViewController.h"
@interface MeetupDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
    UIView *sectionView;
    NSArray * Array_title;
    NSDictionary *urlplist;
    NSMutableArray * Array_AllMeetupData,*Array_InvitesData,*Array_AttendingData,*Array_Date;
      NSUserDefaults *defaults;
}
@end

@implementation MeetupDetailsViewController
@synthesize Cell_One,Cell_OneOne,HeadTopView,Cell_three,indicator,eventidvalue,cell_Details;
- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
   
  
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
   
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=80;
    Xwidth_label=60;
    Yheight_label=22;
    [indicator startAnimating];
    indicator.hidden=YES;
    _Table_Friend.hidden=YES;
    [self communication_invitemeetups];
     //[_Table_Friend reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self communication_invitemeetups];
}
-(void)communication_invitemeetups
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
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val=[defaults valueForKey:@"fid"];
        
        NSString *eventid= @"eventid";
     
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"eventdetails"];;
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
                                                     
                                Array_AllMeetupData=[[NSMutableArray alloc]init];
                            Array_InvitesData=[[NSMutableArray alloc]init];
                            Array_AttendingData=[[NSMutableArray alloc]init];
                            Array_Date=[[NSMutableArray alloc]init];
                            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                        Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                    NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"noeventid"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"noeventid" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                                                                    {
                                [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];

                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                    if (Array_AllMeetupData.count !=0)
                                {
                                    
                                    
                                    
                                    if(![[defaults valueForKey:@"fid"] isEqualToString:[[Array_AllMeetupData objectAtIndex:0]valueForKey:@"creatorfbid"]])
                                    {
                        Array_title=[[NSArray alloc]initWithObjects:@"Remove this meetup", nil];
                                    }
                                    else
                                    {
                    Array_title=[[NSArray alloc]initWithObjects:@"Invite more friends",@"Edit this meetup",@"Delete this meetup", nil];
                                     
                                    }
                                    
                            
                                    
                                    
    _Table_Friend.hidden=NO;
    for (int i=0; i<Array_AllMeetupData.count; i++)
            {
if ([[[Array_AllMeetupData objectAtIndex:i]valueForKey:@"invitedstatus"] isEqualToString:@"INVITED"])
                {
        [Array_InvitesData addObject:[Array_AllMeetupData objectAtIndex:i]];
                                                                 
                    }
              if ([[[Array_AllMeetupData objectAtIndex:i]valueForKey:@"attendingstatus"] isEqualToString:@"ATTENDING"])
                    {
            [Array_AttendingData addObject:[Array_AllMeetupData objectAtIndex:i]];
                    }

                                           
                                    }
                                    
                    [Array_Date addObject:[Array_AllMeetupData objectAtIndex:0]];
                    [_Table_Friend reloadData];
                                                 
                                                 [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                     }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     if (section==0)
        {
            return 1;
        }
        if (section==1)
        {
            if (Array_InvitesData.count !=0)
            {
                return 1;
            }
            
        }
        if (section==2)
        {
            if (Array_AttendingData.count !=0)
            {
                return 1;
            }
        }
    if (section==3)
    {
   
        return Array_title.count;
       
    }

    
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        if (indexPath.section==0)
        {
            return 225;
        }
        
        if (indexPath.section==1)
        {
           
                return 160;
            
            
            
        }
        if (indexPath.section==2)
        {
            
                return 147;
          
            
        }
    if (indexPath.section==3)
    {
        
        return 54;
        
        
    }
    
    
    return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid=@"Celldetail";
    static NSString *Cellid1=@"Cellone";
    static NSString *cellId2=@"Celltwo";
    static NSString *cellId3=@"Cellthree";
   
        switch (indexPath.section)
        {
                
            case 0:
            {
                
                cell_Details = (MeetupDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid forIndexPath:indexPath];
                
                
                
                
                
                
                cell_Details.label_title.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"];
                cell_Details.label_location.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"];
                cell_Details.label_datetime.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventdateformat"];
                cell_Details.label_eventcode.text=[NSString stringWithFormat:@"%@%@%@",@"(Event Code: ",eventidvalue,@")"];
                
                cell_Details.label_createdname.text=[NSString stringWithFormat:@"%@%@",@"Created by ",[[Array_Date objectAtIndex:0]valueForKey:@"fname"]];
                
                
                [cell_Details.Image_CreatedProfilepic setFrame:CGRectMake(cell_Details.Image_CreatedProfilepic.frame.origin.x, cell_Details.Image_CreatedProfilepic.frame.origin.y, cell_Details.Image_CreatedProfilepic.frame.size.height, cell_Details.Image_CreatedProfilepic.frame.size.height)];
                NSURL * url1=[[Array_Date objectAtIndex:0]valueForKey:@"profilepic"];
                
                if ([[[Array_Date objectAtIndex:0]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [cell_Details.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [cell_Details.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"girlpictureframe 1.png"]options:SDWebImageRefreshCached];
                }
                
                
                
                
                return cell_Details;
                
                
            }
                break;
            case 1:
            {
                
                Cell_One = (InvitemeetupsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_One.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                
                
                CALayer *borderBottomViewTap6 = [CALayer layer];
                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
                [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                
              
                
                NSString *text =[NSString stringWithFormat:@"%d",Array_InvitesData.count];// @"300";
               
                CGSize constraint = CGSizeMake(296,9999);
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]
                               constrainedToSize:constraint
                                   lineBreakMode:UILineBreakModeWordWrap];
                [Cell_One.label_Invitecount setFrame:CGRectMake(Cell_One.label_Invitecount.frame.origin.x, Cell_One.label_Invitecount.frame.origin.y, size.width+16, Cell_One.label_Invitecount.frame.size.height)];
                
                 Cell_One.label_Invitecount.text=text;
                Cell_One.label_Invitecount.clipsToBounds=YES;
                Cell_One.label_Invitecount.layer.cornerRadius= Cell_One.label_Invitecount.frame.size.height/2;;
                
                Cell_One.label_title.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"];
                Cell_One.label_location.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"];
                Cell_One.label_datetime.text=[[Array_Date objectAtIndex:0]valueForKey:@"eventdateformat"];
                
                
                Cell_One.label_createdname.text=[NSString stringWithFormat:@"%@%@",@"Created by ",[[Array_Date objectAtIndex:0]valueForKey:@"fname"]];
                
                
                [Cell_One.Image_CreatedProfilepic setFrame:CGRectMake(Cell_One.Image_CreatedProfilepic.frame.origin.x, Cell_One.Image_CreatedProfilepic.frame.origin.y, Cell_One.Image_CreatedProfilepic.frame.size.height, Cell_One.Image_CreatedProfilepic.frame.size.height)];
                NSURL * url1=[[Array_Date objectAtIndex:0]valueForKey:@"profilepic"];
                
                if ([[[Array_InvitesData objectAtIndex:0]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    
                    
                    [Cell_One.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                    
                }
                else
                {
                    [Cell_One.Image_CreatedProfilepic sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"girlpictureframe 1.png"]options:SDWebImageRefreshCached];
                }
                
                
                
                for (int i=0; i<Array_InvitesData.count; i++)
                {
                    
                    UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                    UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                    
                    
                    Imagepro.userInteractionEnabled=YES;
                    
                    [Imagepro setTag:i];
                    Imagepro.backgroundColor=[UIColor redColor];
                    
                    UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(ImageTapped_profile1:)];
                    [Imagepro addGestureRecognizer:ImageTap];
                    
                    
                    Imagepro.clipsToBounds=YES;
                    Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                    [Imagepro setBackgroundColor:[UIColor redColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                     // [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                    
                    Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                 
                    
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                   
                        Label_name.text=[[Array_InvitesData objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        
                    
                    
                    [Cell_One.myscrollView addSubview:Label_name];
                    [Cell_One.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_InvitesData objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_InvitesData objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
                    {
                        
                        
                        
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                        
                    }
                    else
                    {
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"girlpictureframe 1.png"]options:SDWebImageRefreshCached];
                    }
                    
                    
                    
                    Xpostion+=Xwidth+20;
                    //Xpostion_label+=Xwidth_label+12;
                    
                    ScrollContentSize+=Xwidth;
                    Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 115);
                    
                    
                    
                    
                    
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=60;
                Yheight=60;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=80;
                Xwidth_label=60;
                Yheight_label=22;
                        return Cell_One;
                
                
            }
                break;
              
                
            case 2:
            {
                
                Cell_OneOne = (AttendingMeetupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_OneOne.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                 NSString *text =[NSString stringWithFormat:@"%d",Array_AttendingData.count];
                CGSize constraint = CGSizeMake(296,9999);
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]
                               constrainedToSize:constraint
                                   lineBreakMode:UILineBreakModeWordWrap];
                [Cell_OneOne.label_AttendingCount setFrame:CGRectMake(Cell_OneOne.label_AttendingCount.frame.origin.x, Cell_OneOne.label_AttendingCount.frame.origin.y, size.width+16,Cell_OneOne.label_AttendingCount.frame.size.height)];
                Cell_OneOne.label_AttendingCount.text=text;
                Cell_OneOne.label_AttendingCount.clipsToBounds=YES;
                Cell_OneOne.label_AttendingCount.layer.cornerRadius= Cell_OneOne.label_AttendingCount.frame.size.height/2;;
//                CALayer *borderBottomViewTap6 = [CALayer layer];
//                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
//                borderBottomViewTap6.frame = CGRectMake(0, Cell_OneOne.myscrollView.frame.size.height - 1, Cell_OneOne.myscrollView.frame.size.width, 1);
//                [Cell_OneOne.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                for (int i=0; i<Array_AttendingData.count; i++)
                {
                    
                    UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                    UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                    
                    
                    Imagepro.userInteractionEnabled=YES;
                    
                    [Imagepro setTag:i];
                    
                    
                    UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(ImageTapped_profile:)];
                    [Imagepro addGestureRecognizer:ImageTap];
                    
                    
                    Imagepro.clipsToBounds=YES;
                    Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                    [Imagepro setBackgroundColor:[UIColor redColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                        Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                 
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                 
                    
                    
                        
                        Label_name.text=[[Array_AttendingData objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        
                
                    
                
                    
                    [Cell_OneOne.myscrollView addSubview:Label_name];
                    [Cell_OneOne.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_AttendingData objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_AttendingData objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
                    {
                        
                        
                        
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"]options:SDWebImageRefreshCached];
                        
                    }
                    else
                    {
                        [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"girlpictureframe 1.png"]options:SDWebImageRefreshCached];
                    }
                    
                
                    
                    Xpostion+=Xwidth+20;
                    //Xpostion_label+=Xwidth_label+12;
                    
                    ScrollContentSize+=Xwidth;
                    Cell_OneOne.myscrollView.contentSize=CGSizeMake(Xpostion, 115);
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=60;
                Yheight=60;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=80;
                Xwidth_label=60;
                Yheight_label=22;
               
             
                return Cell_OneOne;
                
     
}
 break;
  case 3:
            {
                
                Cell_three = (InvitemoremeetupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
                
                Cell_three.label_invitemoresroes.text=[Array_title objectAtIndex:indexPath.row];
              
               
                CALayer *borderBottom = [CALayer layer];
                borderBottom.backgroundColor = [UIColor whiteColor].CGColor;
                
                borderBottom.frame = CGRectMake(0, Cell_three.frame.size.height - 5, Cell_three.frame.size.width, 6);
                [Cell_three.layer addSublayer:borderBottom];
                
                return Cell_three;
                
                
            }
                break;
                
        }
    
    return nil;


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 4;
   
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    
        if (section==2)//1
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,45)];
            [sectionView setBackgroundColor:[UIColor lightGrayColor]];
            UIButton * Label1=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
         
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
           [Label1 setTitle:@"Invite more friends" forState:UIControlStateNormal];
            [Label1 setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
            [Label1 setTitle:@"Invite more friends" forState:UIControlStateNormal];
            [Label1 addTarget:self action:@selector(Invitemorefriend_Acttion:) forControlEvents:UIControlEventTouchUpInside];
            
            [sectionView addSubview:Label1];
            sectionView.tag=section;
            
        }
    
        return  sectionView;
        
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
//        if (section==2)
//        {
//           
//          return 45;
//            
//        }
    
    
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
    if(![[defaults valueForKey:@"fid"] isEqualToString:[[Array_AllMeetupData objectAtIndex:0]valueForKey:@"creatorfbid"]])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Remove Meetup" message:@"Are you sure you want to remove yourself from this meetup?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                           [self DeleteEventCreatedIndexZero];
                                       }];
            UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"No"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            
                                        }];
            
            [alertController addAction:actionOk];
            [alertController addAction:actionOk1];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            
            [self invitemoreIndexZero];
   
       
        }
        }
        if (indexPath.row==1)
        {
            [self EditmeetupIndexone];
        }

        if (indexPath.row==2)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete this meetup?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionYES = [UIAlertAction actionWithTitle:@"Yes"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                            [self DeleteeventIndexTwo];
                                       }];
            UIAlertAction *actionNO = [UIAlertAction actionWithTitle:@"No"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                          
                                       }];

            [alertController addAction:actionYES];
            [alertController addAction:actionNO];
            [self presentViewController:alertController animated:YES completion:nil];
            
          
        }

        
    }
    
   
}
-(IBAction)Button_BackView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Invitemorefriend_Acttion:(UIButton *)sender
{
    
}

-(IBAction)Button_share:(id)sender
{

NSString * texttoshare=[NSString stringWithFormat:@"%@%@%@",@"You have been invited to a Play:Date meet-up!\n\nUse the event code:\n",eventidvalue,@" to join the meet-up.\n\nDownload Play:Date on your iPhone from http://www.play-date.ae and find new friends for your children!"];
    

    NSArray *activityItems1=@[texttoshare];
    NSArray *activityItems =@[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems1 applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = activityItems;
    [self presentViewController:activityViewControntroller animated:YES completion:nil];
}
-(void)ImageTapped_profile1:(UIGestureRecognizer*)reconizer
{
    
}
-(void)ImageTapped_profile:(UIGestureRecognizer*)reconizer
{
    
}

-(void)invitemoreIndexZero
{
    InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
    
    set.str_checkmorefriends=@"morefriend";
    [self.navigationController pushViewController:set animated:YES];
}
-(void)EditmeetupIndexone
{
//    createdate = "2017-06-20 08:57:42";
//    creatorfbid = 1224819434269672;
//    eventdate =     {
//        date = "2017-06-24 08:58:48.000000";
//        timezone = UTC;
//        "timezone_type" = 3;

  
    [defaults setObject:@"edit" forKey:@"checkview"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventtitle"] forKey:@"textfield_title"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventlocation"] forKey:@"textfield_location"];
    
[defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventdate"] forKey:@"eventdateformat"];
    
    [defaults setObject:[[Array_Date objectAtIndex:0]valueForKey:@"eventdescription"] forKey:@"textview_disc"];
    [defaults synchronize];
    
    NavigationNewPlayDateViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationNewPlayDateViewController"];
    
    [self.navigationController presentModalViewController:tvc animated:YES];
   
    
}
-(void)DeleteeventIndexTwo
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
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val=[defaults valueForKey:@"fid"];
        
        NSString *eventid= @"eventid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"deleteevent"];;
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
                                                     
                                                     Array_AllMeetupData=[[NSMutableArray alloc]init];
                                                     Array_InvitesData=[[NSMutableArray alloc]init];
                                                     Array_AttendingData=[[NSMutableArray alloc]init];
                                                     Array_Date=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                if ([ResultString isEqualToString:@"noeventid"])
                                                {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"noeventid" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                            style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                    
                                                         
                                                     }
                                if ([ResultString isEqualToString:@"done"])
                                {
                                    
                                    [defaults setObject:@"yes" forKey:@"tapindex"];
                                    [defaults synchronize];
                            MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
                                      [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                    
                                   
                                    
                                }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
}
-(void)DeleteEventCreatedIndexZero
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
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val=[defaults valueForKey:@"fid"];
        
        NSString *eventid= @"eventid";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,eventid,eventidvalue];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"removeevent"];
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
                                                     
                                                     Array_AllMeetupData=[[NSMutableArray alloc]init];
                                                     Array_InvitesData=[[NSMutableArray alloc]init];
                                                     Array_AttendingData=[[NSMutableArray alloc]init];
                                                     Array_Date=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_AllMeetupData=[objSBJsonParser objectWithData:data];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ;
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"array_createEvent %@",Array_AllMeetupData);
                                                     
                                                     NSLog(@"array_createEvent ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"noeventid"])
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"noeventid" preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"done"])
                                                     {
                                                         
                                                         [defaults setObject:@"yes" forKey:@"tapindex"];
                                                         [defaults synchronize];
                                                         MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
                                                         [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                                         
                                                         
                                                         
                                                     }
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     if ((long)statusCode ==500)
                                                     {
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Check php file" preferredStyle:UIAlertControllerStyleAlert];
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:^(UIAlertAction *action)
                                                                                    {
                                                                                        [self.navigationController popViewControllerAnimated:YES];;
                                                                                    }];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         [indicator stopAnimating];
                                                         indicator.hidden=YES;
                                                         
                                                     }
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
}

@end
