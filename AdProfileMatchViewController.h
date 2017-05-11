//
//  AdProfileMatchViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 2/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdProfileMatchViewController : UIViewController



@property(strong,nonatomic)IBOutlet UIImageView * profileImg1;

@property (strong,nonatomic)IBOutlet UILabel * Labelname;




@property (strong,nonatomic)IBOutlet UIButton * Button_letchat1;

-(IBAction)Button_Thanks:(id)sender;

@property (strong,nonatomic)NSMutableArray * AllArray_data;

@end
