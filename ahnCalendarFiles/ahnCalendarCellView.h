//
//  ahnCalendarCellView.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/15/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnEventIndicatorView.h"
#import "ahnEvent.h"

#define kCalendarCellViewXPadding 10
#define kCalendarCellViewYPadding 0

@protocol ahnCalendarCellViewDelegate <NSObject>
@required
- (void)calendarCellWithDay:(int)day WasTappedWithEvent:(ahnEvent *)event;
@end


@interface ahnCalendarCellView : UIView{
    UILabel *dateLabel_;
    ahnEventIndicatorView *eventIndicator_;
}
@property (nonatomic, retain)UILabel *dateLabel;
@property (nonatomic, retain)ahnEventIndicatorView *eventIndicator;
@property (nonatomic, retain)ahnEvent *event;
@property (nonatomic)bool shouldShowEventIndicator;
@property (nonatomic, weak) id<ahnCalendarCellViewDelegate> cellDelegate;

-(void)setEvent:(ahnEvent *)event;

-(void)setShouldShowEventIndicator:(bool)shouldShowEventIndicator;

-(void)setCellDelegate:(id<ahnCalendarCellViewDelegate>)cellDelegate;

@end
