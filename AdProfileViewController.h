//
//  AdProfileViewController.h
//  Play_Date
//
//  Created by Spiel's Macmini on 2/9/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdProfileViewController : UIViewController
@property (nonatomic,strong)IBOutlet UIImageView * Image_TopcompnyImage;;
@property (nonatomic,strong)IBOutlet UILabel* Label_AddressComp;
@property (strong, nonatomic) IBOutlet UILabel *Label_AddressCompBG;

@property (nonatomic,strong)IBOutlet UILabel* Label_TitleCompany;
@property (nonatomic,strong)IBOutlet UITextView* Textview_DescCompany;

@property (nonatomic,strong)IBOutlet UIImageView * Image_compnyLogo1;
@property (nonatomic,strong)IBOutlet UIImageView * Image_compnyLogo2;
@property (nonatomic,strong)IBOutlet UIImageView * Image_compnyLogo3;

@property (nonatomic,strong)IBOutlet UIImageView * Image_compnyLogo2_Extra;
@property (nonatomic,strong)IBOutlet UIImageView * Image_compnyLogo3_Extra;

@property (nonatomic,strong) NSMutableArray * Array_LodingPro;

@property (nonatomic,strong)IBOutlet UILabel* label_fname;
-(IBAction)Back_buttonView:(id)sender;

@end
