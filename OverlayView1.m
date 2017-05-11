//
//  OverlayView1.m
//  testing swiping
//
//  Created by Spiel's Macmini on 1/13/17.
//  Copyright © 2017 Richard Kim. All rights reserved.
//

#import "OverlayView1.h"

@implementation OverlayView1
{
 NSString * English_str,*Arabic_str,*French_str;
    
    CGFloat Ispeakxx,Ispeakyy,Ispeakww,Ispeakhh;
    CGFloat lang1xx,lang1yy,lang1ww,lang1hh,lang2xx,lang3xx,lang4xx,lang5xx,lang6xx;
    CGFloat ilikeplayxx,ilikeplayyy,ilikeplayww,ilikeplayhh,ilikeplay2xx;
    CGFloat imglikeplayxx,imglikeplayyy,imglikeplayww,imglikeplayhh,imglikeplay2xx;
    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
    CGFloat myfavActxx,myfavActyy,myfavActww,myfavActhh;
//    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
    CGFloat activitesxx,activitesyy,activitesww,activiteshh,activites2xx,activites3xx;
    CGFloat myfavsupxx,myfavsupyy,myfavsupww,myfavsuphh;
    CGFloat suphroxx,suphroyy,suphroww,suphrohh;
}
@synthesize Label_Arabic,Label_French,Label_English,Label_LetMeet,Label_Suprhero,Label_Activity1,Label_Activity2,Label_Activity3,Label_LikePllay,label_Indoor,label_ispeack,label_Outdoor,labelFavsuperhero,labelfavActivities,image_letmeey,image_likeplay,image_flag,image_Cirlcle;
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
        {
             Ispeakxx=14.0,Ispeakyy=55.0,Ispeakww=297.0,Ispeakhh=22.0;
             lang1xx=14.0,lang1yy=83.0,lang1ww=92.0,lang1hh=29.0,lang2xx=41.0,lang3xx=114.0,lang4xx=172.0,lang5xx=213.0;
             ilikeplayxx=14.0,ilikeplayyy=164.0,ilikeplayww=136.0,ilikeplayhh=17.0,ilikeplay2xx=170.0;
             imglikeplayxx=59.0,imglikeplayyy=188.0,imglikeplayww=46.0,imglikeplayhh=46.0,imglikeplay2xx=215;
             outdorxx=14.0,outdoryy=241.0,outdorww=136.0,outdorhh=18.0,outdor2xx=170.0;
             myfavActxx=14.0,myfavActyy=310.0,myfavActww=292.0,myfavActhh=24.0;
            //    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
             activitesxx=14.0,activitesyy=345.0,activitesww=88.0,activiteshh=24.0,activites2xx=118.0,activites3xx=221.0;
             myfavsupxx=14.0,myfavsupyy=419.0,myfavsupww=292.0,myfavsuphh=23.0;
             suphroxx=72.0,suphroyy=451.0,suphroww=178.0,suphrohh=29.0;
        }
        else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
        {
             Ispeakxx=16.0,Ispeakyy=65.0,Ispeakww=self.frame.size.width-32,Ispeakhh=26.0;
             lang1xx=16.0,lang1yy=98.0,lang1ww=108.0,lang1hh=34.0,lang2xx=48.0,lang3xx=134.0,lang4xx=202.0,lang5xx=250.0;
             ilikeplayxx=16.0,ilikeplayyy=192,ilikeplayww=160.0,ilikeplayhh=21.0,ilikeplay2xx=199.0;
             imglikeplayxx=69.0,imglikeplayyy=221.0,imglikeplayww=54.0,imglikeplayhh=54.0,imglikeplay2xx=252;
             outdorxx=16.0,outdoryy=283,outdorww=160.0,outdorhh=21.0,outdor2xx=199.0;
             myfavActxx=16.0,myfavActyy=364,myfavActww=self.frame.size.width-32,myfavActhh=30.0;
            //    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
             activitesxx=16.0,activitesyy=405.0,activitesww=104.0,activiteshh=28.0,activites2xx=138.0,activites3xx=259.0;
             myfavsupxx=16.0,myfavsupyy=492.0,myfavsupww=self.frame.size.width-32,myfavsuphh=30.0;
             suphroxx=84.0,suphroyy=530.0,suphroww=209.0,suphrohh=34.0;
        }
        
        else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
        {
            
             Ispeakxx=18.0,Ispeakyy=72.0,Ispeakww=385.0,Ispeakhh=28.0;
             lang1xx=18.0,lang1yy=108.0,lang1ww=119.0,lang1hh=38.0,lang2xx=53.0,lang3xx=148.0,lang4xx=223.0,lang5xx=276.0;
             ilikeplayxx=18.0,ilikeplayyy=212.0,ilikeplayww=176.0,ilikeplayhh=23.0,ilikeplay2xx=220.0;
             imglikeplayxx=76.0,imglikeplayyy=244.0,imglikeplayww=60.0,imglikeplayhh=60.0,imglikeplay2xx=278;
             outdorxx=18.0,outdoryy=312.0,outdorww=176.0,outdorhh=23.0,outdor2xx=220.0;
             myfavActxx=18.0,myfavActyy=402.0,myfavActww=378.0,myfavActhh=31.0;
            //    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
             activitesxx=18.0,activitesyy=447.0,activitesww=114.0,activiteshh=31.0,activites2xx=152,activites3xx=286;
             myfavsupxx=18.0,myfavsupyy=543.0,myfavsupww=378.0,myfavsuphh=30.0;
             suphroxx=93.0,suphroyy=585.0,suphroww=230.0,suphrohh=37.0;
            
        }
        else
        {
            
            Ispeakxx=14.0,Ispeakyy=55.0,Ispeakww=297.0,Ispeakhh=22.0;
            lang1xx=14.0,lang1yy=83.0,lang1ww=92.0,lang1hh=29.0,lang2xx=41.0,lang3xx=114.0,lang4xx=172.0,lang5xx=213.0;
            ilikeplayxx=14.0,ilikeplayyy=164.0,ilikeplayww=136.0,ilikeplayhh=17.0,ilikeplay2xx=170.0;
            imglikeplayxx=59.0,imglikeplayyy=188.0,imglikeplayww=46.0,imglikeplayhh=46.0,imglikeplay2xx=215;
            outdorxx=14.0,outdoryy=241.0,outdorww=136.0,outdorhh=18.0,outdor2xx=170.0;
            myfavActxx=14.0,myfavActyy=310.0,myfavActww=292.0,myfavActhh=24.0;
            //    CGFloat outdorxx,outdoryy,outdorww,outdorhh,outdor2xx;
            activitesxx=14.0,activitesyy=345.0,activitesww=88.0,activiteshh=24.0,activites2xx=118.0,activites3xx=221.0;
            myfavsupxx=14.0,myfavsupyy=419.0,myfavsupww=292.0,myfavsuphh=23.0;
            suphroxx=72.0,suphroyy=451.0,suphroww=178.0,suphrohh=29.0;
            
        }

        
        
        self.backgroundColor = [UIColor whiteColor];
        
        image_flag = [[UIButton alloc]initWithFrame:CGRectMake(10,24,28,28)];
        
        image_Cirlcle = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-38,24,28,28)];
        [image_flag setImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
        
        image_Cirlcle.image=[UIImage imageNamed:@"circle2.png"];
        
        label_ispeack = [[UILabel alloc]initWithFrame:CGRectMake(Ispeakxx, Ispeakyy, Ispeakww, Ispeakhh)];
        label_ispeack.textAlignment=NSTextAlignmentCenter;
        
       
        
        
        
       
       
        
        
        label_ispeack.text=@"I speak";
         label_ispeack.font=[UIFont fontWithName:@"Helvetica-Light" size:16.0f];
        
        
        
        
        Label_English = [[UILabel alloc]init];
        
        Label_Arabic = [[UILabel alloc]init];
       
        Label_French = [[UILabel alloc]init];
        
       
        
       
        
        Label_LikePllay = [[UILabel alloc]initWithFrame:CGRectMake(ilikeplayxx, ilikeplayyy, ilikeplayww, ilikeplayhh)];
         Label_LikePllay.textAlignment=NSTextAlignmentCenter;
        Label_LikePllay.text=@"I like to play";
         Label_LikePllay.font=[UIFont fontWithName:@"Helvetica-Light" size:16.0f];
       
        
        Label_LetMeet = [[UILabel alloc]initWithFrame:CGRectMake(ilikeplay2xx, ilikeplayyy, ilikeplayww, ilikeplayhh)];
        Label_LetMeet.textAlignment=NSTextAlignmentCenter;
        Label_LetMeet.text=@"Lets meet";
          Label_LetMeet.font=[UIFont fontWithName:@"Helvetica-Light" size:16.0f];
        
        image_likeplay = [[UIImageView alloc]initWithFrame:CGRectMake(imglikeplayxx, imglikeplayyy, imglikeplayww, imglikeplayhh)];
       
        
        image_letmeey = [[UIImageView alloc]initWithFrame:CGRectMake(imglikeplay2xx, imglikeplayyy, imglikeplayww, imglikeplayhh)];
       

        
        
        label_Indoor = [[UILabel alloc]initWithFrame:CGRectMake(outdorxx,outdoryy, outdorww, outdorhh)];
        label_Indoor.textAlignment=NSTextAlignmentCenter;
          label_Indoor.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        
        label_Outdoor = [[UILabel alloc]initWithFrame:CGRectMake(outdor2xx,outdoryy, outdorww, outdorhh)];;
        label_Outdoor.textAlignment=NSTextAlignmentCenter;
          label_Outdoor.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        


        labelfavActivities = [[UILabel alloc]initWithFrame:CGRectMake(myfavActxx, myfavActyy,myfavActww, myfavActhh)];
        labelfavActivities.textAlignment=NSTextAlignmentCenter;
        labelfavActivities.text=@"My favorite activities are";
          labelfavActivities.font=[UIFont fontWithName:@"Helvetica-Light" size:16.0f];
        
        
     
      
        
        Label_Activity1 = [[UILabel alloc]initWithFrame:CGRectMake(activitesxx, activitesyy, activitesww, activiteshh)];
        Label_Activity1.textAlignment=NSTextAlignmentCenter;
          Label_Activity1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        
        [Label_Activity1 setAdjustsFontSizeToFitWidth:YES];
        
        
        
        Label_Activity2 = [[UILabel alloc]initWithFrame:CGRectMake(activites2xx, activitesyy, activitesww, activiteshh)];
        Label_Activity2.textAlignment=NSTextAlignmentCenter;
          Label_Activity2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        
           [Label_Activity2 setAdjustsFontSizeToFitWidth:YES];
        
        Label_Activity3 = [[UILabel alloc]initWithFrame:CGRectMake(activites3xx, activitesyy, activitesww, activiteshh)];
        Label_Activity3.textAlignment=NSTextAlignmentCenter;
          Label_Activity3.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        
         [Label_Activity3 setAdjustsFontSizeToFitWidth:YES];
        
        
        labelFavsuperhero = [[UILabel alloc]initWithFrame:CGRectMake(myfavsupxx, myfavsupyy,myfavsupww, myfavsuphh)];
        labelFavsuperhero.textAlignment=NSTextAlignmentCenter;
        labelFavsuperhero.text=@"My favorite superhero is";
           labelFavsuperhero.font=[UIFont fontWithName:@"Helvetica-Light" size:16.0f];
        
        Label_Suprhero = [[UILabel alloc]initWithFrame:CGRectMake(suphroxx, suphroyy, suphroww, suphrohh)];
        Label_Suprhero.textAlignment=NSTextAlignmentCenter;
           Label_Suprhero.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
       Label_Suprhero.backgroundColor=[UIColor colorWithRed:255/255.0 green:244/255.0 blue:96/255.0 alpha:1];
        Label_Suprhero.clipsToBounds=YES;
        Label_Suprhero.layer.cornerRadius=Label_Suprhero.frame.size.height/2;
       
        
        [self addSubview:Label_Arabic];
        [self addSubview:Label_French];
        [self addSubview:Label_English];
        [self addSubview:Label_LetMeet];
        [self addSubview:Label_Suprhero];
        [self addSubview:Label_Activity1];
        [self addSubview:Label_Activity2];
        [self addSubview:Label_Activity3];
        [self addSubview:Label_LikePllay];
        [self addSubview:label_Indoor];
        [self addSubview:label_ispeack];
        [self addSubview:label_Outdoor];
        [self addSubview:labelFavsuperhero];
        [self addSubview:labelfavActivities];
        [self addSubview:image_letmeey];
        [self addSubview:image_likeplay];
        [self addSubview:image_flag];
        [self addSubview:image_Cirlcle];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

}
@end
