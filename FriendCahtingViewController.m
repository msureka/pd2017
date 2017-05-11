
#import "FriendCahtingViewController.h"
#import "UIViewController+KeyboardAnimation.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import "DiscoverUserProfileinfoViewController.h"
#import "PushHandler.h"
#import "Base64.h"
#import "MHFacebookImageViewer.h"
#import "UIImageView+MHFacebookImageViewer.h"
#import "AdProfileViewController.h"
static NSString* const CellIdentifier = @"DynamicTableViewCell";
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f


@interface FriendCahtingViewController ()<UITextFieldDelegate>
{
    NSTimer *HomeTimer;
    NSURL *url_Vedio,* movieURLmain ;
    UIPinchGestureRecognizer *twoFingerPinch;
    UIImageView *Image_Amount,*Image_Date;
    UILabel * Label_paid_Unpaid,*Label_TitleTag,*Label_TitleTag1,*DateLabelHeder;
    UIImage *chosenImage;
    NSData *imageData,*ImageDataHeder,*newVedioData;
    NSDictionary *urlplist;
    NSURLConnection *Connection_Comment,*Connection_Comment_send,*Connection_Like;
    NSMutableData * webData_Comment,*webData_Comment_send,*webData_Like;
    NSMutableArray *Array_Comment,*Array_Like;
    NSString *ResultString,*String_Comment,*ResultString_sendComment,*ResultString_Like,*encodedImage,*chattype;
    UIGestureRecognizer *TabGestureDetailViewLikes,*TapGest_LabelHedingTap;
    NSUserDefaults * defaults;
    
    UIImageView * image_Desc,*ImageViews;
    UIView *headerView2,*headerView1,*PopUpImageVIew;
    UIButton *headerLabel1,* headerLabel2;
    NSArray * images_Array;
    NSString *   ImageNSdata;
    CGFloat HeightText0;
    CGRect TextViewCord,BackTextViewCord;
    UIButton * tapHederImage_Button;
    CGFloat lastScale;
    NSString *subImgname,* TagId_plist,*imageUserheight,*imageUserWidth;
    NSMutableArray * newCommentsArray_plist,*Array_Comment1;
    
    NSArray *previousArray;
    
    CGFloat hh,ww,xx,yy,th,tw,xt,yt,bty,btw,bth,btx,Bluesch,Bluescw,Bluescy,Bluescx,textBluex,textBluey,textBluew,textBlueh,hhone,wwone,xxone,yyone;
    NSString * flag1,*flag2,*flag3;
    BOOL statusTextView;
    CGRect previousRect;
    
    UIView *sectionView;
    NSMutableArray * arracal;
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
@end

static const CGFloat kButtonSpaceShowed = 90.0f;
static const CGFloat kButtonSpaceHided = 24.0f;
#define kBackgroundColorShowed [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
#define kBackgroundColorHided [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];



@implementation FriendCahtingViewController
@synthesize HeadTopView,Table_Friend_chat,Label_UserName,Image_UserProfile;
@synthesize AllDataArray,TextViews,BackTextViews;
@synthesize textOne,tableOne,ViewTextViewOne,Cell_one1;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    previousArray  = [[NSArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"UpdatenotificationChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TappedImage) name:@"TappedImage" object:nil];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"] )
    {
        CGRect tableViewFrame = self.Table_Friend_chat.frame;
        tableViewFrame.origin.y = 56;
        self.Table_Friend_chat.frame = tableViewFrame;
    }
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"ChatText" ofType:@"plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        NSLog(@"File alredy exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:path error:nil];
    }
    
    
    // [self Image_UserProfileTapped:nil];
    
//    Image_UserProfile.clipsToBounds = YES;
//    Image_UserProfile.layer.cornerRadius = Image_UserProfile.frame.size.height / 2;
    
    NSURL * url=[NSURL URLWithString:[[AllDataArray objectAtIndex:0] valueForKey:@"profilepic"]];
    [Image_UserProfile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
    Label_UserName.text=[[AllDataArray objectAtIndex:0] valueForKey:@"fname"];
    
    //     [Image_UserProfile setFrame:CGRectMake(HeadTopView.center.x-64,  Image_UserProfile.frame.origin.y, Image_UserProfile.frame.size.width, Image_UserProfile.frame.size.height)];
    //
    
    
    NSString *text=Label_UserName.text;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGFloat  widthCal=(size.width+Image_UserProfile.frame.size.width);
    CGFloat  ToatalWidth=((self.view.frame.size.width-widthCal)/2);
    
    NSLog(@"Length Of textttt==%f",size.width);
    NSLog(@"Length Of textttt==%f",widthCal);
    NSLog(@"Length Of textttt==%f",ToatalWidth);
    
    [Image_UserProfile setFrame:CGRectMake(ToatalWidth,Image_UserProfile.frame.origin.y, Image_UserProfile.frame.size.width, Image_UserProfile.frame.size.height)];
    [Label_UserName setFrame:CGRectMake(Image_UserProfile.frame.origin.x+Image_UserProfile.frame.size.width+10,Label_UserName.frame.origin.y, Label_UserName.frame.size.width, Label_UserName.frame.size.height)];
    _BlackViewOne.backgroundColor=[UIColor whiteColor];
    CALayer *borderTop = [CALayer layer];
    borderTop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderTop.frame = CGRectMake(0, 0, _BlackViewOne.frame.size.width, 1);
    [_BlackViewOne.layer addSublayer:borderTop];
    
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.hidden=NO;
    self.sendButton.enabled=NO;
    self.placeholderLabel.hidden=NO;
    [self.sendButton setBackgroundColor:[UIColor lightGrayColor]];//colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
    self.sendButton.layer.cornerRadius=self.sendButton.frame.size.height/2;
    self.sendButton.frame=CGRectMake((self.view.frame.size.width-self.sendButton.frame.size.width)-4, self.sendButton.frame.origin.y,self.sendButton.frame.size.width, self.sendButton.frame.size.height);
    
    self.BlackViewOne.frame=CGRectMake(self.view.frame.size.width,self.BlackViewOne.frame.origin.y,self.BlackViewOne.frame.size.width, self.BlackViewOne.frame.size.height);
    
    
    
    
    
    
    
    
    
    self.ImageGalButton.userInteractionEnabled = YES;
    _ImageGalButton.hidden=NO;
    _ImageGalButton.enabled=YES;
    [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
    
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.height);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.width);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.y);
    NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.x);
    
   
    textOne.clipsToBounds=YES;
    textOne.layer.cornerRadius=7.0f;
    
    ViewTextViewOne.clipsToBounds=YES;
    ViewTextViewOne.layer.cornerRadius=9.0f;
    
    
    
    
    
    hh=textOne.frame.size.height;
    ww=textOne.frame.size.width;
    xx=textOne.frame.origin.x;
    yy=textOne.frame.origin.y;
    
    
    
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
        
        ww=194.0;
        
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
    {
        
        ww=249.0;
    }
    
    else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
    {
        
         ww=288.0;
        
        
    }
    
    
    
    th=Table_Friend_chat.frame.size.height;
    tw=Table_Friend_chat.frame.size.width;
    xt=Table_Friend_chat.frame.origin.x;
    yt=Table_Friend_chat.frame.origin.y;
    
    bth=_BlackViewOne.frame.size.height;
    btw=_BlackViewOne.frame.size.width;
    btx=_BlackViewOne.frame.origin.x;
    bty=_BlackViewOne.frame.origin.y;
    
    Bluesch=_BlackViewOne.frame.size.height;
    Bluescw=_BlackViewOne.frame.size.width;
    Bluescx=_BlackViewOne.frame.origin.x;
    Bluescy=_BlackViewOne.frame.origin.y;
    
    
    flag1=@"yes";
    
//    CGRect previousRect = CGRectZero;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
   self.textOne.frame = CGRectMake(xx, yy,ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    
 

 //  Table_Friend_chat.frame = CGRectMake(0,-1, tw, th);
//     Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-10);
  // Table_Friend_chat.backgroundColor=[UIColor greenColor];
    
    
    subImgname =[[[AllDataArray objectAtIndex:0]valueForKey:@"tagpic"]lastPathComponent];
    NSLog(@"subImgname=%@",subImgname);
    
    
    
    //   [self.view addSubview:self.ewenTextView];
    //     _ewenTextView.backgroundColor = [UIColor clearColor];
   
   
    
    [TextViews becomeFirstResponder];
    
    TextViewCord=TextViews.frame;
    BackTextViewCord=BackTextViews.frame;
    HeightText0=TextViews.frame.size.height;
    TextViews.layer.cornerRadius=8.0f;
    //    SendButton.hidden=YES;
    //    SendButton.layer.cornerRadius=8.0f;

    
   
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"data pay view profile=%@",AllDataArray);
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    
    Array_Comment = [[NSMutableArray alloc] init];
    Array_Like = [[NSMutableArray alloc] init];
    NSLog(@"paid data====%@",[[AllDataArray objectAtIndex:0]valueForKey:@"tagtype"] );
  
    

    
    
    Array_Comment1=[[NSMutableArray alloc]init];
   
    
//    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    
//    NSLog(@"%@",NSHomeDirectory());
//    
//    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    NSLog(@"dictionary setValue:=%@",dictionary );
    if (AllDataArray.count==0)
    {
    Label_UserName.text=@"sachin";
        TagId_plist=[defaults valueForKey:@"matchedfbid"];
    }
    else
    {
        TagId_plist=[[AllDataArray valueForKey:@"matchedfbid"]objectAtIndex:0];
//        [defaults setObject:[[AllDataArray objectAtIndex:0]valueForKey:@"matchedfbid"] forKey:@"matchedfbid"];
//        [defaults synchronize];
    }
   
    
    
    BOOL contains = [[dictionary allKeys] containsObject:TagId_plist];
    if(contains==YES)
    {
        NSLog(@"YEsssssssssssss");
        Array_Comment1=[dictionary valueForKey:TagId_plist];
        [Table_Friend_chat reloadData];
        if(Array_Comment1.count>=1)
        {
            
            
            [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            
        }
        NSLog(@"data plist path array==%@",Array_Comment1);
    }
    NSLog(@"Arrraararara:=%@",AllDataArray );
    Image_UserProfile.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(Image_UserProfileTapped:)];
    
    
    [Image_UserProfile addGestureRecognizer:TabGestureDetailView];
    
    Label_UserName.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView2 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(Image_UserProfileTapped:)];
    
    [Label_UserName addGestureRecognizer:TabGestureDetailView2];
    
   
      [Table_Friend_chat reloadData];
    
    [defaults setObject:@"yes" forKey:@"notification"];
    [defaults synchronize];
    
    [self CommentCommmunication];
    
#pragma mark - timer vdl uday
    
//  HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
    
    

}

-(void)chatTimer
{
    HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self chatTimer];
     
//    HomeTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(CommentCommmunication) userInfo:nil  repeats:YES];
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        CGRect tableViewFrame = self.Table_Friend_chat.frame;
        tableViewFrame.origin.y = 56;
        self.Table_Friend_chat.frame = tableViewFrame;
    }
    
    Image_UserProfile.userInteractionEnabled=YES;
    UITapGestureRecognizer *TabGestureDetailView =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(Image_UserProfileTapped:)];
    
    
    [Image_UserProfile addGestureRecognizer:TabGestureDetailView];
  
   
    [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [HomeTimer invalidate];
    HomeTimer=nil;
    [self an_unsubscribeKeyboard];
}


- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
           
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
          
            if(Array_Comment1.count>=1)
            {
                if([subImgname isEqualToString:@"defaultimg.jpg"])
                {
                    
                    [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }
                else
                {
                    [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }
            }
            
            
            
            
        } else {
            
            self.tabBarBottomSpace.constant = 0.0f;
           
        }
        [self.view layoutIfNeeded];
    } completion:nil];}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
      return Array_Comment1.count+1;
  
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
// 
//    return 0;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"CellOnes";
 
    
    
    UILabel *label = nil;
    UILabel *label1 = nil;
    UILabel *label_time = nil;
    UIImageView * desc_Imagepro=nil;
    UIImageView * Chat_ImageRight=nil;
    UIImageView * Chat_UserImage=nil;
    
    Cell_one1 = [Table_Friend_chat dequeueReusableCellWithIdentifier:@"Cell"];
    Cell_one1.selectionStyle=UITableViewCellSelectionStyleNone;
    if (Cell_one1 == nil)
    {
        
        Cell_one1 = [[CustomTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:Cellid1] ;
        label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [label1 setLineBreakMode:UILineBreakModeWordWrap];
        //        [label1 setMinimumFontSize:FONT_SIZE];
        [label1 setNumberOfLines:0];
        //        [label1 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label1 setTag:1];
        // [[label layer] setBorderWidth:2.0f];
        [label1 setBackgroundColor:[UIColor clearColor]];
        
        
        
        
        
        [[Cell_one1 contentView] addSubview:label1];
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
//        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE]];
        [label setTag:5];
        // [[label layer] setBorderWidth:2.0f];
        [label setBackgroundColor:[UIColor clearColor]];
        
        
        
        
        
        [[Cell_one1 contentView] addSubview:label];
        
        desc_Imagepro = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [desc_Imagepro setTag:4];
        
        [desc_Imagepro setBackgroundColor:[UIColor lightGrayColor]];
        
        [[Cell_one1 contentView] addSubview:desc_Imagepro];
        
        
        Chat_ImageRight = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [Chat_ImageRight setTag:4];
        
        [Chat_ImageRight setBackgroundColor:[UIColor lightGrayColor]];
        
        [[Cell_one1 contentView] addSubview:Chat_ImageRight];
        
        Chat_UserImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [Chat_UserImage setTag:5];
        
        [Chat_UserImage setBackgroundColor:[UIColor lightGrayColor]];
        
        [[Cell_one1 contentView] addSubview:Chat_UserImage];
        
        
        
    }
    
    
    Cell_one1.selectionStyle=UITableViewCellSelectionStyleNone; 
    
   
    if (!label)
        label = (UILabel*)[Cell_one1 viewWithTag:1];
    
    if (!label1)
        label1 = (UILabel*)[Cell_one1 viewWithTag:2];
    
   
    //                NSTextAlignmentLeft      = 0,
    //                NSTextAlignmentCenter    = 1,
    //                NSTextAlignmentRight     = 2,
    //                NSTextAlignmentJustified = 3,
    [label setBackgroundColor:[UIColor clearColor]];
    
//    label.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
    label.textColor=[UIColor blackColor];
    if (indexPath.row==0)
    {
       
[label setText:[NSString stringWithFormat:@"%@%@%@%@",@"You matched with ",[[AllDataArray objectAtIndex:0] valueForKey:@"fname"],@" on ",[[AllDataArray objectAtIndex:0] valueForKey:@"matchdate"]]];
        [label setFrame:CGRectMake(0,0,self.view.frame.size.width, Cell_one1.frame.size.height)];
         label.textColor=[UIColor lightGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
    }
  else
  {
    
      if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
      {
      
    NSString *text =[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"message"];
      
      
      CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
      
      CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
      
      int lines = size.height/16;
      
      NSLog(@"lines count : %i \n\n",lines);
      
    
    
   [label setFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE]];
    
      NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
      style.alignment = NSTextAlignmentLeft;
      style.firstLineHeadIndent = 10.0f;
      style.headIndent = 10.0f;
      style.tailIndent = -10.0f;
      
      NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style}];
      
      label.numberOfLines = 0;
      label.attributedText = attrText;
      
   //   [label setText:text];
    
    label.clipsToBounds=YES;
    label.layer.cornerRadius=9.0f;
    label1.backgroundColor=[UIColor colorWithRed:13/255.0 green:146/255.0 blue:220/255.0 alpha:0.8];

    NSLog(@"Comment Width==%f",size.width);
    NSLog(@"Comment Height==%f",size.height);
    NSLog(@"Comment StringLength==%lu",(unsigned long)text.length);
    
    if ([[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"receiverfbid"]])
    {
        NSURL * url=[[AllDataArray objectAtIndex:0]valueForKey:@"profilepic"];
        [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
        
        
        label.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:0.7];
//        label.textColor=[UIColor colorWithRed:124/255.0 green:111/255.0 blue:164/255.0 alpha:0.7];
           label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        if (size.width <=self.view.frame.size.width-132)
        {
            
//            [label1 setFrame:CGRectMake(50,0, size.width+34, MAX(size.height, 30.0f)+4)];
            [label setFrame:CGRectMake(50,0, size.width+22, MAX(size.height, 30.0f)+8)];
           
          
        }
        
        else
        {
//            [label1 setFrame:CGRectMake(50,0, self.view.frame.size.width-132, MAX(size.height, 30.0f)+4)];
            [label setFrame:CGRectMake(50,0, self.view.frame.size.width-140,MAX(size.height, 30.0f)+8)];
         
            
        }
       
        Chat_ImageRight.backgroundColor=[UIColor clearColor];
        [Chat_ImageRight setFrame:CGRectMake(label.frame.origin.x-14,label.frame.size.height-27, 16,16)];
        [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_left.png"]];
        
        //chat_arrow_right.png
        [desc_Imagepro setFrame:CGRectMake(8,label.frame.origin.y+(label.frame.size.height-32),32,32)];
        desc_Imagepro.clipsToBounds=YES;
        desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
    }
    else
    {
        NSURL * url=[defaults valueForKey:@"profilepic"];
        [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
        {
           label.backgroundColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
            
        }
        else
        {
 label.backgroundColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
        }
      
//        label.textColor=[UIColor colorWithRed:108/255.0 green:157/255.0 blue:180/255.0 alpha:1];
          label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        
        if (size.width <=self.view.frame.size.width-132)
        {
            
//            [label1 setFrame:CGRectMake(self.view.frame.size.width-(size.width+89),0, size.width+30, MAX(size.height, 30.0f)+8)];
            [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),0, size.width+22, MAX(size.height, 30.0f)+8)];
        }
        
        else
        {
            
            
//            [label1 setFrame:CGRectMake(self.view.frame.size.width-(size.width+81),0, self.view.frame.size.width-132, MAX(size.height, 30.0f)+8)];
            [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),0, self.view.frame.size.width-140, MAX(size.height, 30.0f)+8)];
            
            
            
        }
        Chat_ImageRight.backgroundColor=[UIColor clearColor];
        [Chat_ImageRight setFrame:CGRectMake(label.frame.size.width+label.frame.origin.x-2,label1.frame.size.height-27, 16,16)];
        
        NSLog(@"Label1Frame11==%f",label1.frame.size.width);
        NSLog(@"Labe221Frame22==%f",label.frame.size.width);
        [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_right.png"]];
        
        [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,label.frame.origin.y+(label.frame.size.height-32),32,32)];
        desc_Imagepro.clipsToBounds=YES;
        desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
    }
  
      
      
      
  }
  
    else
    {
      
       
        CGFloat imgwidth=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imagewidth"] floatValue];
        CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageheight"] floatValue];
       
        //Chat_UserImage.backgroundColor=[UIColor clearColor];
        NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageurl"];
        [Chat_UserImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
        Chat_UserImage.clipsToBounds=YES;
        Chat_UserImage.layer.cornerRadius=9.0f;
        Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
        
        
       

        
        
        
        if ([[defaults valueForKey:@"fid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"receiverfbid"]])
        {
            
            NSURL * url=[[AllDataArray objectAtIndex:0]valueForKey:@"profilepic"];
            [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
           
            [Chat_UserImage setFrame:CGRectMake(52,4,imgwidth,imgheight)];
            Chat_UserImage.clipsToBounds=YES;
            Chat_UserImage.layer.cornerRadius=9.0f;
            Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
         [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
            
            [desc_Imagepro setFrame:CGRectMake(8,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
            desc_Imagepro.clipsToBounds=YES;
            desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
            
        }
        else
        {
            
            
            NSURL * url=[defaults valueForKey:@"profilepic"];
            [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
            
            
            [Chat_UserImage setFrame:CGRectMake((self.view.frame.size.width-64)-imgwidth,4,imgwidth,imgheight)];
            Chat_UserImage.clipsToBounds=YES;
            Chat_UserImage.layer.cornerRadius=9.0f;
            Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
            
             [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
            
            [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
            desc_Imagepro.clipsToBounds=YES;
            desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
        }
        
        
    }
  }
    return Cell_one1;
    
    
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
////    if (section==0)
////    {
//        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,36)];
//        [sectionView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
//        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
//        Label1.backgroundColor=[UIColor clearColor];
//        Label1.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
//        Label1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
//        Label1.text=@"New matches";
//
//
//        UILabel * Label2=[[UILabel alloc]initWithFrame:CGRectMake(130,6,24,24)];
//        Label2.backgroundColor=[UIColor lightGrayColor];
//        Label2.clipsToBounds=YES;
//        Label2.layer.cornerRadius=Label2.frame.size.height/2;
//        Label2.textColor=[UIColor groupTableViewBackgroundColor];
//        Label2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
//        Label2.text=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Comment.count];
//        Label2.textAlignment=NSTextAlignmentCenter;
//        [sectionView addSubview:Label2];
//
//
//
//        [sectionView addSubview:Label1];
//        sectionView.tag=section;
//    return sectionView;
//    }


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    if (indexPath.row==0)
    {
       return 50;
    }
    else
    {
        if ([[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"chattype"] isEqualToString:@"TEXT"])
        {
        NSString *text = [[Array_Comment1 objectAtIndex:indexPath.row-1] valueForKey:@"message"];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 30.0f);
        return height + (CELL_CONTENT_MARGIN * 2)+15;
        }
        else
        {
            CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row-1]valueForKey:@"imageheight"] floatValue];
            return imgheight+14;
        }
 
   
    }
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==1)
//    {
//        
//    }
//    
//}
-(IBAction)BackView:(id)sender
{
    
    
    [defaults setObject:@"no" forKey:@"notification"];
    [defaults synchronize];
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        //        self.view.window.rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //[self.view.window.rootViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self performSegueWithIdentifier:@"back" sender:self];
    }
    else
    {
        [defaults setObject:@"no" forKey:@"letsChat"];
        [defaults setObject:@"no" forKey:@"letsChatAd"];
        
        [defaults synchronize];
        if ([[defaults valueForKey:@"friendRequest"] isEqualToString:@"yes"])
        {
            [defaults setObject:@"no" forKey:@"friendRequest"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    }
    
    
    
    [HomeTimer invalidate];
    HomeTimer=nil;
}

-(IBAction)Send_Comments:(id)sender
{
    String_Comment=textOne.text;
    [self sendComment];
    textOne.text=nil;
    _ImageGalButton.enabled=YES;
    _placeholderLabel.hidden=NO;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
    self.textOne.frame = CGRectMake(xx, yy, ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    self.sendButton.enabled=NO;
    self.sendButton.backgroundColor=[UIColor lightGrayColor];
    Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(TextViews.contentSize.height+220));
            self.ImageGalButton.userInteractionEnabled = YES;  // uday
 
}
-(IBAction)CameraButtonAct:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 3;
    [popup showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex== 0)
    {
        
       
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
        
      
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chattype=@"IMAGE";
    chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width-120, self.view.frame.size.height-127)];
    attachmentImageNew.image = chosenImage;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
   
  
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    float imageHeight = scale * attachmentImageNew.image.size.height;
    
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    if (imageWidth>=254)
    {
         imageUserWidth=[NSString stringWithFormat:@"%f",254.0];
    }
    else
    {
       imageUserWidth=[NSString stringWithFormat:@"%f",imageWidth];
    }
    
      imageUserheight=[NSString stringWithFormat:@"%f",imageHeight];
    
    UIImage *image =  [self scaleImage:chosenImage  toSize:CGSizeMake([imageUserWidth floatValue]*2,[imageUserheight floatValue]*2)];
    
    
    imageData = UIImageJPEGRepresentation(image,0.5);
    
    // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    ImageNSdata = [Base64 encode:imageData];

    
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));

    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
     [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self sendComment];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    chattype=@"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)sendComment
{
    
    NSLog(@"sachin %@",String_Comment);
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"addchat"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
//    NSString *receiverfbid=@"fbid2";
    NSString *receiverfbidVal=[[AllDataArray objectAtIndex:0]valueForKey:@"matchedfbid"];
    
//    NSString *senderfbid=@"fbid1";
    NSString *senderfbidVal=[defaults valueForKey:@"fid"];
    
//    NSString *chatcount=@"chatcount";
    NSString *chatcountVal=@"";
    
//    NSString *message=@"message";
    NSString *messageVal=textOne.text;
   
//    NSString *Chattypee=@"chattype";
    NSString *ChattypeeVal=chattype;
    
    
//    NSString *ChatImage=@"chatimage";
    NSString *ChatImageVal=encodedImage;
    
//    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",receiverfbid,receiverfbidVal,senderfbid,senderfbidVal,chatcount,chatcountVal,message,messageVal];
//    
//    
//    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
//    [request setHTTPBody: requestData];
    
    
    
    
   NSString *parameter = [NSString stringWithFormat:@"fbid2=%@&fbid1=%@&chatcount=%@&message=%@&chattype=%@&chatimage=%@&imagewidth=%@&imageheight=%@",receiverfbidVal,senderfbidVal,chatcountVal,messageVal,ChattypeeVal,ChatImageVal,imageUserWidth,imageUserheight];
//    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    ;
    
//    
//    
     NSData * requestData = [NSData dataWithBytes:[parameter UTF8String] length: [parameter length]];
    
    
   
    [request setHTTPBody:requestData];
    
    
    Connection_Comment_send = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_Comment_send)
        {
            webData_Comment_send=[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
}
-(void)CommentCommmunication
{
    
    NSLog(@"comment communication");
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"chat"];
    url =[NSURL URLWithString:urlStrLivecount];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *fbid1=@"fbid1";
    NSString *fbid1Val=[defaults valueForKey:@"fid"];
    
    NSString *fbid2;
    NSString *fbid2val;
    
  
    if (AllDataArray.count==0)
    {
       fbid2=@"fbid2";
       fbid2val=[defaults valueForKey:@"matchedfbid"];
    }
    else
    {
        fbid2=@"fbid2";
        fbid2val=[[AllDataArray objectAtIndex:0]valueForKey:@"matchedfbid"];
        [defaults setObject:[[AllDataArray objectAtIndex:0]valueForKey:@"matchedfbid"] forKey:@"matchedfbid"];
        [defaults synchronize];
    }
//    NSString *chatcount=@"fid";
//    NSString *taginviteVal=[];
//    
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",fbid1,fbid1Val,fbid2,fbid2val];
    
    
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    Connection_Comment = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    {
        if( Connection_Comment)
        {
            webData_Comment =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"connnnnnnnnnnnnnn=%@",connection);
    if(connection==Connection_Comment)
    {
        [webData_Comment setLength:0];
        
        
    }
    if(connection==Connection_Comment_send)
    {
        [webData_Comment_send setLength:0];
        
        
    }
    if(connection==Connection_Like)
    {
        [webData_Like setLength:0];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==Connection_Comment)
    {
        [webData_Comment appendData:data];
    }
    if(connection==Connection_Comment_send)
    {
        [webData_Comment_send appendData:data];
    }
    if(connection==Connection_Like)
    {
        [webData_Like appendData:data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (connection==Connection_Comment)
    {
       
      
      

        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString=[[NSString alloc]initWithData:webData_Comment encoding:NSUTF8StringEncoding];
        Array_Comment= [objSBJsonParser objectWithData:webData_Comment];
        
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"Array_Comment %@",Array_Comment);
        NSLog(@"Array_Comment_ResultString%@",ResultString);
        if ([ResultString isEqualToString:@"NullError"])
        {
            
        }
       
        NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSLog(@"%@",NSHomeDirectory());
        
        NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
        
       
        if(Array_Comment.count!=0)
        {
            
            NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
            
            NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
            
       
            
            if(Array_Comment1.count==0 || savedValue1==nil)
            {
                if (savedValue1==nil)
                {
                    NSMutableDictionary *data;
                    
                    data = [[NSMutableDictionary alloc] init];
                    
                    [data setObject:Array_Comment forKey:TagId_plist];
                    [data writeToFile:path atomically:YES];
                }
                
            }

            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            NSLog(@"dictionary setValue:=%@",dictionary );
            
            if (Array_Comment.count!=0)
            {
                Array_Comment1=Array_Comment;
                [dictionary setObject:Array_Comment forKey:TagId_plist];
                [dictionary writeToFile:path atomically:YES];
            }
            
           
            
            if (previousArray.count == Array_Comment.count)
            {
                
            }
            else
            {
                [Table_Friend_chat reloadData];
            }
            
            
            
            

          
            
            if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
            {
                
                
                [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                
            }
            
            previousArray = Array_Comment;


            
                  }
        
        
        
    }
    if (connection==Connection_Comment_send)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString_sendComment=[[NSString alloc]initWithData:webData_Comment_send encoding:NSUTF8StringEncoding];
        Array_Comment=[objSBJsonParser objectWithData:webData_Comment_send];
        
        ResultString_sendComment = [ResultString_sendComment stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_sendComment = [ResultString_sendComment stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"Array_Commentsens %@",Array_Comment);
        NSLog(@"ResultString_sendComment%@",ResultString_sendComment);
        
        
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
        if ([ResultString isEqualToString:@"inserterror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Error in sending message. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in sending message. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"messagenull"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if ([ResultString isEqualToString:@"imagenull"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        
       if ([ResultString isEqualToString:@"imageerror"])
        {
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//            [message show];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        }


        if(Array_Comment.count !=0)
        {
          
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
            
            
            
            NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
            
            
            NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
            
            if(Array_Comment1.count==0 || savedValue1==nil)
            {
                if (savedValue1==nil)
                {
                    NSMutableDictionary *data;
                    
                    data = [[NSMutableDictionary alloc] init];
                    
                    [data setObject:Array_Comment forKey:TagId_plist];
                    [data writeToFile:path atomically:YES];
                }
                
            }

            
            
            
            
            NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
            
            NSLog(@"dictionary setValue:=%@",dictionary);
            if(Array_Comment.count !=0)
            {
                NSLog(@"NO11111");
                Array_Comment1=Array_Comment;
                [dictionary setObject:Array_Comment forKey:TagId_plist];
                [dictionary writeToFile:path atomically:YES];
            }
            
            
            
            
            

            
            [Table_Friend_chat reloadData];
            if(Array_Comment.count>=1)
            {
                
                    
                    [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
              
            }
            
        }
        
        
    }
    if (connection==Connection_Like)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        ResultString_Like=[[NSString alloc]initWithData:webData_Like encoding:NSUTF8StringEncoding];
        Array_Like= [objSBJsonParser objectWithData:webData_Like];
        
        ResultString_Like = [ResultString_Like stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_Like = [ResultString_Like stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSLog(@"ResultString_Like %@",Array_Like);
        NSLog(@"ResultString_Like%@",ResultString_Like);
        if ([ResultString_Like isEqualToString:@"NoLikes"])
        {
            [Table_Friend_chat reloadData];
        }
        
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    //    [tableView_Pay scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if(Array_Comment1.count>=1)
    {
    
            
            [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }
    
    if (textView.text.length == 0)
    {
        self.sendButton.hidden=NO;
        self.sendButton.enabled=NO;
        self.placeholderLabel.hidden=NO;
        [self.sendButton setBackgroundColor:[UIColor lightGrayColor]];
        self.sendButton.userInteractionEnabled = NO;
        
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=YES;
        [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
        self.ImageGalButton.userInteractionEnabled = YES;
        
        
        
        
    }
    else
    {
        
        chattype=@"TEXT";
        
        
        self.placeholderLabel.hidden=YES;
        self.sendButton.hidden=NO;
        self.sendButton.enabled=YES;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = YES;
        
       
        
        _ImageGalButton.userInteractionEnabled = NO;
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=NO;
      
    }
    
    
    CGFloat y = CGRectGetMaxY(self.textOne.frame);

    UITextPosition* pos = textOne.endOfDocument;
   
    CGRect currentRect = [textOne caretRectForPosition:pos];
    
    NSLog(@"dsdssdfds %f",currentRect.origin.y);
  
    if (currentRect.origin.y >65)
    {
        if ( [flag1 isEqualToString:@"yes" ])
        {
            
            self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+36, btw,bth+textView.contentSize.height);
            ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textOne.frame.size.height+2);
            // tableView_Pay.frame = CGRectMake(0, yt - textView.contentSize.height+38, tw, th);
            Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+182));
            flag1=@"no";
        }
        else
        {
            flag1=@"no";
        }
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        if(currentRect.origin.y <=64)
        {
            flag1=@"yes";
        }
        
        
        
        self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+33, btw,bth+textView.contentSize.height);
        
        self.textOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height+10);
        ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height);
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+184));
        
        [self.textOne layoutIfNeeded];
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.height);
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.width);
        NSLog(@"BlueViewx==%f",_textOneBlue.frame.origin.x);
        NSLog(@"BlueViewy==%f",_textOneBlue.frame.origin.y);
        
        
        
        NSLog(@"tableView_Pay==%f",Table_Friend_chat.frame.size.height);
        NSLog(@"tableView_Payyy==%f",Table_Friend_chat.frame.origin.y);
        
        NSLog(@"ViewTextViewOne==%f",ViewTextViewOne.frame.size.height);
        
        NSLog(@"self.textOne.frame==%f",self.textOne.frame.size.height);
        
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
        
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.height);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.size.width);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.y);
        NSLog(@"tableOne==%f",Table_Friend_chat.frame.origin.x);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_BlackViewOne.frame.size.height > bth)
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    }
    else
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th);
       
    }
    [self.view endEditing:YES];
  
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textOne becomeFirstResponder];
    
    if (textView.text.length!=0)
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, self.view.frame.size.width, th-_BlackViewOne.frame.size.height-125);
        
    }
    else
    {
        
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+190));
    }
    
    if(Array_Comment1.count>=1)
    {
        
            
            [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
      
    
    }
    
}


- (void)Image_UserProfileTapped:(UITapGestureRecognizer *)recognizer
{
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"])
    {
        [self performSegueWithIdentifier:@"next" sender:self];
    }
    else if ([[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
         [self performSegueWithIdentifier:@"nextAd" sender:self];
    }
    else
    {
       if ([[[AllDataArray objectAtIndex:0] valueForKey:@"profiletype"] isEqualToString:@"PROFILE"])
       {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DiscoverUserProfileinfoViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DiscoverUserProfileinfoViewController"];
    set.Array_UserInfo=AllDataArray;
    [self.navigationController pushViewController:set animated:YES];
       }
       else
       {
           UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           
           AdProfileViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"AdProfileViewController"];
           set.Array_LodingPro=AllDataArray;
           [self.navigationController pushViewController:set animated:YES];
           
       }
        
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"next"]) {
       
        DiscoverUserProfileinfoViewController * destViewController= segue.destinationViewController;
        destViewController.Array_UserInfo=AllDataArray ;
        
       
        
        
    }
    else if ([segue.identifier isEqualToString:@"nextAd"])
    {
        AdProfileViewController * destViewController= segue.destinationViewController;
        destViewController.Array_LodingPro=AllDataArray ;
    }
}


- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    
   
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}

-(void)updateLabel
{
    [self CommentCommmunication];
}
-(void)TappedImage
{
    if (_BlackViewOne.frame.size.height > bth)
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    }
    else
    {
        Table_Friend_chat.frame = CGRectMake(0,yt, tw, th);
        
    }
    [self.view endEditing:YES];
}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
