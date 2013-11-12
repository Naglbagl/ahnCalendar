//
//  ahnCalendar.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnCalendar.h"

@implementation ahnCalendar
@synthesize shouldHighLightCurrentDate = _shouldHighLightCurrentDate;
@synthesize shouldShowEventIndicator = _shouldShowEventIndicator;
@synthesize events = _events;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}

-(void)loadCalendar{
    _shouldShowEventIndicator = YES;
    
    _events = [[NSArray alloc]init];
    
    //Initialize the label
    lbMonth_ = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)];
    [lbMonth_ setTextAlignment:NSTextAlignmentCenter];
    
    
    //Create the view that just displays the dates
     dateView_ = [[ahnDatesView alloc]initWithFrame:CGRectMake(kCalendarXPadding, kCalendarYPadding + lbMonth_.frame.origin.y, self.frame.size.width-(kCalendarXPadding*2), self.frame.size.height - (kCalendarYPadding + lbMonth_.frame.origin.y)*1.5)];
    
    //Set it to the subview
    [self addSubview:dateView_];
    [self addSubview:lbMonth_];
    
    //Get the current date
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    currDate_ = currentDate;
    
    //Load up the calendar
    [self setCalendarViewWithDate:currentDate];
    
    //Set up the gester recognizer
    UISwipeGestureRecognizer *swipeGesterRecognizerUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedUp:)];
    
    swipeGesterRecognizerUp.numberOfTouchesRequired = 1;
    swipeGesterRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    //Set up the gester recognizer
    UISwipeGestureRecognizer *swipeGesterRecognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedDown:)];
    
    swipeGesterRecognizerDown.numberOfTouchesRequired = 1;
    swipeGesterRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self addGestureRecognizer:swipeGesterRecognizerUp];
    [self addGestureRecognizer:swipeGesterRecognizerDown];

    
    self.userInteractionEnabled = YES;
    
    [dateView_ setCellDelegate:self];
    
    orginalFrameDateView_ = dateView_.frame;
    orginalFrameMonthView_ = lbMonth_.frame;
}


//If they swiped Up then move forward in time
-(void)calendarSwippedUp:(UISwipeGestureRecognizer *)swipe{
    

    
    [UIView animateWithDuration:kAnimationDuration * 0.7 animations:^{
        [dateView_ setFrame:CGRectMake(dateView_.frame.origin.x, dateView_.frame.origin.y - 50, dateView_.frame.size.width, dateView_.frame.size.height)];
        [lbMonth_ setFrame:CGRectMake(lbMonth_.frame.origin.x, lbMonth_.frame.origin.y - 50, lbMonth_.frame.size.width, lbMonth_.frame.size.height)];
        dateView_.alpha = 0.0;
        lbMonth_.alpha = 0.0;


    } completion:^(BOOL finished) {
        dateView_.frame =  orginalFrameDateView_;
        lbMonth_.frame = orginalFrameMonthView_;
        
        NSDateComponents *components = dateViewed_.dateComponent;
        if (components.month == 12){
            components.month = 1;
            components.yearForWeekOfYear = components.yearForWeekOfYear + 1;
            components.day = 1;
        }else{
            components.month = components.month + 1;
            components.day = 1;
        }
        
        if (components.month == currDate_.dateComponent.month && components.year == currDate_.dateComponent.year){
            [self setCalendarViewWithDate:currDate_];
            if (_shouldHighLightCurrentDate){
                [self highlightDate:currDate_ withColor:[UIColor redColor]];
            }
        }else{
            [self setCalendarViewWithDate:components.date];
        }
        
        
        
        [UIView beginAnimations:@"fade" context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        dateView_.alpha = 1.0;
        lbMonth_.alpha = 1.0;
        [UIView commitAnimations];
    }];


}

//If they swiped down move back in time
-(void)calendarSwippedDown:(UISwipeGestureRecognizer *)swipe{
    
    [UIView animateWithDuration:kAnimationDuration * 0.7 animations:^{
        [dateView_ setFrame:CGRectMake(dateView_.frame.origin.x, dateView_.frame.origin.y + 50, dateView_.frame.size.width, dateView_.frame.size.height)];
        [lbMonth_ setFrame:CGRectMake(lbMonth_.frame.origin.x, lbMonth_.frame.origin.y + 50, lbMonth_.frame.size.width, lbMonth_.frame.size.height)];
        dateView_.alpha = 0.0;
        lbMonth_.alpha = 0.0;
        
        
    } completion:^(BOOL finished) {
        dateView_.frame =  orginalFrameDateView_;
        lbMonth_.frame = orginalFrameMonthView_;
        
        NSDateComponents *components = dateViewed_.dateComponent;
        if (components.month == 1){
            components.month = 12;
            components.yearForWeekOfYear = components.yearForWeekOfYear - 1;
            components.day = 1;
        }else{
            components.month = components.month -1;
            components.day = 1;
        }
        
        
        if (components.month == currDate_.dateComponent.month && components.year == currDate_.dateComponent.year){
            [self setCalendarViewWithDate:currDate_];
        }else{
            [self setCalendarViewWithDate:components.date];
        }
        
        
        [UIView beginAnimations:@"fade" context:nil];
        [UIView setAnimationDuration:kAnimationDuration];
        dateView_.alpha = 1.0;
        lbMonth_.alpha = 1.0;
        [UIView commitAnimations];
    }];
    
}



-(void)highlightDate:(NSDate *)date withColor:(UIColor *)color{
    
    //Get the components of the date
    NSDateComponents *dateComponent = date.dateComponent;
    
    //Take the button and set the title and tint color
    [dateView_ setTitle:[NSString stringWithFormat:@"%i",(int)dateComponent.day] forCellLocatedAtXLocation:(int)dateComponent.weekday-1 yLocation:(int)dateComponent.weekOfMonth-1 withColor:color];
    
}

-(void)highLightCurrentDate{
    if (currDate_.dateComponent.month == dateViewed_.dateComponent.month && currDate_.dateComponent.year == dateViewed_.dateComponent.year){
        if (self.shouldHighLightCurrentDate){
            [self highlightDate:currDate_ withColor:[UIColor redColor]];
        }else{
            [self highlightDate:currDate_ withColor:[UIColor blueColor]];
        }
    }
}

-(void)setCalendarViewWithDate:(NSDate *)date{
    dateViewed_ = date;
    
    //Get the  components of the calandar
    NSDateComponents *calendarComponents = date.dateComponent;
    [calendarComponents setDay:1];
    calendarComponents = calendarComponents.date.dateComponent;
    
    //Set the title month
    [self setlbMonth:(int)calendarComponents.month];
    
    //Get the current day of the week
    NSInteger weekday = [calendarComponents weekday] -1;
    
    //Find out how many days are in the month we are looking at
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];;
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    
    // Set your month here
    [comps setMonth:[calendarComponents month]];
    
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit
                              inUnit:NSMonthCalendarUnit
                             forDate:[cal dateFromComponents:comps]];
    
    short int maxDay = range.length;
    
    //Start with our day counter
    short int dayCounter = 1;
    
    bool didSetInitalI = YES;
    
    int newCounter = 1;
    
    //Fill in the dates
    for (int j = 0; j < 6; j++){
        for (int i = 0; i < 7; i++){
            if(didSetInitalI){
                i = (int)weekday;
                didSetInitalI = NO;
            }
            if (dayCounter <= maxDay){
                [dateView_ setTitle:[NSString stringWithFormat:@"%i",dayCounter] forCellLocatedAtXLocation:i yLocation:j withColor:[UIColor blueColor]];
            }else{
                [dateView_ setTitle:[NSString stringWithFormat:@"%i",newCounter] forCellLocatedAtXLocation:i yLocation:j withColor:[UIColor grayColor]];
                newCounter++;
            }
            dayCounter++;
        }
    }
    
    //Get last months data
    if (calendarComponents.month == 1){
        // Set your month here
        [comps setMonth:1];
    }else{
    [comps setMonth:comps.month];
    }
    
    //Get the range of last month's days
    range = [cal rangeOfUnit:NSDayCalendarUnit
                              inUnit:NSMonthCalendarUnit
                             forDate:[cal dateFromComponents:comps]];
    
    //Get the number of days
    maxDay = range.length;
    
    
    //Get the back days from the previous month
    for (int i = 0; i < weekday; i++){

        [dateView_ setTitle:[NSString stringWithFormat:@"%li",(int)maxDay-weekday+i+1] forCellLocatedAtXLocation:i  yLocation:0 withColor:[UIColor grayColor]];
    }
    
    [self highLightCurrentDate];
    
    //remove all dates that may be present in the calendar
    for (int j = 0; j < 6; j++){
        for (int i = 0; i < 7; i++){
            [dateView_ setEvent:nil forCellLocatedAtXLocation:i yLocation:j];
        }
    }

    //Fill in dates
    [self shouldShowEventIndicator:_shouldShowEventIndicator WithEvents:_events];

    
}


-(void)shouldShowEventIndicator:(bool)shouldShowEventIndicator WithEvents:(NSArray *)events{
    for (ahnEvent *event in _events){
        if (event.date.dateComponent.month == dateViewed_.dateComponent.month && event.date.dateComponent.year == dateViewed_.dateComponent.year){
            
            int weekday =(int)event.date.dateComponent.weekday-1;
            int weekOfMonth = (int)event.date.dateComponent.weekOfMonth-1;
            
            [dateView_ setEvent:event forCellLocatedAtXLocation:weekday yLocation:weekOfMonth];
            [dateView_ shouldShowIndicator:shouldShowEventIndicator forCellAtXLocation:weekday atYLocation:weekOfMonth];
        }
    }
}

-(void)setlbMonth:(int)month{
    [lbMonth_ setText:[NSString stringWithFormat:@"%@ %i",[ahnCalendarHelper getMonthFromNumber:month],(int)dateViewed_.dateComponent.year]];
}

-(bool)ShouldHighLightCurrentDate{
    return _shouldHighLightCurrentDate;
}

-(void)setShouldHighLightCurrentDate:(bool)shouldHighLightCurrentDate{
    _shouldHighLightCurrentDate = shouldHighLightCurrentDate;
    [self highLightCurrentDate];
}


-(bool)shouldShowEventIndicator{
    return _shouldShowEventIndicator;
}

-(void)setShouldShowEventIndicator:(bool)shouldShowEventIndicator{
    _shouldShowEventIndicator = YES;
    
    [self shouldShowEventIndicator:shouldShowEventIndicator WithEvents:_events];
}

-(void)setIndicatorColor:(UIColor *)color{
    [dateView_ setIndicatorColor:color];
}


-(void)setIndicatorTextColor:(UIColor *)color{
    [dateView_ setIndicatorTextColor:color];
}

-(void)setEvents:(NSArray *)events{
    _events = events;
    [self shouldShowEventIndicator:_shouldShowEventIndicator WithEvents:events];
}

-(void)setCalendarDelegate:(id<ahnCalendarDelegate>)calendarDelegate{
    _calendarDelegate = calendarDelegate;
}

-(void)calendarCellWithDay:(int)day WasTappedWithEvent:(ahnEvent *)event{
    [_calendarDelegate calendarWasTappedOnDay:day month:(int)dateViewed_.dateComponent.month year:(int)dateViewed_.dateComponent.year withEvent:event];
}



@end
