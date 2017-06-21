//
//  AttendingMeetupTableViewCell.h
//  Play_Date
//
//  Created by Spiel's Macmini on 6/19/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendingMeetupTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIScrollView * myscrollView;
@property(nonatomic,strong)IBOutlet UILabel * label_count;
@property(nonatomic,strong)IBOutlet UILabel * label_AttendingCount;

@end
