//
//  CallendarView_year.m
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "CallendarView_year.h"

@implementation CallendarView_year
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName delegate:(id)theDelegate
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
        self.delegate = theDelegate;
        
        //initialization
        calendarFontname = fontName;
        calendarWidth = frame.size.width;
        calendarHeight = frame.size.height;
        cellWidth = frame.size.width/7.0f;
        cellHeight = frame.size.height/9.0f;
        
        //Viewproperties背景とか
        
        //Set up the calendar header
        //Back Button
        UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevBtn setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
        prevBtn.frame = CGRectMake(0, cellHeight, cellWidth, cellHeight);
        [prevBtn addTarget:self action:@selector(prevBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Next Button 
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
        nextBtn.frame = CGRectMake(calendarWidth-cellWidth, cellHeight, cellWidth, cellHeight);
        [nextBtn addTarget:self action:@selector(nextBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Top Labbel
        CGRect monthLabelFrame = CGRectMake(cellWidth, cellHeight, calendarWidth-cellWidth*2, cellHeight);
        monthLabel = [[UILabel alloc] initWithFrame:monthLabelFrame];
        monthLabel.font = [UIFont fontWithName:calendarFontname size:18];
        monthLabel.textAlignment = UITextAlignmentCenter;
        monthLabel.backgroundColor = [UIColor clearColor];
        monthLabel.textColor = [UIColor blackColor];
        
        //Add the calendar header to view
        [self addSubview:prevBtn];
        [self addSubview:nextBtn];
        [self addSubview:monthLabel];
        
        //add the day labels to the view
        NSString *days[7] ={@"月曜",@"火曜",@"水曜",@"木曜",@"金曜",@"土曜",@"日曜"};
        for (int i = 0; i<7; i++) {
            CGRect dayLabelFrame = CGRectMake(cellWidth*i, cellHeight*2, cellWidth, cellHeight);
            UILabel *dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
            dayLabel.text = [NSString stringWithFormat:@"%@",days[i]];
            dayLabel.textAlignment =UITextAlignmentCenter;
            dayLabel.backgroundColor = [UIColor clearColor];
            dayLabel.font = [UIFont fontWithName:calendarFontname size:16.0f];
            dayLabel.textColor = [UIColor blackColor];
            
            [self addSubview:dayLabel];
            [dayLabel release];
        }
        
        [self drawDayButtons];
        
        //Set the current month and year and update the calendar
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit |NSDayCalendarUnit;
        NSDateComponents *dataParts = [calendar components:unitFlags fromDate:[NSDate date]];
        
        currentMonth =[dataParts month];
        currentYear = [dataParts year];
        
        [self updateCalendarForMonth:currentMonth forYear:currentYear];
        
    }
    return self;
}

- (void)updateCalendarForMonth:(int)month forYear:(int)year{
    char *months[12] = {"January","Febrary","March","April","May","June","July","August","SeptemBer","OctoBer","November","December"};
    monthLabel.text = [NSString stringWithFormat:@"%s %d",months[month-1],year];
    
    //Get the first day of the month
    NSDateComponents *dateParts = [[NSDateComponents alloc] init];
    [dateParts setMonth:month];
    [dateParts setYear:year];
    [dateParts setDay:1];
    NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
    [dateParts release];
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
    int weekdayOfFirst = [weekdayComponents weekday];
    NSLog(@"%d",weekdayOfFirst);
    
    //weekdayの設定は1は日曜日、２が月曜日と一つずれてるので
    if (weekdayOfFirst == 1) {
        weekdayOfFirst = 7;
    }else{
        --weekdayOfFirst;
    }
    
    int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:dateOnFirst].length;
    
    int day = 1;
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
            int buttonNumber = i*7 +j;
            
            DayButton *button = [dayButtons objectAtIndex:(buttonNumber)];
            
            button.enabled = NO;
            [button setTitle:nil forState:UIControlStateNormal];
            [button setButtonDate:nil];
            
            if (buttonNumber >= (weekdayOfFirst-1) && day <= numDaysInMonth ) {
                [button setTitle:[NSString stringWithFormat:@"%d",(day)] forState:UIControlStateNormal];
                NSDateComponents *dateParts = [[NSDateComponents alloc] init];
                [dateParts setYear:year];
                [dateParts setMonth:month];
                [dateParts setDay:day];
                NSDate *buttonDate = [calendar dateFromComponents:dateParts];
                [dateParts release];
                [button setButtonDate:buttonDate];
                
                button.enabled = YES;
                ++day;
                
            }
        }
    }
}

- (void)drawDayButtons{
        dayButtons = [[NSMutableArray alloc] initWithCapacity:42];
    for (int i = 1; i<7; i++) {
        for (int j = 0; j<7; j++) {
            CGRect buttonFrame = CGRectMake(j*cellWidth, (i+2)*cellHeight, cellWidth, cellHeight);
            DayButton *dayButton = [[DayButton alloc] buttonWithFrame:buttonFrame];
            dayButton.titleLabel.font = [UIFont fontWithName:calendarFontname size:14];
            dayButton.delegate = self;
            
            [dayButtons addObject:dayButton];
            [dayButton release];
            
            [self addSubview:[dayButtons lastObject]];
        }
    }

}

- (void)prevBtnPressed:(id)sender{
    if (currentMonth == 1) {
        currentMonth = 12;
        currentYear--;
    }else{
        currentMonth--;
    }
    
    [self updateCalendarForMonth:currentMonth forYear:currentYear];
    
}

- (void)nextBtnPressed:(id)sender{
    if (currentMonth == 12) {
        currentMonth = 1;
        currentYear++;
    }else{
        currentMonth++;
    }
    
    [self updateCalendarForMonth:currentMonth forYear:currentYear];
    
}

//Button delegate
- (void)dayButtonPressed:(id)sender{
    DayButton *dayButton = (DayButton *) sender;
    [self.delegate dayButtonPressed:dayButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc{
    [super dealloc];
    [calendar release];
    [dayButtons release];
}

@end
