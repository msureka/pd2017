//
//  HelpPopViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 7/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "HelpPopViewController.h"

@interface HelpPopViewController ()

@end

@implementation HelpPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _View_Frame.clipsToBounds=YES;
    _View_Frame.layer.cornerRadius=15.0f;
//    _Label_title.text = @"Welcome to the new\nPlay:Date!";
//    _Label_title.lineBreakMode = UILineBreakModeWordWrap;
//    _Label_title.numberOfLines = 0;
//    
//    _Label_Description.text = @"Hellow friends! we have added a few fun features for you.\n You can now create Meet-ups and invite your friends to your Play:Date!";
//    _Label_Description.lineBreakMode = UILineBreakModeWordWrap;
//    _Label_Description.numberOfLines = 0;
    
    _Button_tour.clipsToBounds=YES;
    _Button_tour.layer.cornerRadius=_Button_tour.frame.size.height/2;
    _Button_tour.layer.borderWidth=1.0f;
    _Button_tour.layer.borderColor=[UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
