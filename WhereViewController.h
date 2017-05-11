//
//  WhereViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 1/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenderViewTableViewCell.h"
@interface WhereViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
-(IBAction)BackView:(id)sender;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;
@property(nonatomic,strong)IBOutlet UITableView * Table_Gender;

@property(nonatomic,strong)GenderViewTableViewCell * cell_Gender;
@end
