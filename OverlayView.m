//
//  OverlayView.m
//  testing swiping
//
//  Created by Richard Kim on 5/22/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#import "OverlayView.h"

@implementation OverlayView
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nope1"]];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode)
    {
        return;
    }
    
    _mode = mode;
    
    if(mode == GGOverlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"nope1"];
        
               
    } else {
        imageView.image = [UIImage imageNamed:@"heart"];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(50, 300, 150, 150);
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.center=self.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
