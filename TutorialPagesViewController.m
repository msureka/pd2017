//
//  TutorialPagesViewController.m
//  Play_Date
//
//  Created by Spiel on 08/03/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "TutorialPagesViewController.h"
#import "MainProfilenavigationController.h"

@interface TutorialPagesViewController ()

{
    CGFloat screenWidth;
    NSUserDefaults *defaults;
}

@end

@implementation TutorialPagesViewController
@synthesize scrollView,pageControl,buttonGotIt;

- (void)viewDidLoad {
    
    title4.hidden = YES;
    buttonGotIt.hidden = YES;
    
    defaults = [[NSUserDefaults alloc]init];
    
    self.buttonGotIt.layer.borderColor=[UIColor whiteColor].CGColor;
    self.buttonGotIt.layer.borderWidth=2;
    self.buttonGotIt.layer.cornerRadius =self.buttonGotIt.frame.size.height/2;
    self.buttonGotIt.layer.masksToBounds = YES;
    
    
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;// - 49;
    
//    if(screenWidth == 320)
//    {
//        screenWidth = [UIScreen mainScreen].bounds.size.width - 41;
//    }
//    if(screenWidth == 375)
//    {
//        screenWidth = [UIScreen mainScreen].bounds.size.width - 49;
//    }
//    if(screenWidth == 414)
//    {
//        screenWidth = [UIScreen mainScreen].bounds.size.width - 54;
//    }
//    
    
    
    scrollView.contentSize=CGSizeMake(screenWidth*4, scrollView.frame.size.height);
    scrollView.delegate = self;
    
    
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MyView" owner:self options:nil];
    UIView *myView = [nibContents objectAtIndex:0];
    myView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:myView];
    
    
    NSArray *nibContents1 = [[NSBundle mainBundle] loadNibNamed:@"MyView1" owner:self options:nil];
    UIView *myView1 = [nibContents1 objectAtIndex:0];
    myView1.frame = CGRectMake(screenWidth, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:myView1];
    
    NSArray *nibContents2 = [[NSBundle mainBundle] loadNibNamed:@"MyView2" owner:self options:nil];
    UIView *myView2 = [nibContents2 objectAtIndex:0];
    myView2.frame = CGRectMake(screenWidth*2, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:myView2];
    
    NSArray *nibContents3 = [[NSBundle mainBundle] loadNibNamed:@"MyView3" owner:self options:nil];
    UIView *myView3 = [nibContents3 objectAtIndex:0];
    myView3.frame = CGRectMake(screenWidth*3, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:myView3];

    
    
//    for (int i =0; i<4; i++)
//    {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth*i , 0, scrollView.frame.size.width, scrollView.frame.size.height)];
//        if (i==0)
//        {
//            // imageView.backgroundColor = [UIColor redColor];
//            imageView.image = [UIImage imageNamed:@"tutorial1"];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            
//            //titleLabel.text = @"if you like the profile";
//            
//        }
//        else if (i==1)
//        {
//            // imageView.backgroundColor = [UIColor blackColor];
//            imageView.image = [UIImage imageNamed:@"tutorial2"];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            // titleLabel.text = @"to skip this profile";
//            
//        }
//        else if (i==2)
//        {
//            //imageView.backgroundColor = [UIColor blackColor];
//            imageView.image = [UIImage imageNamed:@"tutorial3"];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            // titleLabel.text = @"for more information on this profile";
//        }
//        else
//        {
//            //imageView.backgroundColor = [UIColor yellowColor];
//            imageView.image = [UIImage imageNamed:@"tutorial4"];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            //titleLabel.text = @"a match is made when two parties swipe right on each others profile.";
//        }
//        
//        [scrollView addSubview:imageView];
//    }
    
    
    [super viewDidLoad];
    
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
#pragma mark changePage

- (IBAction)changePage:(id)sender
{
    
    [scrollView scrollRectToVisible:CGRectMake(screenWidth*pageControl.currentPage, scrollView.frame.origin.y, screenWidth, scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    
    [self setIndiactorForCurrentPage];
    
}

-(void)setIndiactorForCurrentPage
{
    uint page = scrollView.contentOffset.x / screenWidth;
   
    [pageControl setCurrentPage:page];
    
    if (page == 0)
    {
//        titleLabel.numberOfLines=1;
//        titleLabel.text = @"if you like the profile";
//        title4.hidden = YES;
        buttonGotIt.hidden = YES;
        [pageControl setHidden:NO];
    }
    else if(page == 1)
    {
//        titleLabel.numberOfLines = 1;
//        titleLabel.text = @"to skip this profile";
//        title4.hidden = YES;
        buttonGotIt.hidden = YES;
        [pageControl setHidden:NO];
        
    }
    else if(page == 2)
    {
//        titleLabel.numberOfLines = 2;
//        titleLabel.text = @"for more information                               on this profile";//30
//        title4.hidden = YES;
        buttonGotIt.hidden = YES;
        [pageControl setHidden:NO];
    }
    else
    {
//        titleLabel.numberOfLines = 2;
//        titleLabel.text = @"a match is made when two parties swipe right on each others profile.";
//        title4.hidden = NO;
        buttonGotIt.hidden = NO;
        [pageControl setHidden:YES];
    }
    
}
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
