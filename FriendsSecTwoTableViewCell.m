//
//  FriendsSecTwoTableViewCell.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "FriendsSecTwoTableViewCell.h"

@implementation FriendsSecTwoTableViewCell
@synthesize Image_proview;
- (void)awakeFromNib {
    [super awakeFromNib];
    Image_proview.clipsToBounds=YES;
    Image_proview.layer.cornerRadius=Image_proview.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
