//
//  ahnEvent.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/16/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnEvent.h"

@implementation ahnEvent

-(id)init{
    self = [super init];
    if (self){
        self.date = [[NSDate alloc]init];
        self.events = [[NSArray alloc]init];
    }
    
    return self;
}

@end
