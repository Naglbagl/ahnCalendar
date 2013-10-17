//
//  NSDate+NSDate_ahnDateComponents.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_ahnDateComponents)
@property (nonatomic, retain, readonly) NSDateComponents *dateComponent;

-(NSDateComponents *)dateComponent;

@end
