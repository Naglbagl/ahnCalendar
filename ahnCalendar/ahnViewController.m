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
    
    [self.calendar loadCalendar]; //Load the calendar to set it up
    
    self.calendar.shouldHighLightCurrentDate = YES; //Tell the calendar to highlight the current date
    
    self.calendar.calendarDelegate = self; //Set the cellDele
    
    [self.calendar setIndicatorColor:[UIColor darkGrayColor]]; //Set the indicator color
    
    events = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Delegate function that is called when a day is tapped
-(void)calendarWasTappedOnDay:(int)day month:(int)month year:(int)year withEvent:(ahnEvent *)event{
    NSLog(@"Date was tapped: %i %i %i", month, day, year);
    
    //If an event was sent it
    if (event){
        //Use it how ever you would like to
        NSLog(@"\tEvents on Date:");
        for (NSString *string in event.events){
            NSLog(@"\t%@",string);
        }
    }
}

- (IBAction)btnAddTapped:(id)sender {
    
    //Create the add event view controller
    ahnAddEventViewController *aevc = [[ahnAddEventViewController alloc]initWithNibName:@"ahnAddEventViewController" bundle:nil];
    
    //Set what the date selection handler should do
    aevc.dateSelectionHandler = ^(NSDate *date, NSString *name){
        bool foundDate = NO;
        for (ahnEvent *event in events){
            if ([event.date isEqual:date]){
                NSMutableArray *array = [NSMutableArray arrayWithArray:event.events];
                [array addObject:name];
                foundDate = YES;
                break;
            }
        }
        
        if (!foundDate){
            ahnEvent *newEvent = [[ahnEvent alloc]init];
            newEvent.date = date;
            newEvent.events = [[NSArray alloc]initWithObjects:name, nil];
            [events addObject:newEvent];
        }
        
        [self.calendar setEvents:events];
    };
    
    //Present it
    [self presentViewController:aevc animated:YES completion:nil];
    
}
@end
