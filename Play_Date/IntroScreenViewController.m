//
//  IntroScreenViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 2/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "IntroScreenViewController.h"
#import "MainProfilenavigationController.h"
#import "TutorialViewController.h"
#import "TutorialPagesViewController.h"
@interface IntroScreenViewController ()

@end

@implementation IntroScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  UITapGestureRecognizer *  ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(ViewTap11Tapped:)];
    [self.view addGestureRecognizer:ViewTap11];

    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ViewTap11Tapped:(UITapGestureRecognizer *)recognizer
{
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        MainProfilenavigationController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
//        [[UIApplication sharedApplication].keyWindow setRootViewController:Home_add];
    
//    TutorialViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
//    [self.navigationController pushViewController:tvc animated:YES];
    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    TutorialViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
//    [self.navigationController pushViewController:set animated:YES];TutorialPagesViewController
    
    
    TutorialPagesViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialPagesViewController"];
    [self.navigationController pushViewController:tvc animated:YES];
    
}
@end
