//
//  TutorialPagesViewController.h
//  Play_Date
//
//  Created by Spiel on 08/03/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialPagesViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *  title4;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonGotIt;
- (IBAction)GotItAction:(id)sender;



@end
