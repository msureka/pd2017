//
//  MeetupDetailCellTableViewCell.h
//  Play_Date
//
//  Created by Spiel's Macmini on 6/23/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetupDetailCellTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel * label_createdname;
@property(nonatomic,strong)IBOutlet UILabel * label_createdtime;
@property(nonatomic,strong)IBOutlet UIImageView * Image_CreatedProfilepic;
@property(nonatomic,strong)IBOutlet UILabel * label_title;
@property(nonatomic,strong)IBOutlet UILabel * label_location;
@property(nonatomic,strong)IBOutlet UILabel * label_datetime;
@property(nonatomic,strong)IBOutlet UILabel * label_eventcode;
@end
