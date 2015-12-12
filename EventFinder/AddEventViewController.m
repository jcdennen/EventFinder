//
//  AddEventViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 12/9/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add New Event";
    self.eventTitleEntry.delegate = self;
    self.eventDescriptionEntry.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTheKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //initialize to empty strings
    _eventTitle = @"";
    _eventDescription = @"";
    _eventStartDate = @"";
    _eventEndDate = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissTheKeyboard {
    _eventDescription = _eventDescriptionEntry.text;
    _eventTitle = _eventTitleEntry.text;
    [self.eventDescriptionEntry resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.eventTitleEntry) {
        _eventTitle = _eventTitleEntry.text;
        [textField endEditing:YES];
    }
    return YES;
}

# warning TODO: set constraints for UIDatePicker
    // need to have the event date/time minimum constrained to the current time


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitNewEvent:(id)sender {
    if ([_eventTitle isEqualToString:@""] || [_eventDescription isEqualToString:@""]) {
        //alert the user by pop up to @"Make Sure All Fields Are Filled Correctly and Try Again"
        NSLog(@"Make Sure All Fields Are Filled Correctly and Try Again");
    }
//    else if ([_eventStartDate isEqualToString:@""] || [_eventEndDate isEqualToString:@""]) {
//        NSLog(@"Please Enter Valid Start and End Dates and Times");
//    }
    else {
        PFObject *eventObject = [PFObject objectWithClassName:@"EventObject"];
        eventObject[@"title"] = _eventTitle;
        eventObject[@"description"] = _eventDescription;
        eventObject[@"startTime"] = _eventStartDate;
        eventObject[@"endTime"] = _eventEndDate;
#warning TODO: set these values
        // use PFGeoPoint
        eventObject[@"location"] = @"";
        // get the current PFUser
        eventObject[@"host"] = @"";
        
        // save the object to Parse
        [eventObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                //
                NSLog(@"Success!");
            }
            else {
                // alert user that there's an error
                NSLog(@"Error: %@", error.description);
            }
        }];
    }
}

- (IBAction)startDatePickerUpdated:(id)sender {
    _eventStartDate = _startDatePicker.date;
}

- (IBAction)endDatePickerUpdated:(id)sender {
    _eventEndDate = _endDatePicker.date;
}
@end
