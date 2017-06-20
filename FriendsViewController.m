//
//  FriendsViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendsViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "FriendCahtingViewController.h"
#import "FriendRequestViewController.h"
#import "ContactListViewController.h"
#import "FacebookListViewController.h"
#import "NavigationNewPlayDateViewController.h"
#import "FriendCahtingViewControlleroneViewController.h"
@interface FriendsViewController ()<UISearchBarDelegate>
{
     NSTimer *HomechatTimer,*HomechatTimerplaydate;
    NSArray *Array_Title1,*Array_Title2,*Array_Title3,*Array_Title4,*Array_Gender2,*Array_Gender1;
    UIView *sectionView,*transparancyTuchView;
    NSUserDefaults *defaults;
     NSString * TagId_plist,*FlagSearchBar,*searchString;
       BOOL flag;
    NSDictionary *urlplist;
    NSURLConnection *Connection_Match,*Connection_Messages;
    NSMutableData *webData_Match,*webData_Messages;
    NSMutableArray * Array_MatchMessages,*Array_Match,*Array_Messages,*Array_Comment1,*Array_Messages22,*Array_Request,*Array_RequestMessages,*array_createEvent,*Array_Meetups;
    NSArray *SearchCrickArray,*Array_Match1,*Array_Messages1,*Array_Request1,*Array_Meetups1;
    UIScrollView * scrollView;
   
    CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
    CGRect scrollFrame;
    UISearchBar * searchbar;
    NSMutableArray * myarr;
    NSMutableDictionary *dictionary;
     CALayer *borderBottom_chat,*borderBottom_playdate;
    NSString * Str_ChangeScreen;
}
@end

@implementation FriendsViewController
@synthesize HeadTopView,Table_Friend,Cell_One,Cell_Two,Button_chats,Button_playdates,Label_HeadTop,Button_Plustap,Cell_Two2;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"UpdatenotificationChat" object:nil];
    borderBottom_chat = [CALayer layer];
    borderBottom_playdate = [CALayer layer];
    Label_HeadTop.text=@"Friends";
    Button_Plustap.tag=1;
    [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    
    
//    Button_chats.clipsToBounds=YES;
//    Button_playdates.clipsToBounds=YES;
    
    
        Array_Comment1=[[NSMutableArray alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    FlagSearchBar=@"no";
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
    
    dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    myarr=[[NSMutableArray alloc]initWithContentsOfFile:path];
    
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:@"ChatText1.plist"];
    
    NSMutableArray *Array_Plist = [[NSMutableArray alloc] initWithContentsOfFile:path1];
    
    NSLog(@"dictionary setValue:=%@",Array_Plist );
    
    if (Array_Plist.count !=0)
    {
        Array_Request = [[NSMutableArray alloc]init];
        Array_Match=[[NSMutableArray alloc]init];
        Array_Messages=[[NSMutableArray alloc]init];
        
        
//        for (int i=0; i<Array_Plist.count; i++)
//        {
//            if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
//            {
//                [Array_Match addObject:[Array_Plist objectAtIndex:i]];
//            }
//            else
//            {
//                [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
//             // SearchCrickArray=[Array_Plist mutableCopy];
//            }
//        }
//         SearchCrickArray=[Array_Plist mutableCopy];
//        [Table_Friend reloadData];
        
        
        
        
        
        
        for (int i=0; i<Array_Plist.count; i++)
        {
            if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
            {
                
                if (Array_Match.count==0)
                {
                    [Array_Match addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
//                    for (int k=0; k<Array_Match.count; k++)
//                    {
//                        if (![[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"]])
//                        {
//                            
//                         [Array_Match addObject:[Array_Plist objectAtIndex:i]];
//                            
//                        }
//                        
//                        
//                    }
                    for (NSInteger k=Array_Match.count-1; k<Array_Match.count; k++)
                    {
                        NSString * fbMatch11=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch22=[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch22 isEqualToString:fbMatch11])
                        {
                            
                            [Array_Match addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }

                    
                }
            }
            
          else  if ([[[Array_Plist objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
            {
                
                if (Array_Request.count==0)
                {
                    [Array_Request addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger k=Array_Request.count-1; k<Array_Request.count; k++)
                    {
                        NSString * fbMatch11=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch22=[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch22 isEqualToString:fbMatch11])
                        {
                            
                            [Array_Request addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }
                    
                    
                }
            }

            
            else
            {
                if (Array_Messages.count==0)
                {
                    [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                        NSString * fbMatch=[[Array_Plist objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch2 isEqualToString:fbMatch])
                        {
                            
                            [Array_Messages addObject:[Array_Plist objectAtIndex:i]];
                            break;
                        }
                        
                    }
                }
                
            }
        }
        
        
        SearchCrickArray=[Array_MatchMessages mutableCopy];
        Array_Messages1=[Array_Messages mutableCopy];
        Array_Match1=[Array_Match mutableCopy];
        Array_Request1 = [Array_Request mutableCopy];
        [Table_Friend reloadData];
   
    }
    
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];

    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
     SearchCrickArray=[[NSArray alloc]init];
    Array_Match1=[[NSArray alloc]init];
    Array_Request1 = [[NSArray alloc]init];
    Array_Messages1=[[NSArray alloc]init];
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=72;
    Yheight=72;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=87;
    Xwidth_label=72;
    Yheight_label=22;
    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0, HeadTopView.frame.size.height+44, self.view.frame.size.width,self.view.frame.size.height-HeadTopView.frame.size.height-44)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
     UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = Table_Friend.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [Table_Friend insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
    
   // [Table_Friend addSubview:self.refreshControl]; //uday
    if ( [[defaults valueForKey:@"tapindex"] isEqualToString:@"yes"])
    {
        [defaults setObject:@"no" forKey:@"tapindex"];
        [defaults synchronize];
        Button_Plustap.tag=2;
        Str_ChangeScreen=@"playdate";
        Label_HeadTop.text=@"Create a Play:Date";
        [Button_chats setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [Button_playdates setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        borderBottom_playdate.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
        borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-2.5, Button_playdates.frame.size.width, 2.5);
        [Button_playdates.layer addSublayer:borderBottom_playdate];
        
        
        
        borderBottom_chat.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
        borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-1, Button_chats.frame.size.width, 1);
        [Button_chats.layer addSublayer:borderBottom_chat];
       
    }
    else
    {
        Button_Plustap.tag=1;
        Str_ChangeScreen=@"chats";
        Label_HeadTop.text=@"Friends";
        [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        [Button_playdates setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        borderBottom_chat.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
        borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
        [Button_chats.layer addSublayer:borderBottom_chat];
        
        borderBottom_playdate.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
        borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
        [Button_playdates.layer addSublayer:borderBottom_playdate];
        
        [self NewMatchServerComm];
        [Table_Friend reloadData];
    }
       [self communication_Eventsmeetups];
    // [self NewMatchServerComm];
    
    
//     HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(NewMatchServerComm) userInfo:nil  repeats:YES];
  
   //  [self homeTimer];

     NSLog(@"dictionary1_Array_Comment1:=%@",Array_Comment1 );
    
    
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    borderBottom_chat.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
//    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
//    [Button_chats.layer addSublayer:borderBottom_chat];
//    
//    
//    
//    
//    
//    
//    borderBottom_playdate.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
//    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
//    [Button_playdates.layer addSublayer:borderBottom_playdate];

}
-(void)homeTimer
{
    
    
    HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(NewMatchServerComm) userInfo:nil  repeats:YES];
    

}
-(void)homeTimerPlaydate
{
    
    
    HomechatTimerplaydate =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(communication_Eventsmeetups) userInfo:nil  repeats:YES];
    
    
}

- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}
-(void)calculate
{
   
   
//    UIAlertView * alt=[[UIAlertView alloc]initWithTitle:@"dasdd" message:@"fdsdss" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//    [alt show];

    
}
-(void)PulltoRefershtable
{

    
}




- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [HomechatTimer invalidate];
      HomechatTimer=nil;
    
        [HomechatTimerplaydate invalidate];
        HomechatTimerplaydate=nil;
        [Table_Friend reloadData];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
        [self communication_Eventsmeetups];
        [self homeTimerPlaydate];
   
        [self NewMatchServerComm];
        [self homeTimer];
       
        
    
    Xpostion=12;
    Ypostion=16;
    Xwidth=72;
    Yheight=72;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=87;
    Xwidth_label=72;
    Yheight_label=22;
    transparancyTuchView.hidden=YES;
    searchbar.text=@"";
    FlagSearchBar=@"no";
   
    [Table_Friend reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
        if (section==0)
        {
            return 0;
        }
        if (section==1)
        {
            return 1;
        }
        if (section==2)
        {
            return 1;
        }
        if (section==3)
        {
            return Array_Messages.count;
        }
    }
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        
        if (section==0)
        {
            return 0;
        }
        if (section==1)
        {
            return 0;
        }
       
        if (section==2)
        {
            if ( Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
               return Array_Meetups.count;
            }
           
        }
        
    }
    
   
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (indexPath.section==0)
    {
        return 0;
    }
    
    if (indexPath.section==1)
    {
        if (Array_Request.count==0)
        {
            return 0;
        }
        else
        {
            return 138;
        }
        
        
    }
    if (indexPath.section==2)
    {
        if (Array_Match.count==0)
        {
            return 0;
        }
        else
        {
            return 138;
        }
        
        
    }

    if (indexPath.section==3)
    {
        
        if (Array_Messages.count==0)
        {
            return 0;
        }
        else
        {
            return 98;
        }
        
        
    }
    }
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (indexPath.section==0)
        {
            return 0;
        }
        
        if (indexPath.section==1)
        {
//            if (Array_Match.count==0)
//            {
                return 0;
//            }
//            else
//            {
//                return 138;
//            }
//            
            
        }
        
        if (indexPath.section==2)
        {
            
            if (Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
                return 98;
            }
            
            
        }
    }
    return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"CellOne";
    
    
    static NSString *cellId2=@"CellTwo";
static NSString * Cellid111=@"Cellmeet";
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    switch (indexPath.section)
    {
         
        case 0:
        {
            return 0;
        }
           break;
        case 1:
        {
            
            Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            
            for(UIImageView* view in Cell_One.myscrollView.subviews)
            {
                
                [view removeFromSuperview];
                
            }
            
            
            
            
            CALayer *borderBottomViewTap6 = [CALayer layer];
            borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
            [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
            
            for (int i=0; i<Array_Request.count; i++)
            {
                
                UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                
                
                Imagepro.userInteractionEnabled=YES;
                
                [Imagepro setTag:i];
                
                
                UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(ImageTapped_profile1:)];
                [Imagepro addGestureRecognizer:ImageTap];
                
                
                Imagepro.clipsToBounds=YES;
                Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                [Imagepro setBackgroundColor:[UIColor clearColor]];
                Label_name.backgroundColor=[UIColor clearColor];
                Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                
                Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                

                
                
                Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                Label_name.numberOfLines = 1;
                Label_name.adjustsFontSizeToFitWidth=YES;
                Label_name.minimumScaleFactor=0.5;
                //                Label_name.baselineAdjustment = YES;
                //                Label_name.adjustsFontSizeToFitWidth = YES;
                //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                
                Label_name.textAlignment=NSTextAlignmentCenter;
                
//----------------------------------latest edit 1 apr ---------------------------------------------------
                
                NSString *textfname=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                
                if (searchString.length==0)
                    
                {
                    
                    Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    
                }
                
                else
                    
                {
                    
                    //commented by uday
                    
                    
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        
                        Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        Label_name.text=[[Array_Request objectAtIndex:i]valueForKey:@"fname"];
                        
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
//-------------------------------------------------------------------------------------------------------------
                
                
                
                
                [Cell_One.myscrollView addSubview:Label_name];
                [Cell_One.myscrollView addSubview:Imagepro];
                
                
                
                NSURL * url=[[Array_Request objectAtIndex:i]valueForKey:@"profilepic"];
                
                if ([[[Array_Request objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
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
                Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
            }
            
            
            
            Xpostion=12;
            Ypostion=16;
            Xwidth=72;
            Yheight=72;
            ScrollContentSize=0;
            Xpostion_label=12;
            Ypostion_label=87;
            Xwidth_label=72;
            Yheight_label=22;
            if (Array_Request.count==0)
            {
                Cell_One.Label_Noresult.hidden=NO;
            }
            else
            {
                Cell_One.Label_Noresult.hidden=YES;
            }
            return Cell_One;
            
            
        }
            break;
//---------------------------------------------------Match Cell --------------------------------------------------------------
            
        case 2:
        {
            
            Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            
            for(UIImageView* view in Cell_One.myscrollView.subviews)
            {
                
                [view removeFromSuperview];
                
            }
            
            
            
            
            CALayer *borderBottomViewTap6 = [CALayer layer];
            borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
            borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
            [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
            
            for (int i=0; i<Array_Match.count; i++)
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
                [Imagepro setBackgroundColor:[UIColor clearColor]];
                Label_name.backgroundColor=[UIColor clearColor];
                Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                
                Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                
                
                
                
                Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                Label_name.numberOfLines = 1;
                Label_name.adjustsFontSizeToFitWidth=YES;
                Label_name.minimumScaleFactor=0.5;
                //                Label_name.baselineAdjustment = YES;
                //                Label_name.adjustsFontSizeToFitWidth = YES;
                //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                
                Label_name.textAlignment=NSTextAlignmentCenter;
                
                //----------------------------------latest edit 1 apr ---------------------------------------------------
                
                NSString *textfname=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                
                if (searchString.length==0)
                    
                {
                    
                    Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    
                }
                
                else
                    
                {
                    
                    //commented by uday
                    
                    
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        
                        Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                        
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
                //-------------------------------------------------------------------------------------------------------------
                
                
                
                
                [Cell_One.myscrollView addSubview:Label_name];
                [Cell_One.myscrollView addSubview:Imagepro];
                
                
                
                NSURL * url=[[Array_Match objectAtIndex:i]valueForKey:@"profilepic"];
                
                if ([[[Array_Match objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
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
                Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
            }
            
            
            
            Xpostion=12;
            Ypostion=16;
            Xwidth=72;
            Yheight=72;
            ScrollContentSize=0;
            Xpostion_label=12;
            Ypostion_label=87;
            Xwidth_label=72;
            Yheight_label=22;
            if (Array_Match.count==0)
            {
                Cell_One.Label_Noresult.hidden=NO;
            }
            else
            {
                Cell_One.Label_Noresult.hidden=YES;
            }
            return Cell_One;
            
            
        }
            break;

//-----------------------------------------------end-----------------------------------------------------------------
        case 3://2
            
        {
            Cell_Two = (FriendsSecTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            NSURL * url=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"profilepic"];
           // Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
            // Cell_Two.Label_chatInfo.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"message"];
            
            NSString *text;
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
            {
                text =[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"message"];
            }
            else
            {
             text=@"Image";
            }
           
            NSString *textfname=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
            
            if (searchString.length==0)
            {
                
               Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
               Cell_Two.Label_chatInfo.text=text;
                Cell_Two.Label_chatInfo.textColor=[UIColor lightGrayColor];
               
            }
            else
            {
                
                //commented by uday
                
                NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
                NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                 NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                
                NSRange range = NSMakeRange(0 ,text.length);
                 NSRange rangefname = NSMakeRange(0 ,textfname.length);
              
                [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                }];
                
                [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                }];
                
                if ([FlagSearchBar isEqualToString:@"yes"])
                {
                    Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
                    Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                }
                else
                {
                    
                    
                    
                    Cell_Two.Label_name.text=[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"fname"];
                    Cell_Two.Label_chatInfo.text=text;
                    Cell_Two.Label_chatInfo.textColor=[UIColor lightGrayColor];

                   FlagSearchBar=@"no";
                    
                }
                
                
                
//                   Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
//                   Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                
                
            }
            
            
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqual:[NSNull null ]] || [[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] == nil)
                
            {
                [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
            }
            
            else
                
            {
                if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqualToString:@"Boy"])
                {
                    
                    [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
                    
                    
                    
                }
                else
                {
                    [Cell_Two.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"girlpictureframe.png"] options:SDWebImageRefreshCached];
                    
                }
            }
            
            
            
            
            Cell_Two.Image_messagered.tag=indexPath.row;
            if ([[[Array_Messages objectAtIndex:indexPath.row]valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                Cell_Two.Image_messagered.hidden=NO;
               [Cell_Two.Image_messagered setImage:[UIImage imageNamed:@"SpeechBubble1.png"]];
            }
            else
            {
                Cell_Two.Image_messagered.hidden=YES;
                 [Cell_Two.Image_messagered setImage:[UIImage imageNamed:@""]];
                
            }
            
                       return Cell_Two;
            
        }
            break;
            
          
    
}
}
    
  if ([Str_ChangeScreen isEqualToString:@"playdate"])
    
    {
        switch (indexPath.section)
        {
                
            case 0:
            {
                return 0;
            }
                break;
            case 1:
            {
                
                Cell_One = (FriendsSeconeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                for(UIImageView* view in Cell_One.myscrollView.subviews)
                {
                    
                    [view removeFromSuperview];
                    
                }
                
                
                
                
                CALayer *borderBottomViewTap6 = [CALayer layer];
                borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                borderBottomViewTap6.frame = CGRectMake(0, Cell_One.myscrollView.frame.size.height - 1, Cell_One.myscrollView.frame.size.width, 1);
                [Cell_One.myscrollView.layer addSublayer:borderBottomViewTap6];
                
                for (int i=0; i<Array_Match.count; i++)
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
                    [Imagepro setBackgroundColor:[UIColor clearColor]];
                    Label_name.backgroundColor=[UIColor clearColor];
                    Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                    
                    Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    
                    
                    
                    
                    Label_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14]; //custom font
                    Label_name.numberOfLines = 1;
                    Label_name.adjustsFontSizeToFitWidth=YES;
                    Label_name.minimumScaleFactor=0.5;
                    //                Label_name.baselineAdjustment = YES;
                    //                Label_name.adjustsFontSizeToFitWidth = YES;
                    //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                    
                    Label_name.textAlignment=NSTextAlignmentCenter;
                    
                    //----------------------------------latest edit 1 apr ---------------------------------------------------
                    
                    NSString *textfname=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                    
                    if (searchString.length==0)
                        
                    {
                        
                        Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                        Label_name.backgroundColor=[UIColor clearColor];
                        Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                        
                    }
                    
                    else
                        
                    {
                        
                        //commented by uday
                        
                        
                        NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                        
                        
                        NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                        
                        
                        NSRange rangefname = NSMakeRange(0 ,textfname.length);
                        
                        
                        [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                            
                            NSRange subStringRange = [result rangeAtIndex:0];
                            [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                        }];
                        
                        if ([FlagSearchBar isEqualToString:@"yes"])
                        {
                            
                            Label_name.attributedText=mutableAttributedStringfname;
                        }
                        else
                        {
                            
                            Label_name.text=[[Array_Match objectAtIndex:i]valueForKey:@"fname"];
                            
                            FlagSearchBar=@"no";
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    //-------------------------------------------------------------------------------------------------------------
                    
                    
                    
                    
                    [Cell_One.myscrollView addSubview:Label_name];
                    [Cell_One.myscrollView addSubview:Imagepro];
                    
                    
                    
                    NSURL * url=[[Array_Match objectAtIndex:i]valueForKey:@"profilepic"];
                    
                    if ([[[Array_Match objectAtIndex:i]valueForKey:@"gender"] isEqualToString:@"Boy"])
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
                    Cell_One.myscrollView.contentSize=CGSizeMake(Xpostion, 125);
                }
                
                
                
                Xpostion=12;
                Ypostion=16;
                Xwidth=72;
                Yheight=72;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=87;
                Xwidth_label=72;
                Yheight_label=22;
                if (Array_Match.count==0)
                {
                    Cell_One.Label_Noresult.hidden=NO;
                }
                else
                {
                    Cell_One.Label_Noresult.hidden=YES;
                }
                return Cell_One;
                
                
            }
                break;
              
               
            case 2:
                
            {
                
                
//                chattype = EVENT;
//                createdate = "2017-06-16 11:44:33";
//                creatorfbid = 1224819434269672;
//                eventdate =     {
//                    date = "2017-06-18 13:45:22.000000";
//                    timezone = UTC;
//                    "timezone_type" = 3;
//                };
//                eventdateformat = "18th June 2017, 1:45pm";
//                eventdescription = Nznznznnz;
//                eventid = QYLL0;
//                eventtitle = Nznznzn;
//                fname = test;
//                gender = Boy;
//                invitedate = "2017-06-16 11:44:33";
//                location = "M M Mmz";
//                message = Nznznzn;
//                msgdate = "2017-06-16 11:44:33";
//                msgread = self;
                
   
                
                
                Cell_Two2 = (MymeetupsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid111 forIndexPath:indexPath];
                NSURL * url=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"profilepic"];
           
                
                NSString *text;
                if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
                {
                    text =[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"message"];
                }
                else if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"chattype"] isEqualToString:@"EVENT"])
                {
                    text =@"";
                }
                else
                {
                    text=@"Image";
                }
                
                NSString *textfname=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                
                Cell_Two2.Label_Date.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventdateformat"];
                
                
                if (searchString.length==0)
                {
                    
                    Cell_Two2.Label_name.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                    Cell_Two2.Label_chatInfo.text=text;
                    Cell_Two2.Label_chatInfo.textColor=[UIColor lightGrayColor];
                    
                }
                else
                {
                    
                    //commented by uday
                    
                    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
                    NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                    
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                    
                    NSRange range = NSMakeRange(0 ,text.length);
                    NSRange rangefname = NSMakeRange(0 ,textfname.length);
                    
                    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                        
                        NSRange subStringRange = [result rangeAtIndex:0];
                        [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
                    }];
                    
                    if ([FlagSearchBar isEqualToString:@"yes"])
                    {
                        Cell_Two2.Label_chatInfo.attributedText = mutableAttributedString;
                        Cell_Two2.Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        
                        
                        Cell_Two2.Label_name.text=[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"eventtitle"];
                        Cell_Two2.Label_chatInfo.text=text;
                        Cell_Two2.Label_chatInfo.textColor=[UIColor lightGrayColor];
                        
                        FlagSearchBar=@"no";
                        
                    }
                    
                    
                    
                    //                   Cell_Two.Label_chatInfo.attributedText = mutableAttributedString;
                    //                   Cell_Two.Label_name.attributedText=mutableAttributedStringfname;
                    
                    
                }
                
                
                if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqual:[NSNull null ]] || [[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] == nil)
                    
                {
                    [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
                }
                
                else
                    
                {
                    if ([[[Array_Meetups objectAtIndex:indexPath.row]valueForKey:@"gender"] isEqualToString:@"Boy"])
                    {
                        
                        [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultboy.jpg"] options:SDWebImageRefreshCached];
                        
                        
                        
                    }
                    else
                    {
                        [Cell_Two2.Image_proview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"girlpictureframe.png"] options:SDWebImageRefreshCached];
                        
                    }
                }
                
                
                
                
              
                
                return Cell_Two2;
                
            }
                break;
                
                
                
        }
    }
    
     return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    return 4;
    }
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
         return 3;
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        //        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionView.frame.size.height)];
        searchbar.translucent=YES;
        searchbar.delegate=self;
        searchbar.searchBarStyle=UISearchBarStyleMinimal;

        [searchbar setShowsCancelButton:NO animated:YES];
        [self searchBarCancelButtonClicked:searchbar];
        
        
//        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 2)],UITextAttributeTextShadowOffset,nil]forState:UIControlStateNormal];
        
       [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9], NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:16]} forState:UIControlStateNormal];
        

        
        [searchbar setTintColor:[UIColor lightGrayColor]];
//
        [sectionView addSubview:searchbar];
        sectionView.tag=section;
        
    }
  
    if (section==1)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"Friend Requests";
        
        
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(150,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Request.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        [sectionView addSubview:Label2];
       
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }

   
    
    if (section==2)//1
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"New matches";
        
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Match.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        [sectionView addSubview:Label2];
        
        
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }

    if (section==3)//2
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];

        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        Label1.text=@"Messages";
        
        [sectionView addSubview:Label1];
        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(105,6,24,24)];
        Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
        Label2.clipsToBounds=YES;
        Label2.layer.cornerRadius=Label2.frame.size.height/2;
        Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Messages.count];
        Label2.textAlignment=NSTextAlignmentCenter;
        
#pragma mark - message count hidden
        
        Label2.hidden = YES;
        
        [sectionView addSubview:Label2];
        
        sectionView.tag=section;
        
    }
    
    
    return  sectionView;
    
}
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (section==0)
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
            //        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            [sectionView setBackgroundColor:[UIColor whiteColor]];
            searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionView.frame.size.height)];
            searchbar.translucent=YES;
            searchbar.delegate=self;
            searchbar.searchBarStyle=UISearchBarStyleMinimal;
            
            [searchbar setShowsCancelButton:NO animated:YES];
            [self searchBarCancelButtonClicked:searchbar];
            
            
            //        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 2)],UITextAttributeTextShadowOffset,nil]forState:UIControlStateNormal];
            
            [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9], NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:16]} forState:UIControlStateNormal];
            
            
            
            [searchbar setTintColor:[UIColor lightGrayColor]];
            //
            [sectionView addSubview:searchbar];
            sectionView.tag=section;
            
        }
        
        if (section==1)
        {
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
            [sectionView setBackgroundColor:[UIColor whiteColor]]; //[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
            Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            Label1.text=@"New Invites";
            
            UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
            Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
            Label2.clipsToBounds=YES;
            Label2.layer.cornerRadius=Label2.frame.size.height/2;
            Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Match.count];
            Label2.textAlignment=NSTextAlignmentCenter;
            [sectionView addSubview:Label2];
            
            
            [sectionView addSubview:Label1];
            sectionView.tag=section;
            
        }
        
        if (section==2)
        {
            
            sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
            [sectionView setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
            
            
            UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
            Label1.backgroundColor=[UIColor clearColor];
            Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            Label1.text=@"My Meetups";
            
            [sectionView addSubview:Label1];
            UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(105,6,24,24)];
            Label2.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];//[UIColor lightGrayColor];
            Label2.clipsToBounds=YES;
            Label2.layer.cornerRadius=Label2.frame.size.height/2;
            Label2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Messages.count];
            Label2.textAlignment=NSTextAlignmentCenter;
            
#pragma mark - message count hidden
            
            Label2.hidden = YES;
            
            [sectionView addSubview:Label2];
            
            sectionView.tag=section;
            
        }
        
        return  sectionView;
        
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    if (section==0)
    {
        return 44;
    }

    if (section==1)
    {
        if (Array_Request.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
    }

    

    
    
    
    if (section==2)//1
    {
        if (Array_Match.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
    }
    if (section==3)//2
    {
        if (Array_Messages.count==0)
        {
            return 0;
        }
        else
        {
            return 36;
        }
      
    }
    }
     if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
        if (section==0)
        {
            return 44;
        }
        
        if (section==1)
        {
//            if (Array_Match.count==0)
//            {
                return 0;
//            }
//            else
//            {
//                return 36;
//            }
        }
        
        
        if (section==2)
        {
            if (Array_Meetups.count==0)
            {
                return 0;
            }
            else
            {
                return 36;
            }
            
        }
    }
    
    
    return 0;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    [self.view endEditing:YES];

    transparancyTuchView.hidden=YES;
  
    
    if (indexPath.section==3)//2
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
        if (indexPath.section==0)
        {
//            set.AllDataArray=[Array_MatchMessages objectAtIndex:indexPath.row];
        }
        if (indexPath.section==3)
        {
            NSDictionary * dic=[Array_Messages objectAtIndex:indexPath.row];
            NSMutableArray * array_new=[[NSMutableArray alloc]init];
            [array_new addObject:dic];
            set.AllDataArray=array_new;
        }

        [self.navigationController pushViewController:set animated:YES];
    }
    }
     if ([Str_ChangeScreen isEqualToString:@"playdate"])
     {
         [self.view endEditing:YES];
         
         transparancyTuchView.hidden=YES;
         
         
         if (indexPath.section==2)//2
         {
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             
             FriendCahtingViewControlleroneViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewControlleroneViewController"];
             if (indexPath.section==0)
             {
               
             }
             if (indexPath.section==2)
             {
                 NSDictionary * dic=[Array_Meetups objectAtIndex:indexPath.row];
                 NSMutableArray * array_new=[[NSMutableArray alloc]init];
                 [array_new addObject:dic];
                 set.AllDataArray=array_new;
             }
             
             [self.navigationController pushViewController:set animated:YES];
         }
     }
}


-(void)ImageTapped_profile1:(UITapGestureRecognizer *)sender
{
    
    
    [self.view endEditing:YES];
    transparancyTuchView.hidden=YES;
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendRequestViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendRequestViewController"];
    
    NSDictionary * dic=[Array_Request objectAtIndex:(long)imageView.tag];
    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    [array_new addObject:dic];
    set.Array_UserInfo=array_new;
    
    [self.navigationController pushViewController:set animated:YES];
}


-(void)ImageTapped_profile:(UITapGestureRecognizer *)sender
{
    
    
    [self.view endEditing:YES];
      transparancyTuchView.hidden=YES;
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FriendCahtingViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FriendCahtingViewController"];
    
    NSDictionary * dic=[Array_Match objectAtIndex:(long)imageView.tag];
    NSMutableArray * array_new=[[NSMutableArray alloc]init];
    [array_new addObject:dic];
    set.AllDataArray=array_new;
    
    [self.navigationController pushViewController:set animated:YES];
}
-(void)communication_Eventsmeetups
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
    
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"events"];;
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
             Array_Meetups=[[NSMutableArray alloc]init];
            Array_Meetups1=[[NSArray alloc]init];

                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        array_createEvent=[objSBJsonParser objectWithData:data];
            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 ;
                                                 
            ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                    NSLog(@"array_createEvent %@",array_createEvent);
                                                 
                NSLog(@"array_createEvent ResultString %@",ResultString);
                                    if ([ResultString isEqualToString:@"inserterror"])
                                                 {
                              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The server encountered an error and your Play:Date could not be created. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                              UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                     [alertController addAction:actionOk];
                            [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                            if (array_createEvent.count !=0)
                            {
                                for (int i=0; i<array_createEvent.count; i++)
                                {
                                if (Array_Meetups.count==0)
                                {
                            [Array_Meetups addObject:[array_createEvent objectAtIndex:i]];
                                }
                                else
                            {
                                                         
                                    for (NSInteger J=Array_Meetups.count-1; J<Array_Meetups.count; J++)
                            {
                        NSString * fbMatch=[[array_createEvent objectAtIndex:i]valueForKey:@"eventid"];
                            NSString * fbMatch2=[[Array_Meetups objectAtIndex:J]valueForKey:@"eventid"];
                                                             
                                    if (![fbMatch2 isEqualToString:fbMatch])
                                                             {
                                                                 
                            [Array_Meetups addObject:[array_createEvent objectAtIndex:i]];
                                                                 break;
                                                             }
                                                             
                                                         }
                                                     }
                                                 }
                                
                                  Array_Meetups1=[Array_Meetups mutableCopy];
                            }
                                             }
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                
                                                 
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



-(void)NewMatchServerComm
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
        
        NSURL *url;
        
        NSString *  urlStrLivecount=[urlplist valueForKey:@"friends"];
        
 //       NSString *  urlStrLivecount=[urlplist valueForKey:@"friends-new"];
        
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        [request setHTTPBody: requestData];
        
        Connection_Match = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Match)
            {
                webData_Match =[[NSMutableData alloc]init];
                
                
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
    
    if(connection==Connection_Match)
    {
        [webData_Match setLength:0];
        
        
    }
    
    
    if(connection==Connection_Messages)
    {
        [webData_Messages setLength:0];
        
        
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Match)
    {
        [webData_Match appendData:data];
    }
    if(connection==Connection_Messages)
    {
        [webData_Messages appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //  [indicatorView stopAnimating];
    
    if (connection==Connection_Match)
    {
        Array_Request = [[NSMutableArray alloc]init];
        Array_RequestMessages = [[NSMutableArray alloc]init];
        
        Array_MatchMessages=[[NSMutableArray alloc]init];
        Array_Match=[[NSMutableArray alloc]init];
        Array_Messages=[[NSMutableArray alloc]init];
        Array_Messages22=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_MatchMessages=[objSBJsonParser objectWithData:webData_Match];
        Array_RequestMessages = [objSBJsonParser objectWithData:webData_Match];
        NSMutableDictionary * dicone=[[NSMutableDictionary alloc]init];
        dicone=[objSBJsonParser objectWithData:webData_Match];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Match encoding:NSUTF8StringEncoding];
        //  Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_LodingPro options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"_Array_Match %@",Array_MatchMessages);
        NSLog(@"_Array_Request %@",Array_RequestMessages);
      
        NSLog(@"ResultString_Array_Match %@",ResultString);
        if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Fid Id not exist" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        if (Array_MatchMessages.count !=0)
        {
            
            
            
            NSError *error;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText1.plist"];
            
          
            
            
                    [dicone writeToFile:path atomically:YES];
            
            
            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            
            
            
            
for (int i=0; i<Array_MatchMessages.count; i++)
    {
  if ([[[Array_MatchMessages objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
  {
    
                    if (Array_Match.count==0)
                    {
                        [Array_Match addObject:[Array_MatchMessages objectAtIndex:i]];
                    }
                    else
                    {
        
                        for (NSInteger k=Array_Match.count-1; k<Array_Match.count; k++)
                        {
                            NSString * fbMatch11=[[Array_MatchMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                            NSString * fbMatch22=[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"];
                            
                            if (![fbMatch22 isEqualToString:fbMatch11])
                            {
                                
                                [Array_Match addObject:[Array_MatchMessages objectAtIndex:i]];
                                break;
                            }
                            
                        }
                }
    }
        
        
        
        else if ([[[Array_MatchMessages objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
        {
            if (Array_Request.count==0)
            {
                [Array_Request addObject:[Array_RequestMessages objectAtIndex:i]];
            }
            else
            {
                
                for (NSInteger k=Array_Request.count-1; k<Array_Request.count; k++)
                {
                    NSString * fbMatch11=[[Array_RequestMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                    NSString * fbMatch22=[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"];
                    
                    if (![fbMatch22 isEqualToString:fbMatch11])
                    {
                        
                        [Array_Request addObject:[Array_RequestMessages objectAtIndex:i]];
                        break;
                    }
                    
                }
            }

            
            
        }
        
   else
        {
            if (Array_Messages.count==0)
                {
                        [Array_Messages addObject:[Array_MatchMessages objectAtIndex:i]];
                }
                else
                {
                
                  for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                    NSString * fbMatch=[[Array_MatchMessages objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                            
                   if (![fbMatch2 isEqualToString:fbMatch])
                   {
                   
                      [Array_Messages addObject:[Array_MatchMessages objectAtIndex:i]];
                       break;
                    }
                        
                        }
                    }
            
                }
            }
            
           
       SearchCrickArray=[Array_MatchMessages mutableCopy];
          Array_Messages1=[Array_Messages mutableCopy];
            Array_Match1=[Array_Match mutableCopy];
            Array_Request1 = [Array_Request mutableCopy];
            [Table_Friend reloadData];
            
        }
        
}
    
    
    if (connection==Connection_Messages)
    {
        
        Array_Messages=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Messages=[objSBJsonParser objectWithData:webData_Messages];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Messages encoding:NSUTF8StringEncoding];
        // Array_sinupFb=[NSJSONSerialization JSONObjectWithData:webData_Reg options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_Messages %@",Array_Messages);
        NSLog(@"Array_Messages %@",[[Array_Messages objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString_Array_Messages %@",ResultString);
        
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

        }
        else if ([ResultString isEqualToString:@"updateerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in updating your account. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in updating your account. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
            
        }
        else if ([ResultString isEqualToString:@"error"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else if ([ResultString isEqualToString:@"selecterror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        else if ((Array_Messages.count !=0))
        {
            
              }
    
    
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   

     transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
        [HomechatTimer invalidate];
        HomechatTimer=nil;
    }
    
    
    if ([Str_ChangeScreen isEqualToString:@"playdate"])
    {
 
    [HomechatTimerplaydate invalidate];
    HomechatTimerplaydate=nil;
    }

    FlagSearchBar=@"yes";
    transparancyTuchView.hidden=NO;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=YES;
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
    FlagSearchBar=@"yes";
    
    if ([Str_ChangeScreen isEqualToString:@"chats"])
    {
    
    if (searchText.length==0)
    {
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_Match removeAllObjects];
        [Array_Request removeAllObjects];
        [Array_Messages removeAllObjects];
        [Array_Messages22 removeAllObjects];
        [Array_Messages addObjectsFromArray:Array_Messages1];
        [Array_Match addObjectsFromArray:Array_Match1];
        [Array_Request addObjectsFromArray:Array_Request1];
        [Array_Messages22 addObjectsFromArray:SearchCrickArray];

        
    }
    else
        
    {
      transparancyTuchView.hidden=YES;
     
        [Array_Messages removeAllObjects];
        [Array_Match removeAllObjects];
        [Array_Request removeAllObjects];
        [Array_Messages22 removeAllObjects];
        
        for (NSDictionary *book in SearchCrickArray)
        {
            NSString * string=[book objectForKey:@"fname"];
            NSString * stringcom=[book objectForKey:@"message"];
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange rcompetition=[stringcom rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound || rcompetition.location !=NSNotFound)
            {
                searchString=searchText;
                [Array_Messages22 addObject:book];
                
            }
            
        }
        
        
       
        for (int i=0; i<Array_Messages22.count; i++)
        {
            if ([[[Array_Messages22 objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"match"])
            {
                
                if (Array_Match.count==0)
                {
                    [Array_Match addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    for (int k=0; k<Array_Match.count; k++)
                    {
                        if (![[[Array_Match objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"]])
                        {
                            
                            [Array_Match addObject:[Array_Messages22 objectAtIndex:i]];
                            
                        }
                        
                        
                    }
                    
                    
                }
            }
            
          else if ([[[Array_Messages22 objectAtIndex:i]valueForKey:@"type"]isEqualToString:@"request"])
            {
                
                if (Array_Request.count==0)
                {
                    [Array_Request addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    for (int k=0; k<Array_Request.count; k++)
                    {
                        if (![[[Array_Request objectAtIndex:k]valueForKey:@"matchedfbid"] isEqualToString:[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"]])
                        {
                            
                            [Array_Request addObject:[Array_Messages22 objectAtIndex:i]];
                            
                        }
                        
                        
                    }
                    
                    
                }
            }
            
            else
            {
                if (Array_Messages.count==0)
                {
                    [Array_Messages addObject:[Array_Messages22 objectAtIndex:i]];
                }
                else
                {
                    
                    for (NSInteger J=Array_Messages.count-1; J<Array_Messages.count; J++)
                    {
                        NSString * fbMatch=[[Array_Messages22 objectAtIndex:i]valueForKey:@"matchedfbid"];
                        NSString * fbMatch2=[[Array_Messages objectAtIndex:J]valueForKey:@"matchedfbid"];
                        
                        if (![fbMatch2 isEqualToString:fbMatch])
                        {
                            
                            [Array_Messages addObject:[Array_Messages22 objectAtIndex:i]];
                            break;
                        }
                        
                    }
                }
                
            }
        }
        

        
        
 
    }

    }
    

if ([Str_ChangeScreen isEqualToString:@"playdate"])
{
    
    if (searchText.length==0)
    {
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_Meetups removeAllObjects];
       
        [Array_Meetups addObjectsFromArray:Array_Meetups1];
       
        
        
    }
    else
        
    {
        transparancyTuchView.hidden=YES;
        
        [Array_Meetups removeAllObjects];
       
        
        for (NSDictionary *book in Array_Meetups1)
        {
            NSString * string=[book objectForKey:@"eventtitle"];
            NSString * stringcom=[book objectForKey:@"message"];
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange rcompetition=[stringcom rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound || rcompetition.location !=NSNotFound)
            {
                searchString=searchText;
                [Array_Meetups addObject:book];
                
            }
            
        }
        
        
        
    }
    
}


     [searchBar setShowsCancelButton:YES animated:YES];
    
    [Table_Friend reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    
    transparancyTuchView.hidden=YES;
  [self.view endEditing:YES];
    searchBar.text=@"";
     [searchBar setShowsCancelButton:NO animated:YES];
    if ([FlagSearchBar isEqualToString:@"yes"])
    {
            [Array_Match removeAllObjects];
            [Array_Request removeAllObjects];
            [Array_Messages removeAllObjects];
            [Array_Messages22 removeAllObjects];
            [Array_Messages addObjectsFromArray:Array_Messages1];
            [Array_Match addObjectsFromArray:Array_Match1];
            [Array_Request addObjectsFromArray:Array_Request1];
            [Array_Messages22 addObjectsFromArray:SearchCrickArray];
            [Table_Friend reloadData];
          FlagSearchBar=@"no";
        
        [self homeTimer];
    }

}
-(void)updateLabel
{
    [self NewMatchServerComm];
}
- (IBAction)Button_Plus:(id)sender
{
    if ([sender tag]==1)
    {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Facebook friends",@"Invite contacts",nil];
        popup.tag = 777;
        [popup showInView:self.view];
    }
    if ([sender tag]==2)
    {
        NSLog(@"button oplus tag is ==2");
        [defaults setObject:@"newedit" forKey:@"checkview"];
        [defaults synchronize];
        NavigationNewPlayDateViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationNewPlayDateViewController"];
        [self.navigationController presentModalViewController:tvc animated:YES];
    }
   
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)actionSheet.tag == 777)
    {
        NSLog(@"INDEXAcrtionShhet==%ld",(long)buttonIndex);
        
        if (buttonIndex== 0)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
            [self.navigationController pushViewController:set animated:YES];
        }
        else  if (buttonIndex== 1)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
            [self.navigationController pushViewController:set animated:YES];
        }
    }
}
- (IBAction)Button_Chatscreen:(id)sender
{
    
   
    [HomechatTimerplaydate invalidate];
    HomechatTimerplaydate=nil;
    
      Button_Plustap.tag=1;
       Str_ChangeScreen=@"chats";
     Label_HeadTop.text=@"Friends";
    
    
    
    
    [Button_chats setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    [Button_playdates setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    borderBottom_chat.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-2.5, Button_chats.frame.size.width, 2.5);
    [Button_chats.layer addSublayer:borderBottom_chat];
    
        borderBottom_playdate.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-1, Button_playdates.frame.size.width, 1);
    [Button_playdates.layer addSublayer:borderBottom_playdate];
    
      [self NewMatchServerComm];
    [Table_Friend reloadData];
}
- (IBAction)Button_PlayDatescreen:(id)sender
{
    
    [HomechatTimer invalidate];
    HomechatTimer=nil;
    
      Button_Plustap.tag=2;
       Str_ChangeScreen=@"playdate";
     Label_HeadTop.text=@"Create a Play:Date";
   [Button_chats setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [Button_playdates setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
    borderBottom_playdate.backgroundColor =[UIColor colorWithRed:255/255.0 green:242/255.0 blue:82/255.0 alpha:1].CGColor;
    borderBottom_playdate.frame = CGRectMake(0, Button_playdates.frame.size.height-2.5, Button_playdates.frame.size.width, 2.5);
    [Button_playdates.layer addSublayer:borderBottom_playdate];
    
    
    
    borderBottom_chat.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_chat.frame = CGRectMake(0, Button_chats.frame.size.height-1, Button_chats.frame.size.width, 1);
    [Button_chats.layer addSublayer:borderBottom_chat];
    [Table_Friend reloadData];
    [self communication_Eventsmeetups];
}

@end
