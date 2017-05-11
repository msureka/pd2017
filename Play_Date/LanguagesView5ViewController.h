//
//  LanguagesView5ViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenderViewTableViewCell.h"
@interface LanguagesView5ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
-(IBAction)BackView:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)IBOutlet UITableView * Table_Gender;

@property(nonatomic,strong)GenderViewTableViewCell * cell_Gender;
@end
