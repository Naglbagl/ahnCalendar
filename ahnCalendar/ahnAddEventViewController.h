//
//  ahnAddEventViewController.h
//  ahnCalendar
//
//  Created by Alexander Nagl on 11/11/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ahnEvent.h"

@interface ahnAddEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *txtName;

@property (copy, nonatomic) void (^dateSelectionHandler)(NSDate*, NSString*); //handler that is called once btnDone is tapped

- (IBAction)btnDoneTapped:(id)sender;
- (IBAction)btnCancelTapped:(id)sender;
- (IBAction)txtEventNameFinished:(id)sender;

@end
