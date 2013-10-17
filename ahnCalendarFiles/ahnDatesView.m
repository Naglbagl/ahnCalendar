//
//  ahnDatesView.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnDatesView.h"

@implementation ahnDatesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cells_ = [[NSMutableArray alloc]init];
        rowSpacing_ = (self.frame.size.width)/7;
        cellSize_.width = rowSpacing_;
        coloumSpacing_ = (self.frame.size.height)/6;
        cellSize_.height = coloumSpacing_/2;
        
        //Set it up
        [self loadCalendarView];
    }
    return self;
}

-(void)loadCalendarView{

    for (int x = 0; x < 7; x++){
        NSMutableArray *newRow = [[NSMutableArray alloc]init];
        for (int y = 0; y < 6; y++){
            ahnCalendarCellView *newCell = [[ahnCalendarCellView alloc]initWithFrame:CGRectMake(x*rowSpacing_, y*coloumSpacing_, cellSize_.width, cellSize_.height)];
            [self addSubview:newCell];
            [newRow addObject:newCell];
        }
        [cells_ addObject:newRow];
    }
}

-(void)setTitle:(NSString *)title forCellLocatedAtXLocation:(int)xLocation yLocation:(int)yLocation withColor:(UIColor*)color{
    ahnCalendarCellView *cell = [[cells_ objectAtIndex:xLocation]objectAtIndex:yLocation];
    [cell.dateLabel setText:title];
    [cell.dateLabel setTextColor:color];
}

-(void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    for (NSArray *array in cells_){
        for(ahnCalendarCellView *cell in array){
            [cell.eventIndicator setIndicatorColor:indicatorColor];
        }
    }
    
}

-(void)setIndicatorTextColor:(UIColor *)indicatorTextColor{
    _indicatorTextColor = indicatorTextColor;
    for (ahnCalendarCellView *cell in cells_){
        [cell.eventIndicator.indicatorLabel setTextColor:indicatorTextColor];
    }
}


-(void)shouldShowIndicator:(bool)shouldShowIndicator forCellAtXLocation:(int)xLocation atYLocation:(int)yLocation{
    ahnCalendarCellView *cell = [[cells_ objectAtIndex:xLocation]objectAtIndex:yLocation];
    cell.shouldShowEventIndicator = shouldShowIndicator;
}

-(void)setEvent:(ahnEvent *)event forCellLocatedAtXLocation:(int)xLocation yLocation:(int)yLocation{
    ahnCalendarCellView *cell = [[cells_ objectAtIndex:xLocation]objectAtIndex:yLocation];
    [cell setEvent:event];
}

-(void)setCellDelegate:(id)delegate{
    for (NSArray *array in cells_){
        for (ahnCalendarCellView *cell in array){
            cell.cellDelegate = delegate;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
