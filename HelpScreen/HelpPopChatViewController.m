//
//  HelpPopChatViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 7/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "HelpPopChatViewController.h"

@interface HelpPopChatViewController ()

@end

@implementation HelpPopChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]];
   
     // [_View_Frame setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    //[_View_Frame setBackgroundColor:[UIColor blackColor]];
    
    _View_Frame.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85f];
    _Button_Next.clipsToBounds=YES;
    _Button_Next.layer.cornerRadius=_Button_Next.frame.size.height/2;
    _Button_Next.layer.borderWidth=1.0f;
    _Button_Next.layer.borderColor=[UIColor whiteColor].CGColor;

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
