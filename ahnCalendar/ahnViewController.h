//
//  ahnViewController.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnCalendar.h"
#import "ahnAddEventViewController.h"
@interface ahnViewController : UIViewController <ahnCalendarDelegate>{
    NSMutableArray *events;
}
//Properties
@property (strong, nonatomic) IBOutlet ahnCalendar *calendar;


//Actions
- (IBAction)btnAddTapped:(id)sender;

@end
