//
//  NSDate+NSDate_ahnDateComponents.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "NSDate+NSDate_ahnDateComponents.h"

@implementation NSDate (NSDate_ahnDateComponents)

-(NSDateComponents *)dateComponent{
    
    //Create a Calendar
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Get the  components of the calandar
    NSDateComponents *calendarComponts = [gregorian components:NSCalendarCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSYearCalendarUnit|NSYearForWeekOfYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayOrdinalCalendarUnit fromDate:self];
    
    return calendarComponts;
}
@end
