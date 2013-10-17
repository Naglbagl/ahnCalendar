//
//  ahnEventIndicatorView.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 10/15/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ahnEventIndicatorView : UIView{
    UIColor *indicatorColor_;
    UILabel *indicatorLabel_;
    CAShapeLayer *shapeLayer_;
}

@property (nonatomic, retain) UILabel *indicatorLabel;

-(void)setIndicatorColor:(UIColor *)color;


@end
