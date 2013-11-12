//
//  ahnAddEventViewController.m
//  ahnCalendar
//
//  Created by Alexander Nagl on 11/11/13.
//  Copyright (c) 2013 Alexander Nagl. All rights reserved.
//

#import "ahnAddEventViewController.h"

@interface ahnAddEventViewController ()

@end

@implementation ahnAddEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDoneTapped:(id)sender {
    if (self.dateSelectionHandler){
        self.dateSelectionHandler(self.datePicker.date, self.txtName.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)btnCancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)txtEventNameFinished:(id)sender {
    [sender resignFirstResponder];
}


@end
