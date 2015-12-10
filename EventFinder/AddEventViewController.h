//
//  AddEventViewController.h
//  EventFinder
//
//  Created by Jeremy Dennen on 12/9/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventTitleEntry;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionEntry;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIButton *submitNewEvent;

@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDescription;
//@property (strong, nonatomic) NSDate *eventDate;
//@property (strong, nonatomic) NSDate *EventTime;
//@property () eventLocation;

@end
