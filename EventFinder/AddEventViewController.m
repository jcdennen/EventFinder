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
    _eventTitleEntry.delegate = self;
    _eventDescriptionEntry.delegate = self;
    
    // allow user to dismiss keyboard by tapping anywhere in the view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTheKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // initialize to arbitrary data
    _eventTitle = @"";
    _eventDescription = @"";
    _eventStartDate = [NSDate date];
    _eventEndDate = [NSDate date];
    
    // set mins for DatePickers as current date an maxs as a year from current date
    [_startDatePicker setMinimumDate:_eventStartDate];
    [_startDatePicker setMaximumDate:[NSDate dateWithTimeInterval:31536000 sinceDate:_eventStartDate]];
    [_endDatePicker setMinimumDate:_eventEndDate];
    [_endDatePicker setMaximumDate:[NSDate dateWithTimeInterval:31536000 sinceDate:_eventEndDate]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissTheKeyboard {
    _eventTitle = _eventTitleEntry.text;
    _eventDescription = _eventDescriptionEntry.text;
    [self.eventDescriptionEntry resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _eventTitleEntry) {
        _eventTitle = _eventTitleEntry.text;
        _eventDescription = _eventDescriptionEntry.text;
        [textField endEditing:YES];
    }
    else if (textField == _eventDescriptionEntry) {
        _eventTitle = _eventTitleEntry.text;
        _eventDescription = _eventDescriptionEntry.text;
        [textField endEditing:YES];
    }
    return YES;
}


- (IBAction)submitNewEvent:(id)sender {
    if ([_eventTitle isEqualToString:@""] || [_eventDescription isEqualToString:@""]) {
        // alert user of error
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Event Error" message:@"Make Sure All Fields Are Filled Correctly and Try Again" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else {
        PFObject *eventObject = [PFObject objectWithClassName:@"EventObject"];
        eventObject[@"title"] = _eventTitle;
        eventObject[@"description"] = _eventDescription;
        eventObject[@"startTime"] = _eventStartDate;
        eventObject[@"endTime"] = _eventEndDate;
        eventObject[@"host"] = [[PFUser currentUser] username];
        // set the user's current position again using a Parse GeoPoint
        eventObject[@"location"] = _eventLocation;
        
        // save the object to Parse
        [eventObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // alert user of success then redirect to list of events
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your event was created!" preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [errorAlert dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCalendar"];
                    [self presentViewController:navViewController animated:YES completion:nil];
                });
            }
            else {
                // alert user of error
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Parse Error" message:[error description] preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [errorAlert dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
        }];
    }
}

- (IBAction)startDatePickerUpdated:(id)sender {
    // set the event's start date as well as update the min & max for the end date
    _eventStartDate = _startDatePicker.date;
    [_endDatePicker setMinimumDate:_eventStartDate];
    [_endDatePicker setMaximumDate:[NSDate dateWithTimeInterval:31536000 sinceDate:_eventStartDate]];
}

- (IBAction)endDatePickerUpdated:(id)sender {
    _eventEndDate = _endDatePicker.date;
}
@end
