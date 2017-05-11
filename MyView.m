//
//  MyView.m
//  UIPageControlDemo
//
//  Created by Spiel on 10/03/17.
//  Copyright © 2017 Neuron. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //init code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    }
    
    return self;
}

@end
