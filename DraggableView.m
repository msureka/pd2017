//
//  DraggableView.m
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


#import "DraggableView.h"



@implementation DraggableView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
    NSUserDefaults * defaults;
    NSString *checkstr;
    CGFloat FrontImgxx,FrontImgyy,FrontImgww,FrontImghh;
    CGFloat BackImgxx,BackImgyy,BackImgww,BackImghh;
    CGFloat Lnamexx,Lnameyy,Lnameww,Lnamehh;
    CGFloat Addressxx,Addressyy,Addressww,Addresshh;
    CGFloat t1xx,t1yy,t1ww,t1hh,t2xx,t2yy,t2ww,t2hh,t3xx,t3yy,t3ww,t3hh;
    CGFloat DescTxx,DescTyy,DescTww,DescThh;
    
   CGFloat Imagetop1xx,Imagetop1yy,Imagetopww,Imagetop1hh;
       CGFloat Imageribbonxx,Imageribbonyy,Imageribbonww,Imageribbonhh;
    CGFloat Imagetoplogoxx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh,Imagetoplogo2xx,Imagetoplogo3xx,Imagetoplogo11xx,Imagetoplogo22xx;
    CGFloat DesctopTxx,DesctopTyy,Desctopww,Desctophh;
    CGFloat Labelxx,Labelyy,Labelww,Labelhh;
    CGFloat Labelbgxx,Labelbgyy,Labelbgww,Labelbghh;
    CGFloat Labeltitlexx,Labeltitleyy,Labeltitleww,Labeltitlehh;
    
   
}

@synthesize Back_imageprofile,Front_imageprofile;
@synthesize Label_Name,Label_CityCountry,Label_Emoji1,Label_Emoji2,Label_Emoji3,Label_Desc,Label_Favtitle,Image_Left,Image_Right;
@synthesize delegate;
@synthesize Image_TopcompnyImage;;
@synthesize Label_AddressComp;
@synthesize Label_AddressCompbg;
@synthesize Label_TitleCompany;
@synthesize Textview_DescCompany;
@synthesize Image_compnyLogo1;
@synthesize Image_compnyLogo2;
@synthesize Image_compnyLogo3;
@synthesize Image_ribbon;
@synthesize panGestureRecognizer;

@synthesize overlayView,overlayView1,tap,tap1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
        {
            FrontImgxx=57.0,FrontImgyy=49.0,FrontImgww=206.0,FrontImghh=188;
            BackImgxx=57.0,BackImgyy=49.0,BackImgww=206.0,BackImghh=187.0;
            Lnamexx=14.0,Lnameyy=243.0,Lnameww=292.0,Lnamehh=55.0;
            Addressxx=14.0,Addressyy=298.0,Addressww=292.0,Addresshh=25.0;
            t1xx=84.0,t1yy=330,t1ww=41.0,t1hh=40.0,t2xx=139.0,t3xx=194.0;
            DescTxx=14.0,DescTyy=381.0,DescTww=292.0,DescThh=125.0;
            
            Imagetop1xx=0.0,Imagetop1yy=0.0,Imagetopww=320.0,Imagetop1hh=238.0;
            Imagetoplogoxx=14.0,Imagetoplogoyy=425.0,Imagetoplogoww=73.0,Imagetoplogohh=73.0,Imagetoplogo2xx=123.0,Imagetoplogo3xx=233.0,Imagetoplogo11xx=76.0,Imagetoplogo22xx=178.0;
            DesctopTxx=7.0,DesctopTyy=347.0,Desctopww=306.0,Desctophh=78.0;
            
            Labelxx=67.0,Labelyy=238.0,Labelww=253.0,Labelhh=24.0;
            Labelbgxx=0,Labelbgyy=238.0,Labelbgww=320,Labelbghh=24.0;
            
            Labeltitlexx=7.0,Labeltitleyy=273.0,Labeltitleww=306.0,Labeltitlehh=75.0;
            
            Imageribbonxx=13.0,Imageribbonyy=229.0,Imageribbonww=38.0,Imageribbonhh=38.0;

 // difference y =-51

        }
        
        else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
        {
            
            FrontImgxx=67.0,FrontImgyy=57.0,FrontImgww=241.0,FrontImghh=220.0;
            BackImgxx=67.0,BackImgyy=57.0,BackImgww=241.0,BackImghh=220.0;
            Lnamexx=16.0,Lnameyy=285.0,Lnameww=self.frame.size.width-32,Lnamehh=65.0;
            Addressxx=16.0,Addressyy=350.0,Addressww=self.frame.size.width-32,Addresshh=29.0;
            t1xx=99.0,t1yy=387.0,t1ww=48.0,t1hh=52.0,t2xx=163.0,t3xx=227.0;
            DescTxx=20.0,DescTyy=450.0,DescTww=self.frame.size.width-40,DescThh=147.0;
            
            
            
            Imagetop1xx=0.0,Imagetop1yy=0.0,Imagetopww=375.0,Imagetop1hh=300.0;
            
        Imagetoplogoxx=16.0,Imagetoplogoyy=505.0,Imagetoplogoww=86.0,Imagetoplogohh=86.0,Imagetoplogo2xx=144.0,Imagetoplogo3xx=273.0,Imagetoplogo11xx=89.0,Imagetoplogo22xx=209.0;
            
            DesctopTxx=8.0,DesctopTyy=413.0,Desctopww=self.frame.size.width-16,Desctophh=92.0;
            
           Labelxx=78.0,Labelyy=300.0,Labelww=297.0,Labelhh=28.0;
            Labelbgxx=0.0,Labelbgyy=300.0,Labelbgww=375.0,Labelbghh=28.0;//Labelbgyy=291
            
           Labeltitlexx=8.0,Labeltitleyy=330.0,Labeltitleww=self.frame.size.width-16,Labeltitlehh=88.0;
            Imageribbonxx=15.0,Imageribbonyy=288.0,Imageribbonww=45.0,Imageribbonhh=45.0;

   //difference y = -54
        
        }
      else if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
        {
            FrontImgxx=74.0,FrontImgyy=63.0,FrontImgww=266.0,FrontImghh=244.0;
            BackImgxx=74.0,BackImgyy=63.0,BackImgww=266.0,BackImghh=243.0;
            Lnamexx=18.0,Lnameyy=314.0,Lnameww=378.0,Lnamehh=72.0;
            Addressxx=18.0,Addressyy=386.0,Addressww=378.0,Addresshh=32.0;
            t1xx=109.0,t1yy=427,t1ww=53.0,t1hh=53.0,t2xx=180.0,t3xx=251.0;
            DescTxx=18.0,DescTyy=493.0,DescTww=378.0,DescThh=162.0;
            
            
            Imagetop1xx=0.0,Imagetop1yy=0.0,Imagetopww=414.0,Imagetop1hh=309.0;
            Imagetoplogoxx=18.0,Imagetoplogoyy=557.0,Imagetoplogoww=95.0,Imagetoplogohh=95.0,Imagetoplogo2xx=159.0,Imagetoplogo3xx=301.0,Imagetoplogo11xx=98.0,Imagetoplogo22xx=231.0;
            DesctopTxx=9.0,DesctopTyy=456.0,Desctopww=396.0,Desctophh=101.0;
            
            Labelxx=86.0,Labelyy=309.0,Labelww=328.0,Labelhh=31.0;//Labelyy=321.0
            Labelbgxx=0,Labelbgyy=309.0,Labelbgww=414.0,Labelbghh=31.0;

            Labeltitlexx=9.0,Labeltitleyy=360.0,Labeltitleww=396.0,Labeltitlehh=97.0;
            Imageribbonxx=17.0,Imageribbonyy=300.0,Imageribbonww=49.0,Imageribbonhh=49.0;

     //difference y = -60
            
        }
        else
        {
            
            FrontImgxx=57.0,FrontImgyy=49.0,FrontImgww=206.0,FrontImghh=188;
            BackImgxx=57.0,BackImgyy=49.0,BackImgww=206.0,BackImghh=187.0;
            Lnamexx=14.0,Lnameyy=243.0,Lnameww=292.0,Lnamehh=55.0;
            Addressxx=14.0,Addressyy=298.0,Addressww=292.0,Addresshh=25.0;
            t1xx=84.0,t1yy=330,t1ww=41.0,t1hh=40.0,t2xx=139.0,t3xx=194.0;
            DescTxx=14.0,DescTyy=381.0,DescTww=292.0,DescThh=125.0;
            
            Imagetop1xx=0.0,Imagetop1yy=0.0,Imagetopww=320.0,Imagetop1hh=238.0;
            Imagetoplogoxx=14.0,Imagetoplogoyy=425.0,Imagetoplogoww=73.0,Imagetoplogohh=73.0,Imagetoplogo2xx=123.0,Imagetoplogo3xx=233.0,Imagetoplogo11xx=76.0,Imagetoplogo22xx=178.0;
            DesctopTxx=7.0,DesctopTyy=347.0,Desctopww=306.0,Desctophh=78.0;
            
            Labelxx=67.0,Labelyy=238.0,Labelww=253.0,Labelhh=24.0;
            Labelbgxx=0,Labelbgyy=238.0,Labelbgww=320,Labelbghh=24.0;
            
            Labeltitlexx=7.0,Labeltitleyy=273.0,Labeltitleww=306.0,Labeltitlehh=75.0;
            
            Imageribbonxx=13.0,Imageribbonyy=229.0,Imageribbonww=38.0,Imageribbonhh=38.0;
            
        }
        
        Image_TopcompnyImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,Imagetopww,Imagetop1hh)];
        Image_TopcompnyImage.image=[UIImage imageNamed:@"10154143609282724.jpg"];
        Image_TopcompnyImage.backgroundColor=[UIColor clearColor];
        Image_TopcompnyImage.contentMode=UIViewContentModeScaleToFill;
        
        Image_TopcompnyImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
       Label_AddressComp=[[UILabel alloc]initWithFrame:CGRectMake(Labelxx,Labelyy, Labelww,Labelhh)];

        Label_AddressCompbg=[[UILabel alloc]initWithFrame:CGRectMake(0,Labelbgyy, self.frame.size.width,Labelbghh)];
        

        Image_ribbon=[[UIImageView alloc]initWithFrame:CGRectMake(Imageribbonxx,Imageribbonyy,Imageribbonww,Imageribbonhh)];
        Image_ribbon.image=[UIImage imageNamed:@"ribbon.png"];
        Image_ribbon.backgroundColor=[UIColor clearColor];
        Image_ribbon.contentMode=UIViewContentModeScaleAspectFit;
        Image_ribbon.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

       
        
        [Label_AddressComp setTextAlignment:NSTextAlignmentLeft];
        Label_AddressComp.textColor = [UIColor blackColor];
        Label_AddressComp.font=[UIFont fontWithName:@"Helvetica" size:16.0f];

        
        Label_TitleCompany=[[UILabel alloc]initWithFrame:CGRectMake(Labeltitlexx,Labeltitleyy, Labeltitleww,Labeltitlehh)];
        Label_TitleCompany.numberOfLines=2;
        Label_TitleCompany.lineBreakMode=UILineBreakModeWordWrap;
        
        [Label_TitleCompany setTextAlignment:NSTextAlignmentCenter];
        Label_TitleCompany.textColor = [UIColor blackColor];
        Label_TitleCompany.font=[UIFont fontWithName:@"KG Feeling 22" size:30.0f];
        Label_TitleCompany.backgroundColor=[UIColor clearColor];
        
      Textview_DescCompany=[[UITextView alloc]initWithFrame:CGRectMake(DesctopTxx,DesctopTyy,Desctopww,Desctophh)];
        
         Textview_DescCompany.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       
        Textview_DescCompany.editable=NO;
        Textview_DescCompany.selectable=NO;
        Textview_DescCompany.scrollEnabled=NO;
        [Textview_DescCompany setTextAlignment:NSTextAlignmentCenter];
        Label_Desc.backgroundColor=[UIColor clearColor];
        Textview_DescCompany.textColor = [UIColor blackColor];
        Textview_DescCompany.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
        Textview_DescCompany.backgroundColor=[UIColor clearColor];
        
        
      
        
        
        Image_compnyLogo1=[[UIImageView alloc]initWithFrame:CGRectMake(Imagetoplogoxx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh)];
      
        Image_compnyLogo1.backgroundColor=[UIColor clearColor];
         Image_compnyLogo1.contentMode=UIViewContentModeScaleAspectFit;
        
        Image_compnyLogo2=[[UIImageView alloc]initWithFrame:CGRectMake(Imagetoplogo2xx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh)];
        Image_compnyLogo2.contentMode=UIViewContentModeScaleAspectFit;
     
        Image_compnyLogo2.backgroundColor=[UIColor clearColor];
        
        
        Image_compnyLogo3=[[UIImageView alloc]initWithFrame:CGRectMake(Imagetoplogo3xx,Imagetoplogoyy,Imagetoplogoww,Imagetoplogohh)];
        Image_compnyLogo3.contentMode=UIViewContentModeScaleAspectFit;
     
        Image_compnyLogo3.backgroundColor=[UIColor clearColor];
        
        
        
         Image_compnyLogo1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         Image_compnyLogo2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         Image_compnyLogo3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
         Label_AddressComp.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
         Label_TitleCompany.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

         [self addSubview:Image_TopcompnyImage];
        [self addSubview:Label_AddressCompbg];
        [self addSubview:Label_AddressComp];

        [self addSubview:Label_TitleCompany];
         [self addSubview:Textview_DescCompany];
        
         [self addSubview:Image_compnyLogo1];
         [self addSubview:Image_compnyLogo2];
         [self addSubview:Image_compnyLogo3];
        [self addSubview:Image_ribbon];
        
        
       
        defaults=[[NSUserDefaults alloc]init];
          checkstr=@"yes";
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
        [self addGestureRecognizer:tap];


       
        
        Label_Name = [[UILabel alloc]initWithFrame:CGRectMake(Lnamexx,Lnameyy,Lnameww, Lnamehh)];
        
        Label_Name.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        Label_Name.text = @"Sachin";
        [Label_Name setTextAlignment:NSTextAlignmentCenter];
        Label_Name.textColor = [UIColor blackColor];
        Label_Name.font=[UIFont fontWithName:@"KG Feeling 22" size:40.0f];
        Label_Name.backgroundColor=[UIColor clearColor];
        Label_CityCountry = [[UILabel alloc]initWithFrame:CGRectMake(Addressxx,Addressyy,Addressww, Addresshh)];
        
         Label_CityCountry.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
         Label_CityCountry.backgroundColor=[UIColor clearColor];
        Label_CityCountry.text = @"Mumbai, India";
        [Label_CityCountry setTextAlignment:NSTextAlignmentCenter];
        Label_CityCountry.textColor = [UIColor blackColor];
        Label_CityCountry.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
        
        
       
        
        
        Label_Emoji1 = [[UILabel alloc]initWithFrame:CGRectMake(t1xx,t1yy,t1ww, t1hh)];
          Label_Emoji1.backgroundColor=[UIColor clearColor];
        Label_Emoji1.text = @"👦";
        [Label_Emoji1 setTextAlignment:NSTextAlignmentCenter];
        Label_Emoji1.textColor = [UIColor blackColor];
        Label_Emoji1.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
        
        Label_Emoji2 = [[UILabel alloc]initWithFrame:CGRectMake(t2xx,t1yy,t1ww,t1hh)];
        Label_Emoji2.text = @"👧";
        [Label_Emoji2 setTextAlignment:NSTextAlignmentCenter];
        Label_Emoji2.textColor = [UIColor blackColor];
        Label_Emoji2.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
         Label_Emoji2.backgroundColor=[UIColor clearColor];
        
        Label_Emoji3 = [[UILabel alloc]initWithFrame:CGRectMake(t3xx,t1yy,t1ww,t1hh)];
        Label_Emoji3.text = @"👨";
        [Label_Emoji3 setTextAlignment:NSTextAlignmentCenter];
        Label_Emoji3.textColor = [UIColor blackColor];
        Label_Emoji3.font=[UIFont fontWithName:@"Helvetica" size:36.0f];
         Label_Emoji3.backgroundColor=[UIColor clearColor];
        
        
        
        
        
        
     
        
        
        Label_Desc = [[UITextView alloc]initWithFrame:CGRectMake(DescTxx,DescTyy,DescTww,DescThh)];
        Label_Desc.text = @"Label_Desc djfgwjdg wdfjwgjkwg wfg jkf jdegfgj fgsjfgs jfgjkfs djfdgsf sjfgdsj jfg dsjfgjs dfjsdf dsjfdsf sfjgsjdf  fffg jfgdsjf cfhdsfdsf sf dsfdshfdsf hfdhs fdhsfdsh dshfds fdsfhdsf dghfhdsds fdsf ";
        Label_Desc.editable=NO;
        Label_Desc.selectable=NO;
        Label_Desc.scrollEnabled=NO;
        [Label_Desc setTextAlignment:NSTextAlignmentCenter];
        Label_Desc.backgroundColor=[UIColor clearColor];
        Label_Desc.textColor = [UIColor blackColor];
        Label_Desc.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
        Label_Desc.backgroundColor=[UIColor clearColor];
         [self addSubview:Label_Name];
         [self addSubview:Label_CityCountry];
         [self addSubview:Label_Emoji1];
         [self addSubview:Label_Emoji2];
         [self addSubview:Label_Emoji3];
         [self addSubview:Label_Desc];
        
        Image_Left=[[UIButton alloc]initWithFrame:CGRectMake(10,24,28,28)];
        Image_Left.backgroundColor=[UIColor clearColor];
        [Image_Left setImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
        Image_Left.backgroundColor=[UIColor clearColor];
        [self addSubview:Image_Left];
        
        Image_Right=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-38,24,28,28)];
        Image_Right.backgroundColor=[UIColor clearColor];
        [Image_Right setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
      Image_Right.backgroundColor=[UIColor clearColor];
        [self addSubview:Image_Right];
       
        
       
        
        Front_imageprofile=[[UIImageView alloc]initWithFrame:CGRectMake(FrontImgxx,FrontImgyy,FrontImgww,FrontImghh)];
        Front_imageprofile.backgroundColor=[UIColor clearColor];
        Front_imageprofile.image=[UIImage imageNamed:@"10154143609282724.jpg"];
          Front_imageprofile.backgroundColor=[UIColor clearColor];
        [self addSubview:Front_imageprofile];
      
        Back_imageprofile=[[UIImageView alloc]initWithFrame:CGRectMake(BackImgxx,BackImgyy,BackImgww,BackImghh)];
        Back_imageprofile.backgroundColor=[UIColor clearColor];
        //Back_imageprofile.image=[UIImage imageNamed:@"frame.png"];
         [self addSubview:Back_imageprofile];
        
        Front_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
        Back_imageprofile.contentMode=UIViewContentModeScaleAspectFit;
        
  Back_imageprofile.backgroundColor=[UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
#warning placeholder stuff, replace with card-specific information }
        
        
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
        [self addGestureRecognizer:panGestureRecognizer];
      
        
    tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireScrollRectToVisible:)];
        [Front_imageprofile addGestureRecognizer:tap1];
        [self fireScrollRectToVisible:nil];
        
        overlayView1 = [[OverlayView1 alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       
        [self addSubview:overlayView1];
        
        overlayView1.hidden=YES;
        
        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height)];
        overlayView.alpha = 0;
        
        [self addSubview:overlayView];
        
       
        
    }
    return self;
}
- (void) fireScrollRectToVisible:(UIGestureRecognizer *) gesture
{
//    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
//    UIImageView *imageView = (UIImageView *)recognizer.view;
//    
//    NSLog(@"indextuches1:==%ld", (long)imageView.tag);
    if([checkstr isEqualToString:@"yes"])
    {
        
        overlayView1.hidden=YES;
        checkstr=@"no";
    }
    else
    {
        overlayView1.hidden=NO;
        checkstr=@"yes";
    }
}
-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//%%% called when you move your finger across the screen.
// called many times a second
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{

    
    
    
    
    xFromCenter =[gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter =[gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down
    
    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];
            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            
            
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
-(void)updateOverlay:(CGFloat)distance
{
      if (distance > 0) {
        overlayView.mode = GGOverlayViewModeRight;
        
       

    } else
    {
        overlayView.mode = GGOverlayViewModeLeft;
        
       

        
    }

   // overlayView.alpha = 1;
    overlayView.alpha = MIN(fabsf(distance)/15, 1);
    
}

//%%% called when the card is let go
- (void)afterSwipeAction
{
   
    if (xFromCenter > ACTION_MARGIN)
    {
       

        [self rightAction];
    }
    else if (xFromCenter < -ACTION_MARGIN)
    {
        [self leftAction];
    }
    else
    { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                            
                         }];
    }

}

- (void)rightClickAction2
{
    
    
    
}
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                        
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] == 0)
    {
        
        NSLog(@"App launch count 0");
        
        UIAlertView * alt=[[UIAlertView alloc]initWithTitle:@"Tip: Left swipes" message:@"If you left swipe on a profile it will be discarded and will not show up again on your search. Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Not Interested", nil];
        [alt show];

    }
    else
    {
        NSLog(@"App launch count %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"]);
        
        CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = finishPoint;
                         }completion:^(BOOL complete)
         {
             
             [self removeFromSuperview];
         }];
        
        [delegate cardSwipedLeft:self];
    }

    
    
    
//    UIAlertView * alt=[[UIAlertView alloc]initWithTitle:@"Not Interested?" message:@"Swiping left on a picture indicates you are not interested in this profile. This profile will not come up again, are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Not Interested", nil];
//    [alt show];
    
    
    NSLog(@"NO");
}

-(void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                       
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

-(void)leftClickAction
{
    if ([[defaults valueForKey:@"settingDone"]isEqualToString:@"yes"])
    {
        [self removeFromSuperview];
            CGPoint finishPoint = CGPointMake(-600, self.center.y);
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.center = finishPoint;
                                 self.transform = CGAffineTransformMakeRotation(-1);
                             }completion:^(BOOL complete){
        
                                 [self removeFromSuperview];
                             }];
    }
    else
    {
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                    
                         [self removeFromSuperview];
                     }];

    }
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
            CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
        
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.center = finishPoint;
                                                      }completion:^(BOOL complete)
                            {
        
                                 [self removeFromSuperview];
                             }];
            
            [delegate cardSwipedLeft:self];
        
        [[NSUserDefaults standardUserDefaults] setInteger:([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] + 1) forKey:@"AppLaunchCount"];
        
    }
    if (buttonIndex==0)
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                             
                         }];
        [[NSUserDefaults standardUserDefaults] setInteger:([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] + 1) forKey:@"AppLaunchCount"];
    }

}

@end
