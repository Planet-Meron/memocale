//
//  DayButton.m
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "DayButton.h"

@implementation DayButton
@synthesize delegate,buttonDate;

- (id)buttonWithFrame:(CGRect)buttonFrame{
    self = [DayButton buttonWithType:UIButtonTypeCustom];
    
    self.frame = buttonFrame;
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self addTarget:delegate action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UILabel *titleLabel = [self titleLabel];
    CGRect labelFrame = titleLabel.frame;
    int framePadding = 4;
    labelFrame.origin.x = self.bounds.size.width - labelFrame.size.width -framePadding;
    labelFrame.origin.y = framePadding;
    
    [self titleLabel].frame = labelFrame;
    
}

- (void)dealloc{
    [super dealloc];
}

@end
