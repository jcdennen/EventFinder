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

#warning TODO: update password action???
- (IBAction)updateLocationRadius:(id)sender {
    _locationRadius = [NSNumber numberWithFloat:[(UISlider *)sender value]];
    _radiusLabel.text = [NSString stringWithFormat:@"%@mi", _locationRadius];
}

- (IBAction)updateNumFutureDays:(id)sender {
    _numFutureDays = [NSNumber numberWithFloat:[(UISlider *)sender value]];
    _daysLabel.text = [NSString stringWithFormat:@"%@ days", _numFutureDays];
}

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

- (IBAction)logOutUser:(id)sender {
    [PFUser logOut];
    _currentUser = [PFUser currentUser];
    // redirect to LogInViewController
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogIn"];
        [self presentViewController:navViewController animated:YES completion:nil];
    });
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
