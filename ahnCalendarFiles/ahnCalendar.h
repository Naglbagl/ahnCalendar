//
//  ahnCalendar.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnDatesView.h"
#import "NSDate+NSDate_ahnDateComponents.h"
#import "ahnCalendarHelper.h"
#import "ahnEvent.h"
#define kCalendarXPadding 20
#define kCalendarYPadding 35
#define kAnimationDuration .4
@protocol ahnCalendarDelegate <NSObject>
@required
- (void)calendarWasTappedOnDay:(int)day month:(int)month year:(int)year withEvent:(ahnEvent *)event;
@end


@interface ahnCalendar : UIView <ahnCalendarCellViewDelegate>{
    UILabel *lbMonth_;
    NSDate* currDate_;
    NSDate* dateViewed_;
    ahnDatesView *dateView_;
    CGRect orginalFrameMonthView_;
    CGRect orginalFrameDateView_;
}


@property (nonatomic, retain)NSArray *events;

@property (nonatomic, readwrite)bool shouldHighLightCurrentDate;

@property (nonatomic, readonly)bool shouldShowEventIndicator;

@property (nonatomic, assign) id<ahnCalendarDelegate> calendarDelegate;

-(void)setEvents:(NSArray *)events;

-(bool)shouldShowEventIndicator;

-(void)setShouldShowEventIndicator:(bool)shouldShowEventIndicator;

-(void)setIndicatorColor:(UIColor *)color;

-(void)setIndicatorTextColor:(UIColor *)color;

-(bool)shouldHighLightCurrentDate;

-(void)setShouldHighLightCurrentDate:(bool)shouldHighLightCurrentDate;

-(void)loadCalendar;

-(void)setCalendarDelegate:(id<ahnCalendarDelegate>)calendarDelegate;


@end
