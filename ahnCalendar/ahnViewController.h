//
//  ahnViewController.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnCalendar.h"
@interface ahnViewController : UIViewController <ahnCalendarDelegate>
@property (strong, nonatomic) IBOutlet ahnCalendar *calendar;

@end
