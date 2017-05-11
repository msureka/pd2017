//
//  DiscoverViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"





#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


@interface DiscoverViewController : UIViewController<DraggableViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property(strong,nonatomic)NSMutableArray * Array_AllDataProDisc;
@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (strong,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

@property (strong,nonatomic)IBOutlet UIImageView * ImageBack1;
@property (strong,nonatomic)IBOutlet UIImageView * Image_Animated;
@property(strong,nonatomic)IBOutlet UIImageView * profileImg;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView * indicatorView;

@property (strong,nonatomic)IBOutlet UILabel * LabelProf;
@property (strong,nonatomic)IBOutlet UILabel * LabelProf_No;
@property (strong,nonatomic)IBOutlet UILabel * LabelTapped;

@property (strong,nonatomic)IBOutlet UIView * DiscoverViewInfo;

@property (strong,nonatomic)IBOutlet UIButton * Button_Tapped;
-(IBAction)Button_pressed:(id)sender;



@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;

-(void)leftClickAction;
-(void)rightClickAction;
//-(void)leftAction;


// uday
@property (weak, nonatomic) IBOutlet UIView *bgViewDiscover;
@property (weak, nonatomic) IBOutlet UILabel *labelDiscover;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelDiscover;
@property (weak, nonatomic) IBOutlet UIButton *switchCountryButton;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabelDiscover;


- (IBAction)switchWhereButton:(id)sender;
-(void)loadProfileMethod;



@end
