//
//  SettingsViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 12/9/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Settings";
    _currentUser = [PFUser currentUser];
    _usernameLabel.text = [_currentUser username];
    _radiusLabel.text = _currentUser[@"locationRadius"];
    _daysLabel.text = _currentUser[@"numFutureDays"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//updates radiusLabel as appropriate slider moves
- (IBAction)updateLocationRadius:(id)sender {
    _locationRadius = [NSNumber numberWithFloat:[(UISlider *)sender value]];
    _radiusLabel.text = [NSString stringWithFormat:@"%@mi", _locationRadius];
}

//updates daysLabel as appropriate slider moves
- (IBAction)updateNumFutureDays:(id)sender {
    _numFutureDays = [NSNumber numberWithFloat:[(UISlider *)sender value]];
    _daysLabel.text = [NSString stringWithFormat:@"%@ days", _numFutureDays];
}

// updates user settings for location radius and number of future days (used in calendar/TableViewController)
- (IBAction)saveUserSettings:(id)sender {
    // notify user of progress with loading animation
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingIndicator startAnimating];
    
    _currentUser[@"locationRadius"] = _locationRadius;
    _currentUser[@"numFutureDays"] = _numFutureDays;
    
    [_currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [loadingIndicator stopAnimating];
        
        if (!error) {
            // alert success no redirect
            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Settings Updated" message:@"Success!" preferredStyle:UIAlertControllerStyleAlert];
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [errorAlert dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:errorAlert animated:YES completion:nil];
        }
        else {
            // alert error
            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error Updating Settings" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [errorAlert dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:errorAlert animated:YES completion:nil];
            NSLog(@"Error: %@", error);
        }
    }];
}

//logs out Parse User and redirects to initial login view
- (IBAction)logOutUser:(id)sender {
    [PFUser logOut];
    _currentUser = [PFUser currentUser];
    // redirect to LogInViewController
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogIn"];
        [self presentViewController:navViewController animated:YES completion:nil];
    });
    
}

@end
