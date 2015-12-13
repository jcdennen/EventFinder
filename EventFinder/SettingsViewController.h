//
//  SettingsViewController.h
//  EventFinder
//
//  Created by Jeremy Dennen on 12/9/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsViewController : UIViewController
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSNumber *locationRadius;
@property (strong, nonatomic) NSNumber *numFutureDays;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

- (IBAction)updateLocationRadius:(id)sender;
- (IBAction)updateNumFutureDays:(id)sender;
- (IBAction)saveUserSettings:(id)sender;
- (IBAction)logOutUser:(id)sender;

@end
