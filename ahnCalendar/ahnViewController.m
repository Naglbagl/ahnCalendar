//
//  ahnViewController.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnViewController.h"

@interface ahnViewController ()

@end

@implementation ahnViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.calendar loadCalendar];

    //Dummy data
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSArray *array = [[NSArray alloc]initWithObjects:@"One", @"Two", @"Three", nil];
    ahnEvent *event = [[ahnEvent alloc]init];
    event.date = date;
    event.events = array;
    
    NSDate *dateTwo = [NSDate dateWithTimeIntervalSinceNow:60*60*24*3]; //Three days from now
    NSArray *arrayTwo = [[NSArray alloc]initWithObjects:@"One", @"Two", @"Three", nil];
    ahnEvent *eventTwo = [[ahnEvent alloc]init];
    event.date = dateTwo;
    event.events = arrayTwo;
    
    NSArray *events = @[event, eventTwo];
    
    
    //Put Dummy date into the calendar
    [self.calendar setEvents:events];
    
    self.calendar.shouldHighLightCurrentDate = YES; //Tell the calendar to highlight the current date
    
    self.calendar.calendarDelegate = self; //Set the cellDele
    
    [self.calendar setIndicatorColor:[UIColor darkGrayColor]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarWasTappedOnDay:(int)day month:(int)month year:(int)year withEvent:(ahnEvent *)event{
    NSLog(@"Date was tapped: %i %i %i", month, day, year);
    
    if (event){
        NSLog(@"Has Event");
    }
}

@end
