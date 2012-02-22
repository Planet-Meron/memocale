//
//  MemoView.m
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/24.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "MemoView.h"

@implementation MemoView
@synthesize lbl_memo;
@synthesize lbl_color;
@synthesize delegate;
@synthesize atIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor orangeColor];
        CGRect lbl_frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        lbl_memo = [[UILabel alloc] initWithFrame:lbl_frame];
        atIndex = [[NSIndexPath alloc] init];
        lbl_memo.backgroundColor = [UIColor clearColor];
        lbl_memo.textAlignment = UITextAlignmentCenter;
        
        //CALayer
        CALayer *layer = self.layer;
        layer.shadowOffset = CGSizeMake(2.5, 2.5);
        layer.shadowColor = [[UIColor blackColor] CGColor];
        layer.shadowOpacity = 0.5;
        
        layer.cornerRadius = 3;
        
        [self addSubview:lbl_memo];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    startPoint = [[touches anyObject] locationInView:self];
    [self.superview bringSubviewToFront:self];
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint newPoint = [[touches anyObject] locationInView:self.superview];
    newPoint.x -= startPoint.x;
    newPoint.y -= startPoint.y;
    CGRect frm = [self frame];
    frm.origin = newPoint;
    [self setFrame:frm];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint presetPoint = [[touches anyObject] locationInView:self.superview];
    [delegate moveMemo:presetPoint number:atIndex];
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
