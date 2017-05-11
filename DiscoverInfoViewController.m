//
//  DiscoverInfoViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/9/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "DiscoverInfoViewController.h"
#import "DiscoverUserProfileinfoViewController.h"
@interface DiscoverInfoViewController ()

@end

@implementation DiscoverInfoViewController
@synthesize Label_Arabic,Label_French,Label_English,Label_LetMeet,Label_Suprhero,Label_Activity1,Label_Activity2,Label_Activity3,Label_LikePllay,image_letmeey,image_likeplay,Alldata_Array;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    Label_Arabic.clipsToBounds=YES;
    Label_Arabic.layer.cornerRadius=Label_Arabic.frame.size.height/2;
    
    Label_French.clipsToBounds=YES;
    Label_French.layer.cornerRadius=Label_French.frame.size.height/2;
    
    Label_English.clipsToBounds=YES;
    Label_English.layer.cornerRadius=Label_English.frame.size.height/2;
    
    Label_LetMeet.clipsToBounds=YES;
    Label_LetMeet.layer.cornerRadius=Label_LetMeet.frame.size.height/2;
    
    Label_Suprhero.clipsToBounds=YES;
    Label_Suprhero.layer.cornerRadius=Label_Suprhero.frame.size.height/2;
    
    Label_Activity1.clipsToBounds=YES;
    Label_Activity1.layer.cornerRadius=Label_Activity1.frame.size.height/2;
    
    Label_Activity2.clipsToBounds=YES;
    Label_Activity2.layer.cornerRadius=Label_Activity2.frame.size.height/2;
    
    Label_Activity3.clipsToBounds=YES;
    Label_Activity3.layer.cornerRadius=Label_Activity3.frame.size.height/2;
    
    Label_LikePllay.clipsToBounds=YES;
    Label_LikePllay.layer.cornerRadius=Label_LikePllay.frame.size.height/2;
    
    image_letmeey.clipsToBounds=YES;
    image_letmeey.layer.cornerRadius=image_letmeey.frame.size.height/2;
    
    image_likeplay.clipsToBounds=YES;
    image_likeplay.layer.cornerRadius=image_likeplay.frame.size.height/2;
    
    NSLog(@"ArrayInfo of==%@",Alldata_Array);
    
    UITapGestureRecognizer  * ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap11Tapped:)];
    [self.view addGestureRecognizer:ViewTap11];
    


}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
 // [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)closedd11:(id)sender
{
    [self.view endEditing:YES];
    self.view.hidden=YES;
    
}
- (void)ViewTap11Tapped:(UITapGestureRecognizer *)recognizer
{
  // [self dismissViewControllerAnimated:YES completion:nil];

   
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Close_Button:(id)sender
{
  //  [self performSegueWithIdentifier:@"back" sender:self];
}

@end
