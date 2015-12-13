//
//  AddEventViewController.h
//  EventFinder
//
//  Created by Jeremy Dennen on 12/9/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddEventViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventTitleEntry;
@property (weak, nonatomic) IBOutlet UITextField *eventDescriptionEntry;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

- (IBAction)submitNewEvent:(id)sender;
- (IBAction)startDatePickerUpdated:(id)sender;
- (IBAction)endDatePickerUpdated:(id)sender;

@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSDate *eventStartDate;
@property (strong, nonatomic) NSDate *eventEndDate;
@property (strong, nonatomic) PFGeoPoint *eventLocation;

@end
