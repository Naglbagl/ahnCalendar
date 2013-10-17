//
//  ahnEventIndicatorView.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/15/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnEventIndicatorView.h"

@implementation ahnEventIndicatorView
@synthesize indicatorLabel = indicatorLabel_;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //[self drawRect:frame];

        self.backgroundColor = [UIColor clearColor];
        indicatorColor_ = [UIColor blueColor];

        [self initShapeLayer];

        
        indicatorLabel_ = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/32 - 1, frame.size.width, frame.size.height)];
        [indicatorLabel_ setTextAlignment:NSTextAlignmentCenter];
        indicatorLabel_.adjustsFontSizeToFitWidth = NO;
        [indicatorLabel_ setFont:[UIFont boldSystemFontOfSize:frame.size.height/2]];
        
        if (frame.size.height/2 < 8){
            [indicatorLabel_ setHidden:YES];
        }
        
        [indicatorLabel_ setTextColor:[UIColor whiteColor]];
        [self addSubview:indicatorLabel_];
        
        

    }
    return self;
}


-(void)initShapeLayer{
    shapeLayer_ = [CAShapeLayer layer];
    // Give the layer the same bounds as your image view
    [shapeLayer_ setBounds:CGRectMake(0.0f, 0.0f, self.frame.size.width,
                                      self.frame.size.height)];
    // Position the circle anywhere you like, but this will center it
    // In the parent layer, which will be your image view's root layer
    [shapeLayer_ setPosition:CGPointMake(0.0f,
                                         0.0f)];
    
    float diameter;
    
    int offSet = 0;
    if (self.frame.size.width > self.frame.size.height){
        diameter = self.bounds.size.height;
    }else{
        diameter = self.bounds.size.width;
        offSet = diameter/2;
    }

    // Create a circle path.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, diameter, diameter)];
    // Set the path on the layer
    [shapeLayer_ setPath:[path CGPath]];
    // Set the stroke color
    [shapeLayer_ setFillColor:[indicatorColor_ CGColor]];
    
    [shapeLayer_ setFrame:CGRectMake((self.frame.size.width/2)-(diameter/2), 0, self.frame.size.width, self.frame.size.height)];
    
    // Add the sublayer to the image view's layer tree
    [[self layer] addSublayer:shapeLayer_];
}


-(void)setIndicatorText:(NSString *)text{
    [indicatorLabel_ setText:text];
}

-(void)setIndicatorColor:(UIColor *)color;{
    indicatorColor_ = color;
    [shapeLayer_ setFillColor:[color CGColor]];
}


@end
