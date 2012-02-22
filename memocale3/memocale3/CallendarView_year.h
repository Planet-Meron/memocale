//
//  CallendarView_year.h
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"

@protocol CalendarViewDelegate <NSObject>

- (void)dayButtonPressed:(DayButton *)button;

@optional
- (void)prevButtonPressed;
- (void)nextButtonPressed;

@end

@interface CallendarView_year : UIView<DayButtonDelegate>{
    id <CalendarViewDelegate> delegate;
    NSString *calendarFontname;
    UILabel *monthLabel;
    NSMutableArray *dayButtons;
    NSCalendar *calendar;
    float calendarWidth;
    float calendarHeight;
    float cellWidth;
    float cellHeight;
    int currentMonth;
    int currentYear;
    
}

@property(nonatomic, assign)id<CalendarViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName delegate:(id)theDelegate;
-(void)updateCalendarForMonth:(int)month forYear:(int)year;
-(void)drawDayButtons;
-(void)prevBtnPressed:(id)sender;
-(void)nextBtnPressed:(id)sender;

@end
