//
//  MymeetupsTableViewCell.h
//  Play_Date
//
//  Created by Spiel's Macmini on 6/15/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MymeetupsTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * Image_proview;
@property(strong,nonatomic)IBOutlet UILabel * Label_name;
@property(strong,nonatomic)IBOutlet UILabel * Label_chatInfo;
@property(strong,nonatomic)IBOutlet UILabel * Label_Date;
@property(strong,nonatomic)IBOutlet UIImageView * Image_messagered;
@end
