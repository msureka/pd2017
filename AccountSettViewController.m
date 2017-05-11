//
//  AccountSettViewController.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 8/19/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "AccountSettViewController.h"
#import "AccOneTableViewCell.h"
#import "AccTwoTableViewCell.h"
#import "AccThreeTableViewCell.h"
#import "LoginSignupViewController.h"
#import "NameView1ViewController.h"
#import "DOBView2ViewController.h"
#import "GenderView3ViewController.h"
#import "LocationView4ViewController.h"
#import "LanguagesView5ViewController.h"
#import "AboutView6ViewController.h"
#import "SettingGenderViewController.h"
#import "WhereViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "MainMenuNavigationController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "HowOldViewController.h"
#import "SinupStepTwoViewController.h"
#import "TabbarMainProViewController.h"
#import <MessageUI/MessageUI.h>
@interface AccountSettViewController ()<UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    NSArray *Array_Title1,*Array_Title2,*Array_Title3,*Array_Title4,*Array_Gender2,*Array_Gender1, *Array_Restore;
    UIView *sectionView;
    NSUserDefaults *defaults;
    
 
    NSDictionary *urlplist;
    NSURLConnection *Connection_Delete,*Connection_ChangeproInfo, *Connection_Restoreprofile;
    NSMutableData *webData_Delete,*webData_ChangeproInfo,*webData_Restoreprofile;
    NSMutableArray *Array_Delete,*Array_ChangeproInfo,*Array_Restoreprofile;
   
    NSString *EnglishStr,*ArabicStr;
    MFMailComposeViewController *mailComposer;
}

@end

@implementation AccountSettViewController
@synthesize onecell,Twocell2,Threecell3,Fourcell4,HeadTopView,Fivecell5;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    Array_Title1=[[NSArray alloc]initWithObjects:@"Make friends with?",@"How old?",@"Where?", nil];
    
 
    Array_Title2=[[NSArray alloc]initWithObjects:@"Name",@"Gender",@"Birthdate",@"I speak",@"Description",@"Profile cards",nil];
    
    Array_Title3=[[NSArray alloc]initWithObjects:@"Matches",@"Messages",nil];
    
    Array_Title4=[[NSArray alloc]initWithObjects:@"Invite a friend",@"Terms of Service", @"Privacy Policy",@"Logout",@"Delete my account",nil];
    
    Array_Restore=[[NSArray alloc]initWithObjects:@"Restore all discarded profiles",nil];
    
    
    UIColor *bgRefreshColor =[UIColor clearColor];  //[UIColor colorWithRed:48/255.0 green:172/255.0 blue:255/255.0 alpha:1];
    defaults=[[NSUserDefaults alloc]init];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(PulltoRefershtable) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = TableView_Setting.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [TableView_Setting insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    [TableView_Setting reloadData];
    [TableView_Setting addSubview:self.refreshControl];
}
-(void)viewWillAppear:(BOOL)animated
{
       [TableView_Setting reloadData];
    
    
}
-(void)PulltoRefershtable
{
    [self.view endEditing:YES];
    ;
    //[self clientServerCommunicationCreate];
    //  [self clientServerCommunicatioInvite];
    [TableView_Setting reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0)
    {
        return Array_Title1.count;
    }
    if (section==1)
    {
        return 0;//Array_Restore.count;//restore hidden
    }
    
    if (section==2)//1
    {
        return Array_Title2.count;;
    }
    if (section==3)//2
    {
        
        return Array_Title3.count;;
    }
    if (section==4)//3
    {
        
        return Array_Title4.count;;
    }
    
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
            return 55;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"OneCell";
    static NSString *cellId2=@"TwoCell";
    static NSString *cellId3=@"ThreeCell";
    static NSString *cellId4=@"FourCell";
    static NSString *cellId5=@"FiveCell";
    
    
        switch (indexPath.section)
        {
                
                
            case 0:
            {



                onecell = (AccOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                onecell.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                onecell.layer.borderWidth=1.0f;
                onecell.LabelVal.text=[Array_Title1 objectAtIndex:indexPath.row];
                NSLog(@"Values===%@",[defaults valueForKey:@"makefriendswith"]);
                if (indexPath.row==0)
                {
                    if ([defaults valueForKey:@"makefriendswith"] !=nil)
                    {
                        
                        if ([[defaults valueForKey:@"makefriendswith"] isEqualToString:@"BOY"])
                        {
                            
                          ;  
                            
                             onecell.LabelVal2.text=@"Boys \U0001F466";
                        }
                      else if ([[defaults valueForKey:@"makefriendswith"] isEqualToString:@"GIRL"])
                      {
                            onecell.LabelVal2.text=@"Girls \U0001F467";
                        }
                      else if ([[defaults valueForKey:@"makefriendswith"] isEqualToString:@"BOYSANDGIRLS"])
                      {
                            onecell.LabelVal2.text=@"Boys & Girls \U0001F466\U0001F467";
                        }
//                       onecell.LabelVal2.text=[NSString stringWithFormat:@"%@",[Array_Gender2 objectAtIndex:indexPath.row]];
                        
                    }
                }
                if (indexPath.row==1)
                {
                    if ([defaults valueForKey:@"agegroup"] !=nil)
                    {
                        
                        if ([[defaults valueForKey:@"agegroup"] isEqualToString:@"2"]) {
                            onecell.LabelVal2.text=@"All ages";
                        }
                        else if ([[defaults valueForKey:@"agegroup"] isEqualToString:@"1"]) {
                            onecell.LabelVal2.text=@"2 years older/younger to me";
                        }
                        else if ([[defaults valueForKey:@"agegroup"] isEqualToString:@"0"])
                        {
                            onecell.LabelVal2.text=@"Same as mine!";
                        }
                        
                       // onecell.LabelVal2.text=[NSString stringWithFormat:@"%@",[defaults valueForKey:@"agegroup"]];
                        
                    }

                }
                if (indexPath.row==2)
                {
                    if ([defaults valueForKey:@"distance"] !=nil)
                    {
                        if ([[defaults valueForKey:@"distance"] isEqualToString:@"CITY"]) {
                            onecell.LabelVal2.text=@"My city only";
                        }
                        else if ([[defaults valueForKey:@"distance"] isEqualToString:@"COUNTRY"]) {
                            onecell.LabelVal2.text=@"My country";
                        }
                        else if ([[defaults valueForKey:@"distance"] isEqualToString:@"GLOBAL"])
                        {
                            onecell.LabelVal2.text=@"Anywhere in the world!";
                        }
 
                        
                        
                        //onecell.LabelVal2.text=[NSString stringWithFormat:@"%@",[defaults valueForKey:@"distance"]];
                        
                    }

                }
                
                return onecell;
                
                
            }
                break;
                
 //----------------------------------------------restore case--------------------------------------------------------
                
            case 1:
                
            {
                
                
            Fivecell5 = (AccFiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId5 forIndexPath:indexPath];
                
                
                
                Fivecell5.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Fivecell5.layer.borderWidth=1.0f;
                
                Fivecell5.Label_Restore.text=[Array_Restore objectAtIndex:indexPath.row];
                
                
                return Fivecell5;
                
            }
                
                break;
                
                
                
             
                
            case 2://1
                
            {
                Twocell2 = (AccTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                Twocell2.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Twocell2.layer.borderWidth=1.0f;
                
                Twocell2.LabelVal.text=[Array_Title2 objectAtIndex:indexPath.row];
                if (indexPath.row==0)
                {
                    if ([defaults valueForKey:@"fname"] !=nil)
                    {
                         Twocell2.LabelVal2.text=[NSString stringWithFormat:@"%@",[defaults valueForKey:@"fname"]];
                        
                    }
                   
                }
                if (indexPath.row==1)
                {
                    
                   
                        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
                        {
                             Twocell2.LabelVal2.text=[NSString stringWithFormat:@"%@%@",[defaults valueForKey:@"gender"],@" \U0001F466"];
                        }
                        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Girl"])
                        {
                            Twocell2.LabelVal2.text=[NSString stringWithFormat:@"%@%@",[defaults valueForKey:@"gender"],@" \U0001F467"];
                            
                            
                        }

//                       Twocell2.LabelVal2.text=[defaults valueForKey:@"gender"];
                    
                }
                if (indexPath.row==2)
                {
                    if ([defaults valueForKey:@"DOB"] !=nil)
                    {
                        
                        
                        NSString *defDate = [defaults valueForKey:@"DOB"];
                        
                        NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
                        [showdf setDateFormat:@"yyyy-MM-dd"];
                        NSDate *date = [showdf dateFromString:defDate];
                        
                        [showdf setDateFormat:@"dd-MM-yyyy"];
                        NSString *newDateString = [showdf stringFromDate:date];
                        
                        
                        NSLog(@"def date= %@",defDate);
                        NSLog(@"label Show = %@",newDateString) ;
                        
                        
                       Twocell2.LabelVal2.text=newDateString;
                        
                        
                        
                      // Twocell2.LabelVal2.text=[defaults valueForKey:@"DOB"];
                    }
                }
                if (indexPath.row==3)
                {

                    NSLog(@"Languge defalts==%@",[defaults valueForKey:@"language"]);
                    NSString * languge=[defaults valueForKey:@"language"];
                    if (languge !=nil)
                    {
                        Twocell2.LabelVal2.text=[defaults valueForKey:@"language"];
                    }
                    else
                    {
                        Twocell2.LabelVal2.text=@"";
                    }
      
                    
                }
                if (indexPath.row==4)
                {
                    Twocell2.LabelVal2.text=@"edit here";
                }
                if (indexPath.row==5)
                {
                   Twocell2.LabelVal2.text=@"edit answers";
                }
                return Twocell2;
                
            }
                break;
                
                
                
                
            case 3://2
                
            {
                Fourcell4 = (AccFourTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId4 forIndexPath:indexPath];
                Fourcell4.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Fourcell4.layer.borderWidth=1.0f;
                
                
                Fourcell4.LabelVal.text=[Array_Title3 objectAtIndex:indexPath.row];
                Fourcell4.switchOutlet.tag=indexPath.row;
               [Fourcell4.switchOutlet addTarget: self action: @selector(switchOutletAction:) forControlEvents:UIControlEventValueChanged];
                if (indexPath.row==0)
                {
                
                if ([[defaults valueForKey:@"Switch1"] isEqualToString:@"OFF"])
                {
                    [Fourcell4.switchOutlet setOn:NO animated:YES];
                }
                else
                {
                    [Fourcell4.switchOutlet setOn:YES animated:YES];
                }
                }
                if (indexPath.row==1)
                {
                if ([[defaults valueForKey:@"Switch2"] isEqualToString:@"OFF"])
                {
                   [Fourcell4.switchOutlet setOn:NO animated:YES];
                }
                else
                {
                 
                    [Fourcell4.switchOutlet setOn:YES animated:YES];
                }
                }
                
                return Fourcell4;
                
            }
                break;
                
            case 4://3
                
            {
                
                
                Threecell3 = (AccThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
                
                
              
                Threecell3.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                Threecell3.layer.borderWidth=1.0f;
                if (indexPath.row==4)
                {
                    Threecell3.LabelVal.textColor=[UIColor redColor];
                }
                else
                {
                    Threecell3.LabelVal.textColor=[UIColor blackColor];
                }

                Threecell3.LabelVal.text=[Array_Title4 objectAtIndex:indexPath.row];
                
                
                return Threecell3;
                
            }
                
                break;
        }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 6;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        Label1.text=@"FRIENDS DISCOVERY";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,-36)];//36
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        Label1.text=@"SWIPE SETTINGS";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }

    
    
    if (section==2)//1
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        Label1.text=@"MY ACCOUNT";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    if (section==3)//2
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        Label1.text=@"PUSH NOTIFICATION";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    
    if (section==4)//3
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        Label1.text=@"ACTION";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    if (section==5)//4
    {
        
        NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        
        
        NSString *verBuild = [NSString stringWithFormat:@"%@.%@",appVersionString,appBuildString];

        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,60)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, sectionView.frame.size.height)];
        
        
         Label1.font=[UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textAlignment=NSTextAlignmentCenter;
        
        NSString *labelstr = [NSString stringWithFormat:@"Play:Date v%@ \nfor the love of our children",verBuild];
        Label1.text= labelstr;
       Label1.lineBreakMode=UILineBreakModeWordWrap;
        Label1.numberOfLines=2.0f;
          Label1.textColor=[UIColor lightGrayColor];
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }

    
    return  sectionView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 5) {  //4
         return 60;
    }
    
    //restore hide
    else if (section == 1)
    {
        return 0;
        
    }
    else
    {
         return 36;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        if (indexPath.row==0)
        {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
  SettingGenderViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SettingGenderViewController"];
        
        [self.navigationController pushViewController:set animated:YES];
        }
        
        if (indexPath.row==1)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            HowOldViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"HowOldViewController"];
            
            [self.navigationController pushViewController:set animated:YES];

            
        }
        
        if (indexPath.row==2)
        {
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            WhereViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"WhereViewController"];
            
            [self.navigationController pushViewController:set animated:YES];
            
            
        }
        
    }
    
//-----------------------------------------------RESTORE--------------------------------------------------
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Reset left swipes" message:@"This will restore all the profiles you left swiped and add them back into your discover section. Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *noAction =[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                      
                                      {
                                          
                                          NSLog(@"No button Pressed");
                                          
                                      }];
            [alert addAction:noAction];
            
            UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            NSLog(@"Yes button Pressed");
                                            
                                            [self restoreProfileConnection];
                                        }];
            
            [alert addAction:yesAction];
            
            
            
            [self presentViewController:alert animated:YES completion:nil];
            

            
        }
    }
    
    
    
    
    if (indexPath.section == 2)//1
    {
        if (indexPath.row==0)
        {
            
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
    NameView1ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"NameView1ViewController"];
            
        [self.navigationController pushViewController:set animated:YES];
  
        }
        if (indexPath.row==1)
        {
            
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
         GenderView3ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"GenderView3ViewController"];
            
        [self.navigationController pushViewController:set animated:YES];
                
        }
        if (indexPath.row==2)
        {
            
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
    DOBView2ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DOBView2ViewController"];
            
        [self.navigationController pushViewController:set animated:YES];
      
        }
        if (indexPath.row==3)
        {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
        LanguagesView5ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"LanguagesView5ViewController"];
            
    [self.navigationController pushViewController:set animated:YES];
         
        }
        if (indexPath.row==4)
        {
            
UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
AboutView6ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"AboutView6ViewController"];
            
    [self.navigationController pushViewController:set animated:YES];
                    
        }

        
        if (indexPath.row==5)
        {
            [defaults setObject:@"yes" forKey:@"settingpage"];
            [defaults synchronize];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            SinupStepTwoViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepTwoViewController"];
//            set.SelctedViewButton=NextViewKey;
            [self.navigationController pushViewController:set animated:YES];
        }
        
    }

    
    if (indexPath.section == 3)//2
    {
        
    }
    
    if (indexPath.section == 4)//3
    {
        
        
        if (indexPath.row==0)
        {
            NSLog(@"mail");
            
            [self sendEmail];
            
        }
        
        if (indexPath.row==1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/terms.html"]];
             NSLog(@"terms.html");
            
        }
        
        if (indexPath.row==2)
        {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://play-date.ae/privacy.html"]];
            NSLog(@"privacy.html");
        }
        
        if (indexPath.row==3)
        {
           [self LogoutAccount];
        }
        
        if (indexPath.row==4)
        {
          
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Confirm" message:@"Are you sure you want to delete your account?" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *noAction =[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                      
                                      {
                                          
                                          NSLog(@"No button Pressed");
                                          
                                      }];
            [alert addAction:noAction];
            
            UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            NSLog(@"Yes button Pressed");
                                            
                                            [self DeleteClinetServerComm];
                                            
                                        }];
            
            [alert addAction:yesAction];
            
            
            
            [self presentViewController:alert animated:YES completion:nil];

            
        }
    }
    

}

-(void)sendEmail
{
    
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"Mail services are not available");
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please configure your mailbox in order to invite a friend." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        return;
    }
    else
    {
    
    
    
    MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
    mailCont.mailComposeDelegate = self;
    
    [mailCont setSubject:@"Download Play:Date"];
    [mailCont setMessageBody:@"Hey, \n\n Play:Date is a great app to find friends for your children. I have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone! \n\n Thanks!" isHTML:NO];
    
    [self presentViewController:mailCont animated:YES completion:nil];
        
        
    }
 
}



#pragma mark - mail compose delegate
//-(void)mailComposeController:(MFMailComposeViewController *)controller
//         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{
//    if (result) {
//        NSLog(@"Result : %d",result);
//    }
//    if (error) {
//        NSLog(@"Error : %@",error);
//    }
//    [self dismissModalViewControllerAnimated:YES];
//    
//}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0)
//    {
//      
//    }
//    if (buttonIndex==1)
//    {
//        [self DeleteClinetServerComm];
//    }
//}

-(void)DeleteClinetServerComm
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {

        
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"deleteaccount"];
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
        
        Connection_Delete = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Delete)
            {
                webData_Delete =[[NSMutableData alloc]init];
                
                
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
    
    if(connection==Connection_Delete)
    {
        [webData_Delete setLength:0];
        
        
    }
    
    
    if(connection==Connection_ChangeproInfo)
    {
        [webData_ChangeproInfo setLength:0];
        
        
    }
    
    if(connection==Connection_Restoreprofile)
    {
        [webData_Restoreprofile setLength:0];
        
        
    }

    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Delete)
    {
        [webData_Delete appendData:data];
    }
    if(connection==Connection_ChangeproInfo)
    {
        [webData_ChangeproInfo appendData:data];
    }
    
    if(connection==Connection_Restoreprofile)
    {
        [webData_Restoreprofile appendData:data];
    }

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //  [indicatorView stopAnimating];
    
    if (connection==Connection_Delete)
    {
        
        Array_Delete=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Delete=[objSBJsonParser objectWithData:webData_Delete];
        NSString * ResultString=[[NSString alloc]initWithData:webData_Delete encoding:NSUTF8StringEncoding];
        //  Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_LodingPro options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"cc %@",Array_Delete);
        NSLog(@"registration_status %@",[[Array_Delete objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"error"])
        {

            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        
        if ([ResultString isEqualToString:@"deleted"])
        {
            [defaults setObject:@"no" forKey:@"Loginplay"];
            [defaults synchronize];
            
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [FBSDKProfile setCurrentProfile:nil];
            
            
            
            NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            NSLog(@"%@",NSHomeDirectory());
            
            NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
         
             NSString *path1 = [documnetPath1 stringByAppendingPathComponent:@"ChatText1.plist"];
             [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
             [[NSFileManager defaultManager] removeItemAtPath:path1 error:NULL];

            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainMenuNavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainMenuNavigationController"];
            [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];

            
        }
//        if ([ResultString isEqualToString:@"selecterror"])
        
        else
            
        {
            [defaults setObject:@"no" forKey:@"Loginplay"];
            [defaults synchronize];
            
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [FBSDKProfile setCurrentProfile:nil];
            
            NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            NSLog(@"%@",NSHomeDirectory());
            
            
            NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
            NSString *path1 = [documnetPath1 stringByAppendingPathComponent:@"ChatText1.plist"];
            [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
            [[NSFileManager defaultManager] removeItemAtPath:path1 error:NULL];
            
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainMenuNavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainMenuNavigationController"];
            [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
            
            
        }
    }
    
    
    if (connection==Connection_ChangeproInfo)
    {
        
        Array_ChangeproInfo=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_ChangeproInfo=[objSBJsonParser objectWithData:webData_ChangeproInfo];
        NSString * ResultString=[[NSString alloc]initWithData:webData_ChangeproInfo encoding:NSUTF8StringEncoding];
       // Array_sinupFb=[NSJSONSerialization JSONObjectWithData:webData_Reg options:kNilOptions error:nil];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_ChangeproInfo %@",Array_ChangeproInfo);
        NSLog(@"Array_ChangeproInfo %@",[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"registration_status"]);
        NSLog(@"ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"nullerror"])
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
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in updating your account. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else if ([ResultString isEqualToString:@"error"])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your Facebook Account Id seems to be absent. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
              else if ([ResultString isEqualToString:@"selecterror"])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Facebook Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
              else if ([ResultString isEqualToString:@"nofbid"])
              {
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us at support@play-date.ae" preferredStyle:UIAlertControllerStyleAlert];
                  
                  UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:nil];
                  [alertController addAction:actionOk];
                  [self presentViewController:alertController animated:YES completion:nil];
                  
              }
        
        
        else if ((Array_ChangeproInfo.count !=0))
        {
            // [self performSegueWithIdentifier:@"next" sender:self];
            
            
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"fname"] forKey:@"fname"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"userid"] forKey:@"userid"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"emailid"] forKey:@"emailid"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"gender"] forKey:@"gender"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"activity1"] forKey:@"activity1"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"activity2"] forKey:@"activity2"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"activity3"] forKey:@"activity3"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"agegroup"] forKey:@"agegroup"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"arabiclang"] forKey:@"Arabic"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"pushmatch"] forKey:@"Switch1"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"pushmessage"] forKey:@"Switch2"];
            
            
            
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"birthdate"] forKey:@"DOB"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"city"] forKey:@"city"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"country"] forKey:@"country"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"description"] forKey:@"description"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"distance"] forKey:@"distance"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"englang"] forKey:@"English"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"emoji1"] forKey:@"emoji1"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"emoji2"] forKey:@"emoji2"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"emoji3"] forKey:@"emoji3"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"icanmeet"] forKey:@"icanmeet"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"liketoplay"] forKey:@"liketoplay"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"makefriendswith"] forKey:@"makefriendswith"];
            
            [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"superhero"] forKey:@"superhero"];
            
               [defaults setObject:[[Array_ChangeproInfo objectAtIndex:0]valueForKey:@"age"] forKey:@"age"];
            
            [defaults synchronize];
            
            
      
        }
    }
    
    
    
    
    
    
    
    
}
-(void)LogoutAccount
{
    [defaults setObject:@"no" forKey:@"Loginplay"];
        [defaults synchronize];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
    
    NSString *path1 = [documnetPath1 stringByAppendingPathComponent:@"ChatText1.plist"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    [[NSFileManager defaultManager] removeItemAtPath:path1 error:NULL];

    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainMenuNavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainMenuNavigationController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
 
}
- (IBAction)DoneButton:(id)sender;
{
    [self DoneClientServerComm];
    [defaults setObject:@"yes" forKey:@"settingDone"];
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)DoneClientServerComm
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
        
    {
        
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"updateprofile"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
 
   
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        NSString *fname= @"fname";
        NSString *fnameVal =[defaults valueForKey:@"fname"];
        
      
        NSString *gender= @"gender";
        NSString *genderVal =[defaults valueForKey:@"gender"];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        NSLog(@"Setting==%@",[defaults valueForKey:@"DOB"]);
        NSString *currentDateString =[defaults valueForKey:@"DOB"];// @"04-Feb-2018";
        
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
        
        NSLog(@"CurrentDate:%@", currentDate);
        
        
        NSString *birthdate= @"birthdate";
        NSString *birthdateVal =currentDateString;//[NSString stringWithFormat:@"%@", currentDate];
        
        NSString *city= @"city";
        NSString *cityVal =[defaults valueForKey:@"Cityname"];
        
        NSString *country= @"country";
        NSString *countryVal =[defaults valueForKey:@"Countryname"];
        
        NSString * arryString=[defaults valueForKey:@"language"];
        NSArray *arr = [arryString componentsSeparatedByString:@","];
        NSMutableArray* Array_addlanguges=[[NSMutableArray alloc]init];
        if (![arryString isEqualToString:@""])
        {
            Array_addlanguges = [NSMutableArray arrayWithArray:arr];
        }
        
        
        NSString *englang= @"lang1";
        NSString *englangVal =@"";
        
        NSString *arabiclang= @"lang2";
        NSString *arabiclangVal =@"";
        
        NSString *frenchlang= @"lang3";
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
        NSString *activity1Val =[defaults valueForKey:@"activity1"];
        
        NSString *activity2= @"activity2";
        NSString *activity2Val =  [defaults valueForKey:@"activity2"];
        
        NSString *activity3= @"activity3";
        NSString *activity3Val =  [defaults valueForKey:@"activity3"];
        
//        
//        NSString *emoji1= @"emoji1";
//        NSString *emoji1Val =@"";
//        
        NSString *pushMatch= @"pushmatch";
        NSString *pushMatchVal =[defaults valueForKey:@"Switch1"];
        
        NSString *pushMsg= @"pushmessage";
        NSString *pushMsgval =[defaults valueForKey:@"Switch2"];
        
        NSString *superhero= @"superhero";
        NSString *superheroVal =[defaults valueForKey:@"superhero"];
        
        NSString *agegroup= @"agegroup";
        NSString *agegroupVal =[defaults valueForKey:@"agegroup"];
        

        NSString *distance= @"distance";
        NSString *distanceVal =[defaults valueForKey:@"distance"];

        NSString *makefriendswith= @"makefriendswith";
        NSString *makefriendswithVal =[defaults valueForKey:@"makefriendswith"];
        
     
        
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,fbid1Val,fname,fnameVal,gender,genderVal,birthdate,birthdateVal,city,cityVal,country,countryVal,englang,englangVal,arabiclang,arabiclangVal,frenchlang,frenchlangVal,description,descriptionVal,iliketoplay,iliketoplayVal,makefriendswith,makefriendswithVal,icanmeet,icanmeetVal,activity1,activity1Val,activity2,activity2Val,activity3,activity3Val,pushMatch,pushMatchVal,pushMsg,pushMsgval,superhero,superheroVal,agegroup,agegroupVal,distance,distanceVal];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        
  
        
        [request setHTTPBody:requestData];
//        NSString *parameter = [NSString stringWithFormat:@"fbid1=%@&fname=%@&gender=%@&birthdate=%@&city=%@&country=%@&lang1=%@&lang2=%@&lang3=%@&description=%@&iliketoplay=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@=%@&password=%@",fbid1Val,fnameVal,genderVal,birthdateVal,cityVal,countryVal,englangVal,arabiclangVal,frenchlangVal,descriptionVal,,iliketoplayVal,,makefriendswithVal,icanmeet,icanmeetVal,activity1,activity1Val,activity2,activity2Val,activity3,activity3Val,superhero,superheroVal,agegroup,agegroupVal,distance,distanceVal];
//        NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        ;
//        url = [NSURL URLWithString: URL];
//        request = [NSMutableURLRequest requestWithURL:url];
//        [request setHTTPBody:parameterData];
//        
//        NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        ;
//        url = [NSURL URLWithString: URL];
//        request = [NSMutableURLRequest requestWithURL:url];
//        [request setHTTPBody:parameterData];
        
        
        
        Connection_ChangeproInfo = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_ChangeproInfo)
            {
                webData_ChangeproInfo =[[NSMutableData alloc]init];
                
                
            }
            else
            {
                NSLog(@"theConnection is NULL");
            }
        }
        
    }
    
}
- (IBAction)switchOutletAction:(id)sender
{
    UISwitch *switchObject = (UISwitch *)sender;
    if (switchObject.tag==0)
    {
        
    
        if ([switchObject isOn])
        {
            [switchObject setOn:NO animated:YES];
            [defaults setObject:@"OFF" forKey:@"Switch1"];
            [defaults synchronize];
        }
        else
        {
            [switchObject setOn:YES animated:YES];
            [defaults setObject:@"ON" forKey:@"Switch1"];
            [defaults synchronize];
        }
        
    }
    if (switchObject.tag==1)
    {
        
        if ([switchObject isOn])
        {
            [switchObject setOn:NO animated:YES];
            [defaults setObject:@"OFF" forKey:@"Switch2"];
            [defaults synchronize];
        }
        else
        {
            [switchObject setOn:YES animated:YES];
            [defaults setObject:@"ON" forKey:@"Switch2"];
            [defaults synchronize];
        }
    }
    
}

#pragma mark - Restore Connection

-(void)restoreProfileConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"restoreprofile"];
        url =[NSURL URLWithString:urlStrLivecount];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSString *fbid1= @"fbid";
        NSString *fbid1Val = [defaults valueForKey:@"fid"];
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",fbid1,fbid1Val];
        
        
        //converting  string into data bytes and finding the lenght of the string.
        NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
        
        
        
        [request setHTTPBody:requestData];
        
        
        Connection_Restoreprofile = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        {
            if( Connection_Restoreprofile)
            {
                webData_Restoreprofile =[[NSMutableData alloc]init];
                
                
            }
            else
            {
                NSLog(@"theConnection is NULL");
            }
        }

    }
    
}




@end
