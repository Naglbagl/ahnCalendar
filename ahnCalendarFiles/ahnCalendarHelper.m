//
//  ahnCalendarHelper.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/15/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnCalendarHelper.h"

@implementation ahnCalendarHelper

+(NSString *)getMonthFromNumber:(int)month{
    switch (month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"Feburary";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            return nil;
            break;
    }
}

@end
