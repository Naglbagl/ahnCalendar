//
//  ahnDatesView.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/14/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnCalendarCellView.h"
@interface ahnDatesView : UIView{
    float rowSpacing_;
    float coloumSpacing_;
    CGSize cellSize_;
    NSMutableArray *cells_;
}
@property (nonatomic, retain)UIColor *indicatorColor;
@property (nonatomic, retain)UIColor *indicatorTextColor;

-(void)setIndicatorColor:(UIColor *)indicatorColor;

-(void)setIndicatorTextColor:(UIColor *)indicatorTextColor;

-(void)loadCalendarView;

-(void)setTitle:(NSString *)title forCellLocatedAtXLocation:(int)xLocation yLocation:(int)yLocation withColor:(UIColor*)color;

-(void)shouldShowIndicator:(bool)shouldShowIndicator forCellAtXLocation:(int)xLocation atYLocation:(int)yLocation;

-(void)setEvent:(ahnEvent *)event forCellLocatedAtXLocation:(int)xLocation yLocation:(int)yLocation;

-(void)setCellDelegate:(id)delegate;
@end
