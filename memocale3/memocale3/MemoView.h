//
//  MemoView.h
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/24.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol MemoViewDelegate;



@interface MemoView : UIView{
    CGPoint startPoint;
    UILabel *lbl_memo;
    NSIndexPath *atIndex;
    id <MemoViewDelegate> delegate;
}

@property (nonatomic, retain)UILabel *lbl_memo;
@property (nonatomic, copy)UIColor *lbl_color;
@property (nonatomic, assign)id <MemoViewDelegate> delegate;
@property (nonatomic, retain)NSIndexPath *atIndex;

@end

@protocol MemoViewDelegate <NSObject>

- (void)moveMemo:(CGPoint)origin number:(NSIndexPath *)atIndex;

@end