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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning TODO: update slider values here
- (IBAction)updateLocationRadius:(id)sender {
    NSLog(@"location sender: %@", sender);
//    _locationRadius = sender;
}

- (IBAction)updateNumFutureDays:(id)sender {
//    _numFutureDays = sender;
}

- (IBAction)saveUserSettings:(id)sender {
    _currentUser[@"locationRadius"] = _locationRadius;
    _currentUser[@"numFutureDays"] = _numFutureDays;
    [_currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //
        if (!error) {
            // alert success no redirect
        }
        else {
            // alert error
            NSLog(@"Error: %@", error);
        }
    }];
}

- (IBAction)logOutUser:(id)sender {
    [PFUser logOut];
#warning CHECK if necessary here...
    _currentUser = [PFUser currentUser];
    // TODO: redirect to Log In ViewController
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
