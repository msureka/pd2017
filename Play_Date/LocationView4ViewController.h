//
//  LocationView4ViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationView4ViewController : UIViewController<CLLocationManagerDelegate>
-(IBAction)BackView:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;

@property(nonatomic,strong)IBOutlet UITextField * City_Txt;
@property(nonatomic,strong)IBOutlet UITextField * Country_Txt;






@end
