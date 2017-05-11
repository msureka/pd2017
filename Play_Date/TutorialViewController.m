//
//  TutorialViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 2/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "TutorialViewController.h"
#import "MainProfilenavigationController.h"
#import "ProfileUserViewController.h"

@interface TutorialViewController ()

{
    NSUserDefaults *defaults;
}

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults = [[NSUserDefaults alloc]init];
    
    self.buttonGotIt.layer.borderColor=[UIColor whiteColor].CGColor;
    self.buttonGotIt.layer.borderWidth=2;
    self.buttonGotIt.layer.cornerRadius =self.buttonGotIt.frame.size.height/2;
    self.buttonGotIt.layer.masksToBounds = YES;

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

- (IBAction)GotItAction:(id)sender
{
    
    if ([[defaults valueForKey:@"tutseen"] isEqualToString:@"YES"])
    {
//       ProfileUserViewController *puvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileUserViewController"];
//        [self.navigationController pushViewController:puvc animated:YES];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [defaults setObject:@"no" forKey:@"tutseen"];
        
    }
    else
    {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainProfilenavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
    }
    
}
@end
