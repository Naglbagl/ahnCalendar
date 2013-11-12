//
//  ahnCalendarCellView.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/15/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnCalendarCellView.h"

@implementation ahnCalendarCellView
@synthesize dateLabel = dateLabel_;
@synthesize eventIndicator = eventIndicator_;
@synthesize event = _event;
@synthesize shouldShowEventIndicator = _shouldShowEventIndicator;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dateLabel_ = [[UILabel alloc]init];
        [dateLabel_ setFrame:CGRectMake(0, kCalendarCellViewYPadding, frame.size.width, 20)];
        [dateLabel_ setText:@"0"];
        [dateLabel_ setTextAlignment:NSTextAlignmentCenter];
        dateLabel_.adjustsFontSizeToFitWidth = YES;
        [self addSubview:dateLabel_];
        
        eventIndicator_ = [[ahnEventIndicatorView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height + dateLabel_.frame.size.height)/2, self.frame.size.width, (self.frame.size.height/2))];
                
        [eventIndicator_ setIndicatorColor:[UIColor redColor]];
        
        [eventIndicator_ setHidden:YES];
        
        _shouldShowEventIndicator = YES;
        
        [self addSubview:eventIndicator_];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
    }
    return self;
}

-(void)cellTapped:(id)sender{
    if(dateLabel_.textColor != [UIColor grayColor]){
        [self.cellDelegate calendarCellWithDay:[dateLabel_.text intValue] WasTappedWithEvent:_event];
    }
}

-(void)setEvent:(ahnEvent *)event{
    if (event != nil && event.events.count > 0){
        [eventIndicator_.indicatorLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)event.events.count]];
        if (_shouldShowEventIndicator){
            [eventIndicator_ setHidden:NO];
        }
    }else{
        [eventIndicator_ setHidden:YES];
    }
    _event = event;
}

-(void)setShouldShowEventIndicator:(bool)shouldShowEventIndicator{
    _shouldShowEventIndicator = shouldShowEventIndicator;
    [eventIndicator_ setHidden:!shouldShowEventIndicator];
}

-(void)setCellDelegate:(id<ahnCalendarCellViewDelegate>)cellDelegate{
    _cellDelegate = cellDelegate;
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
