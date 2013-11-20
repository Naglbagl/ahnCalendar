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
    
    //Set up the gester recognizers
    UISwipeGestureRecognizer *swipeGesterRecognizerUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedUp:)];
    
    swipeGesterRecognizerUp.numberOfTouchesRequired = 1;
    swipeGesterRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *swipeGesterRecognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedDown:)];
    
    swipeGesterRecognizerDown.numberOfTouchesRequired = 1;
    swipeGesterRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    UISwipeGestureRecognizer *swipeGesterRecognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedRight:)];
    
    swipeGesterRecognizerRight.numberOfTouchesRequired = 1;
    swipeGesterRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeGesterRecognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(calendarSwippedLeft:)];
    
    swipeGesterRecognizerLeft.numberOfTouchesRequired = 1;
    swipeGesterRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    //Add the gester recognizers
    [self addGestureRecognizer:swipeGesterRecognizerUp];
    [self addGestureRecognizer:swipeGesterRecognizerDown];
    [self addGestureRecognizer:swipeGesterRecognizerRight];
    [self addGestureRecognizer:swipeGesterRecognizerLeft];


    
    self.userInteractionEnabled = YES;
    
    [dateView_ setCellDelegate:self];
    
    orginalFrameDateView_ = dateView_.frame;
    orginalFrameMonthView_ = lbMonth_.frame;
}

-(void)calendarSwippedLeft:(UIGestureRecognizer *)swipe{
    [self animateCalendarInXDirection:-50 andYDirection:0 withBlock:^{
        NSDateComponents *components = dateViewed_.dateComponent;
        
        components.yearForWeekOfYear = components.yearForWeekOfYear + 1;
        
        if (components.month == currDate_.dateComponent.month && components.yearForWeekOfYear == currDate_.dateComponent.yearForWeekOfYear){
            [self setCalendarViewWithDate:components.date];
            if (_shouldHighLightCurrentDate){
                [self highlightDate:currDate_ withColor:[UIColor redColor]];
            }
        }else{
            [self setCalendarViewWithDate:components.date];
        }

    }];

}

-(void)calendarSwippedRight:(UIGestureRecognizer *)swipe{
    
    
    [self animateCalendarInXDirection:50 andYDirection:0 withBlock:^{
        NSDateComponents *components = dateViewed_.dateComponent;
        
        components.yearForWeekOfYear = components.yearForWeekOfYear - 1;
        
        if (components.month == currDate_.dateComponent.month && components.yearForWeekOfYear == currDate_.dateComponent.yearForWeekOfYear){
            [self setCalendarViewWithDate:components.date];
            if (_shouldHighLightCurrentDate){
                [self highlightDate:currDate_ withColor:[UIColor redColor]];
            }
        }else{
            [self setCalendarViewWithDate:components.date];
        }

    }];
}

-(void)calendarSwippedUp:(UISwipeGestureRecognizer *)swipe{
    
    [self animateCalendarInXDirection:0 andYDirection:-50 withBlock:^{
        NSDateComponents *components = dateViewed_.dateComponent;
        if (components.month == 12){
            components.month = 1;
            components.yearForWeekOfYear = components.yearForWeekOfYear + 1;
            components.day = 1;
        }else{
            components.month = components.month + 1;
            components.day = 1;
        }
        
        if (components.month == currDate_.dateComponent.month && components.yearForWeekOfYear == currDate_.dateComponent.yearForWeekOfYear){
            [self setCalendarViewWithDate:currDate_];
            if (_shouldHighLightCurrentDate){
                [self highlightDate:currDate_ withColor:[UIColor redColor]];
            }
        }else{
            [self setCalendarViewWithDate:components.date];
        }

    }];
    

}

-(void)calendarSwippedDown:(UISwipeGestureRecognizer *)swipe{
    
    
    [self animateCalendarInXDirection:0 andYDirection:50 withBlock:^{
        NSDateComponents *components = dateViewed_.dateComponent;
        if (components.month == 1){
            components.month = 12;
            components.yearForWeekOfYear = components.yearForWeekOfYear - 1;
            components.day = 1;
        }else{
            components.month = components.month -1;
            components.day = 1;
        }
        
        
        if (components.month == currDate_.dateComponent.month && components.yearForWeekOfYear == currDate_.dateComponent.yearForWeekOfYear){
            [self setCalendarViewWithDate:currDate_];
        }else{
            [self setCalendarViewWithDate:components.date];
        }
        
    }];

    
}

-(void)animateCalendarInXDirection:(float)x andYDirection:(float)y withBlock:(void (^)(void))block{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [dateView_ setFrame:CGRectMake(dateView_.frame.origin.x + x, dateView_.frame.origin.y + y, dateView_.frame.size.width, dateView_.frame.size.height)];
        [lbMonth_ setFrame:CGRectMake(lbMonth_.frame.origin.x + x, lbMonth_.frame.origin.y + y, lbMonth_.frame.size.width, lbMonth_.frame.size.height)];
        dateView_.alpha = 0.0;
        lbMonth_.alpha = 0.0;
        
        
    } completion:^(BOOL finished) {
        [dateView_ setFrame:CGRectMake(orginalFrameDateView_.origin.x - x, orginalFrameDateView_.origin.y - y, orginalFrameDateView_.size.width, orginalFrameDateView_.size.height)];
        [lbMonth_ setFrame:CGRectMake(orginalFrameMonthView_.origin.x - x, orginalFrameMonthView_.origin.y - y, orginalFrameMonthView_.size.width, orginalFrameMonthView_.size.height)];
        
        block();
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            dateView_.alpha = 1.0;
            lbMonth_.alpha = 1.0;
            dateView_.frame = orginalFrameDateView_;
            lbMonth_.frame = orginalFrameMonthView_;
        }];
        
    }];
}



-(void)highlightDate:(NSDate *)date withColor:(UIColor *)color{
    
    //Get the components of the date
    NSDateComponents *dateComponent = date.dateComponent;
    
    //Take the button and set the title and tint color
    [dateView_ setTitle:[NSString stringWithFormat:@"%i",(int)dateComponent.day] forCellLocatedAtXLocation:(int)dateComponent.weekday-1 yLocation:(int)dateComponent.weekOfMonth-1 withColor:color];
    
}

-(void)highLightCurrentDate{
    if (currDate_.dateComponent.month == dateViewed_.dateComponent.month && currDate_.dateComponent.yearForWeekOfYear == dateViewed_.dateComponent.yearForWeekOfYear){
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
        if (event.date.dateComponent.month == dateViewed_.dateComponent.month && event.date.dateComponent.yearForWeekOfYear == dateViewed_.dateComponent.yearForWeekOfYear){
            
            int weekday =(int)event.date.dateComponent.weekday-1;
            int weekOfMonth = (int)event.date.dateComponent.weekOfMonth-1;
            
            [dateView_ setEvent:event forCellLocatedAtXLocation:weekday yLocation:weekOfMonth];
            [dateView_ shouldShowIndicator:shouldShowEventIndicator forCellAtXLocation:weekday atYLocation:weekOfMonth];
        }
    }
}

-(void)setlbMonth:(int)month{
    [lbMonth_ setText:[NSString stringWithFormat:@"%@ %i",[ahnCalendarHelper getMonthFromNumber:month],(int)dateViewed_.dateComponent.yearForWeekOfYear]];
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
    [_calendarDelegate calendarWasTappedOnDay:day month:(int)dateViewed_.dateComponent.month year:(int)dateViewed_.dateComponent.yearForWeekOfYear withEvent:event];
}



@end
