//
//  SinupStepOneViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "SinupStepOneViewController.h"
#import "YSHYClipViewController.h"

@interface SinupStepOneViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ClipViewControllerDelegate,UITextFieldDelegate>
{
    NSString * NextViewKey,*FrameGenderStr;
    UITapGestureRecognizer *ViewTap11,*ViewTap21,*ViewTap31,*ViewTap41,*ViewTap51,*ViewTap61;
    NSUserDefaults * defaults;
    
    UIImagePickerController * imagePicker;
    UIButton * btn;
    ClipType clipType;
    UIButton * circleBtn;
    UIButton * squareBtn;
    UITextField * textField ;
    CGFloat radius;
}
@end

@implementation SinupStepOneViewController
@synthesize ProfileImgButton,LabelDOB,Labelname,LabelAbout,LabelEmoji,LabelLives,LabelSpeak,LabelGender,ViewTap1,ViewTap2,ViewTap3,ViewTap4,ViewTap5,ViewTap6,HeadTopView,nextButton,Male_Button,Female_Button,Label_AddPic,Label_MumadI,ProfileBackImg;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    defaults=[[NSUserDefaults alloc]init];
    ProfileImgButton.clipsToBounds=YES;
    ProfileImgButton.layer.cornerRadius=ProfileImgButton.frame.size.height/2;
//    ProfileImgButton.layer.borderColor=[UIColor blackColor].CGColor;
//    ProfileImgButton.layer.borderWidth=2.0f;
    FrameGenderStr=@"no";
    ProfileImgButton.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    Male_Button.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    Female_Button.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];

        Male_Button.clipsToBounds=YES;
        Male_Button.layer.cornerRadius=Male_Button.frame.size.height/2;
        Female_Button.clipsToBounds=YES;
        Female_Button.layer.cornerRadius=Female_Button.frame.size.height/2;
    
    LabelEmoji.clipsToBounds=YES;
    LabelEmoji.layer.cornerRadius=LabelEmoji.frame.size.height/2;
    
    Label_AddPic.hidden=NO;
    Label_MumadI.hidden=NO;
    
    
    
    
    ProfileBackImg.image=[UIImage imageNamed:@"graypictureframe 1.png"];
    
    
   
     
    _TextField_Emoji11.delegate=self;
    _TextField_Emoji22.delegate=self;
    _TextField_Emoji33.delegate=self;
 

    
    CALayer *borderBottom1 = [CALayer layer];
    borderBottom1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom1.frame = CGRectMake(4, _TextField_Emoji11.frame.size.height - 4, _TextField_Emoji11.frame.size.width-8, 4);
    [_TextField_Emoji11.layer addSublayer:borderBottom1];
    
    CALayer *borderBottom2 = [CALayer layer];
    borderBottom2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom2.frame = CGRectMake(4, _TextField_Emoji22.frame.size.height - 4, _TextField_Emoji22.frame.size.width-8, 4);
    [_TextField_Emoji22.layer addSublayer:borderBottom2];
    
    CALayer *borderBottom3= [CALayer layer];
    borderBottom3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom3.frame = CGRectMake(4, _TextField_Emoji33.frame.size.height - 4, _TextField_Emoji33.frame.size.width-8,4);
    [_TextField_Emoji33.layer addSublayer:borderBottom3];
    
    
    
    
    
    
    
    
    
    
        CALayer *borderBottom = [CALayer layer];
        borderBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
        borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
        [HeadTopView.layer addSublayer:borderBottom];
    
        CALayer *borderTop = [CALayer layer];
        borderTop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    
        borderTop.frame = CGRectMake(0, 0, ViewTap1.frame.size.width, 1);
        [ViewTap1.layer addSublayer:borderTop];

        CALayer *borderTop2 = [CALayer layer];
        borderTop2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;;
    
        borderTop2.frame = CGRectMake(0, 0, ViewTap2.frame.size.width, 1);
        [ViewTap2.layer addSublayer:borderTop2];

        CALayer *borderTop3 = [CALayer layer];
        borderTop3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    
        borderTop3.frame = CGRectMake(0, 0, ViewTap3.frame.size.width, 1);
        [ViewTap3.layer addSublayer:borderTop3];

        CALayer *borderTop4 = [CALayer layer];
        borderTop4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    
        borderTop4.frame = CGRectMake(0, 0, ViewTap4.frame.size.width, 1);
        [ViewTap4.layer addSublayer:borderTop4];

//        CALayer *borderTop5 = [CALayer layer];
//        borderTop5.backgroundColor = [UIColor lightGrayColor].CGColor;
//    
//        borderTop5.frame = CGRectMake(0, 0, ViewTap5.frame.size.width, 1);
//        [ViewTap5.layer addSublayer:borderTop5];

        CALayer *borderTop6 = [CALayer layer];
        borderTop6.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    
        borderTop6.frame = CGRectMake(0, 0, ViewTap6.frame.size.width, 1);
        [ViewTap6.layer addSublayer:borderTop6];

    
    
    
    CALayer *borderBottomViewTap6 = [CALayer layer];
    borderBottomViewTap6.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottomViewTap6.frame = CGRectMake(0, ViewTap6.frame.size.height - 1, ViewTap6.frame.size.width, 1);
    [ViewTap6.layer addSublayer:borderBottomViewTap6];
    
   
    ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(ViewTap11Tapped:)];
    [ViewTap1 addGestureRecognizer:ViewTap11];
    
    ViewTap21 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap21Tapped:)];
    [ViewTap2 addGestureRecognizer:ViewTap21];
    
    ViewTap31 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap31Tapped:)];
    [ViewTap3 addGestureRecognizer:ViewTap31];
    
//    ViewTap41 =[[UITapGestureRecognizer alloc] initWithTarget:self
//                                                       action:@selector(ViewTap41Tapped:)];
//    [ViewTap4 addGestureRecognizer:ViewTap41];
    
    ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap51Tapped:)];
    [ViewTap5 addGestureRecognizer:ViewTap51];
    
    
    ViewTap61 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap61Tapped:)];
    [ViewTap6 addGestureRecognizer:ViewTap61];
    
    NSLog(@"DescAboutVV=%@",[defaults valueForKey:@"English"]);
    NSLog(@"DescAboutVV=%@", [defaults valueForKey:@"Arabic"]);
    
    
    if ([defaults valueForKey:@"Cityname"] !=nil)
    {
        LabelLives.text=[NSString stringWithFormat:@"%@%@%@", [defaults valueForKey:@"Cityname"],@", ",[defaults valueForKey:@"Countryname"]];
    }
     nextButton.enabled=NO;
    [nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    ProfileImgButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    ProfileImgButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    [ProfileImgButton setTitle:@"Mum & I\npicture" forState: UIControlStateNormal];
     [self ConfigUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"DescAboutSSS=%@",[defaults valueForKey:@"English"]);
    NSLog(@"DescAboutSSS=%@", [defaults valueForKey:@"Arabic"]);
    
   
     NSLog(@"ImageCheckImageCheck=%@", [defaults valueForKey:@"Proimage"]);

     [self registerForKeyboardNotifications];
    
   // [self.view removeFromSuperview];
    
    
    if ([defaults valueForKey:@"fname"] !=nil)
    {
        Labelname.text=[NSString stringWithFormat:@"%@",[defaults valueForKey:@"fname"]];
        
    }
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
        
        
        
        LabelDOB.text= newDateString;
        
        
        
//        LabelDOB.text=[defaults valueForKey:@"DOB"];
        
    }
    
    NSLog(@"GenderSinOne=%@",[defaults valueForKey:@"gender"]);
    if ([defaults valueForKey:@"gender"] !=nil)
    {
        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Boy"])
        {
             LabelGender.text=[NSString stringWithFormat:@"%@%@",[defaults valueForKey:@"gender"],@" \U0001F466"];
        }
        if ([[defaults valueForKey:@"gender"] isEqualToString:@"Girl"]) {
            LabelGender.text=[NSString stringWithFormat:@"%@%@",[defaults valueForKey:@"gender"],@" \U0001F467"];
            
            //\U0001F467
        }
    }
    if ([defaults valueForKey:@"Cityname"] !=nil && [defaults valueForKey:@"Countryname"] !=nil)
    {
        LabelLives.text=[NSString stringWithFormat:@"%@%@%@", [defaults valueForKey:@"Cityname"],@", ",[defaults valueForKey:@"Countryname"]];
    }
    
    NSLog(@"Enggggg=%@",[defaults valueForKey:@"English"]);
    NSLog(@"AAAAA=%@",[defaults valueForKey:@"Arabic"]);
    NSLog(@"FFFFFFF=%@",[defaults valueForKey:@"French"]);
    
    
//        if ([[defaults valueForKey:@"English"] isEqualToString:@"yes"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"no"]  && [[defaults valueForKey:@"French"] isEqualToString:@"no"])
//        {
//            LabelSpeak.text=@"English";
//        }
//    
//        else if ([[defaults valueForKey:@"Arabic"] isEqualToString:@"yes"] && [[defaults valueForKey:@"English"] isEqualToString:@"no"]  && [[defaults valueForKey:@"French"] isEqualToString:@"no"])
//        {
//            LabelSpeak.text=@"Arabic";
//        }
//        else if ([[defaults valueForKey:@"Arabic"] isEqualToString:@"no"] && [[defaults valueForKey:@"English"] isEqualToString:@"no"]  && [[defaults valueForKey:@"French"] isEqualToString:@"yes"])
//        {
//            LabelSpeak.text=@"French";
//        }
//                                                                              
//                                                                              
//        else if ([[defaults valueForKey:@"English"] isEqualToString:@"yes"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"yes"] && [[defaults valueForKey:@"French"] isEqualToString:@"yes"])
//        {
//            LabelSpeak.text=@"Engish, Arabic, French";
//        }
//                                                                              
//      else if([[defaults valueForKey:@"English"] isEqualToString:@"yes"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"yes"] && [[defaults valueForKey:@"French"]isEqualToString:@"no"])                                                                              {
//          LabelSpeak.text=@"Engish, Arabic";
//      }
//      else if([[defaults valueForKey:@"English"] isEqualToString:@"yes"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"no"] && [[defaults valueForKey:@"French"]isEqualToString:@"yes"])
//        {
//                LabelSpeak.text=@"Engish, French";
//      }
//else if([[defaults valueForKey:@"English"] isEqualToString:@"no"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"yes"] && [[defaults valueForKey:@"French"]isEqualToString:@"yes"])
//    {
//     LabelSpeak.text=@"Arabic, French";
//   }
//    else if ([[defaults valueForKey:@"English"] isEqualToString:@"no"] && [[defaults valueForKey:@"Arabic"] isEqualToString:@"no"] && [[defaults valueForKey:@"French"] isEqualToString:@"no"] )
//        {
//            LabelSpeak.text=@"";
//        }
//                                                                              
//    else
//    {
//       LabelSpeak.text=@"";
//    }
    
    NSLog(@"Languge defalts==%@",[defaults valueForKey:@"language"]);
    NSString * languge=[defaults valueForKey:@"language"];
    if (languge !=nil)
    {
        LabelSpeak.text=[defaults valueForKey:@"language"];
    }
    else
    {
        LabelSpeak.text=@"";
    }
    
    
    if ([defaults valueForKey:@"description"] !=nil) {
        LabelAbout.text=@"edit here";
    }
    else
    {
     LabelAbout.text=@"add here";
    }
    
    if (([defaults valueForKey:@"fname"] !=nil) &&([defaults valueForKey:@"DOB"] !=nil)&& ([defaults valueForKey:@"gender"] !=nil) && ([defaults valueForKey:@"description"] !=nil) && (![languge isEqualToString:@""]))
    {
        
        nextButton.enabled=YES;
        [nextButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
       }
    else
    {
         nextButton.enabled=NO;
         [nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    NSLog(@"DescAbout11=%@",[defaults valueForKey:@"English"]);
     NSLog(@"DescAbout11=%@", [defaults valueForKey:@"Arabic"]);
}
- (void)ViewTap11Tapped:(UITapGestureRecognizer *)recognizer
{

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NameView1ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"NameView1ViewController"];
   
    [self.navigationController pushViewController:set animated:YES];
}
- (void)ViewTap21Tapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DOBView2ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"DOBView2ViewController"];
 
    [self.navigationController pushViewController:set animated:YES];


}
- (void)ViewTap31Tapped:(UITapGestureRecognizer *)recognizer
{


    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GenderView3ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"GenderView3ViewController"];
  
    [self.navigationController pushViewController:set animated:YES];
}
//- (void)ViewTap41Tapped:(UITapGestureRecognizer *)recognizer
//{
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    LocationView4ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"LocationView4ViewController"];
// 
//    [self.navigationController pushViewController:set animated:YES];
//
//
//}
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LanguagesView5ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"LanguagesView5ViewController"];
    
    [self.navigationController pushViewController:set animated:YES];


}
- (void)ViewTap61Tapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AboutView6ViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"AboutView6ViewController"];

    [self.navigationController pushViewController:set animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)NextView:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SinupStepTwoViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SinupStepTwoViewController"];
    set.SelctedViewButton=NextViewKey;
    [self.navigationController pushViewController:set animated:YES];
}
-(IBAction)ChangeImageProfile:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 3;
    [popup showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
    if (buttonIndex== 0)
    {
      
        [defaults setObject:@"yes" forKey:@"CheckedView"];
        [defaults synchronize];
      
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
//        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
       [self presentViewController:picker animated:YES completion:nil];
      //  [self.navigationController pushViewController:picker animated:YES];
      // [self.navigationController presentModalViewController:picker animated:YES];
       }
    if (buttonIndex== 1)
    {
        
        [defaults setObject:@"no" forKey:@"CheckedView"];
        [defaults synchronize];
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
//        picker.allowsEditing = NO;

 [self presentViewController:picker animated:YES completion:nil];
        
          }
}
-(void)ConfigUI
{
//    btn = [UIButton buttonWithType:UIButtonTypeCustom]
//    ;
//    [btn setBackgroundColor:[UIColor redColor]];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setFrame:CGRectMake(self.view.frame.size.width/ 2 - 50, 100, 100, 100)];
//    [self.view addSubview:btn];
    
//    UILabel *label = [[UILabel alloc]init];
//    [label setText:@"上传头像"];
//    [label setFont:[UIFont systemFontOfSize:18.0]];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    [label setFrame:CGRectMake(self.view.frame.size.width/ 2 - 50, 215, 100, 15)];
//    [self.view addSubview:label];
    
//    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/ 2 - 110, 240, 150, 25)];
//    [label1 setText:@"选择裁剪类型:"];
//    [self.view addSubview:label1];
    
//    circleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [circleBtn setBackgroundColor:[UIColor redColor]];
//    [circleBtn setFrame:CGRectMake(self.view.frame.size.width/ 2 - 90, 270, 100, 20)];
//    [circleBtn setTitle:@"圆形裁剪" forState:UIControlStateNormal];
//    [circleBtn addTarget:self action:@selector(selectedClipType:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:circleBtn];
    
//    squareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [squareBtn setFrame:CGRectMake(self.view.frame.size.width/ 2 + 10, 270, 100, 20)];
//    [squareBtn setTitle:@"方形裁剪" forState:UIControlStateNormal];
//    [squareBtn addTarget:self action:@selector(selectedClipType:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:squareBtn];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/ 2 - 110, 300, 210, 25)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.borderStyle = UITextBorderStyleRoundedRect;
   //textField.placeholder = @"请输入裁剪半径 默认120";
//[self.view addSubview:textField];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
   
  
//     NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:@"public.image"])
//    {
//        image = [info objectForKey:UIImagePickerControllerEditedImage];
//      
//    }
//    else
//    {
//         image= info[UIImagePickerControllerOriginalImage];
//    }
//    
//
    
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    YSHYClipViewController * clipView = [[YSHYClipViewController alloc]initWithImage:image];
    
    
    
    
    clipView.delegate = self;
    clipView.clipType = clipType; //支持圆形:CIRCULARCLIP 方形裁剪:SQUARECLIP   默认:圆形裁剪
//    if(![textField.text isEqualToString:@""])
//    {
//        radius =textField.text.intValue;
      clipView.radius = 120;   //设置 裁剪框的半径  默认120
//    }
    //   clipView.scaleRation = 5;// 图片缩放的最大倍数 默认为10
    [picker pushViewController:clipView animated:YES];
    
}

#pragma mark - ClipViewControllerDelegate
-(void)ClipViewController:(YSHYClipViewController *)clipViewController FinishClipImage:(UIImage *)editImage
{
    [ProfileImgButton setTitle:@"" forState:UIControlStateNormal];
    
    Label_AddPic.hidden=YES;
    Label_MumadI.hidden=YES;
    [ProfileImgButton setBackgroundImage:editImage forState:UIControlStateNormal];
   
     NSData *imageData = UIImageJPEGRepresentation(editImage, 0.0);
    [defaults setObject:imageData forKey:@"Proimage"];
    [defaults synchronize];
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
        
        
        Label_AddPic.hidden=YES;
        Label_MumadI.hidden=YES;
        NSLog(@"ImageCheck==%@",[defaults valueForKey:@"Proimage"]);
        [ProfileImgButton setTitle:@"" forState:UIControlStateNormal];
        [ProfileImgButton setBackgroundImage:editImage forState:UIControlStateNormal];
     
    }];;
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



-(IBAction)Button_Male:(id)sender
{
    Male_Button.enabled=YES;
    
    ProfileBackImg.image=[UIImage imageNamed:@"boypictureframe 1.png"];
   
    Male_Button.backgroundColor=[UIColor colorWithRed:220/255.0 green:242/255.0 blue:253/255.0 alpha:1];
 
   // Male_Button.backgroundColor=[UIColor yellowColor];
    Female_Button.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];

    [defaults setObject:@"Boy" forKey:@"gender"];
    [defaults synchronize];
    
   
}
-(IBAction)Button_Female:(id)sender
{
    Female_Button.enabled=YES;
     ProfileBackImg.image=[UIImage imageNamed:@"girlpictureframe 1.png"];
    //Female_Button.backgroundColor=[UIColor yellowColor];
    
      Female_Button.backgroundColor=[UIColor colorWithRed:250/255.0 green:207/255.0 blue:214/255.0 alpha:1];
    Male_Button.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    
    [defaults setObject:@"Girl" forKey:@"gender"];
    [defaults synchronize];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
      [self.view endEditing:YES];
    [textField resignFirstResponder];
  
}
- (void)registerForKeyboardNotifications
{
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:true];
[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
 
    
    [defaults setObject:self.TextField_Emoji11.text forKey:@"emoji1"];
    [defaults setObject:self.TextField_Emoji22.text forKey:@"emoji2"];
    [defaults setObject:self.TextField_Emoji33.text forKey:@"emoji3"];
    [defaults synchronize];
}


@end
