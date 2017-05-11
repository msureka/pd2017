//
//  DraggableView.h
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

/*
 
 Copyright (c) 2014 Choong-Won Richard Kim <cwrichardkim@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "OverlayView1.h"
@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface DraggableView : UIView<UIAlertViewDelegate>

@property (weak) id <DraggableViewDelegate> delegate;
@property(nonatomic,strong)OverlayView1* overlayView1;
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *tap1;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;



@property (nonatomic,strong)UIButton* Image_Left;
@property (nonatomic,strong)UIButton* Image_Right;
@property (nonatomic,strong)UIImageView* Back_imageprofile;
@property (nonatomic,strong)UIImageView* Front_imageprofile;
@property (nonatomic,strong)UILabel* Label_Name;
@property (nonatomic,strong)UILabel* Label_CityCountry;
@property (nonatomic,strong)UILabel* Label_Emoji1;
@property (nonatomic,strong)UILabel* Label_Emoji2;
@property (nonatomic,strong)UILabel* Label_Emoji3;
@property (nonatomic,strong)UITextView* Label_Desc;

@property (nonatomic,strong)UILabel* Label_Favtitle;

//%%% a placeholder for any card-specific information

-(void)leftClickAction;
-(void)rightClickAction;
//-(void)leftAction; //uday
-(void)rightClickAction2;


//add view outlet checked

@property (nonatomic,strong)UIImageView * Image_TopcompnyImage;;
@property (nonatomic,strong)UILabel* Label_AddressComp;
@property (nonatomic,strong)UILabel* Label_AddressCompbg;
@property (nonatomic,strong)UILabel* Label_TitleCompany;
@property (nonatomic,strong)UITextView* Textview_DescCompany;
@property (nonatomic,strong)UIImageView * Image_ribbon;

@property (nonatomic,strong)UIImageView * Image_compnyLogo1;
@property (nonatomic,strong)UIImageView * Image_compnyLogo2;
@property (nonatomic,strong)UIImageView * Image_compnyLogo3;

@end
