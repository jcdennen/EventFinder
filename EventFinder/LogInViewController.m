//
//  LogInViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 12/12/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup UITextFieldDelegates
    _usernameField.delegate = self;
    _passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (IBAction)loginUser:(id)sender {
    NSString *username = _usernameField.text;
    NSString *password = _passwordField.text;
    
    if ([username length] < 5) {
        // alert user of error
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Invalid Login" message:@"Invalid username" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else if ([password length] < 8) {
        // alert user of error
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Invalid Login" message:@"Invalid password" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else {
        // notify user of progress with loading animation
        UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [loadingIndicator startAnimating];
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            [loadingIndicator stopAnimating];
            
            if (user) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCalendar"];
                    [self presentViewController:navViewController animated:YES completion:nil];
                });
            }
            else {
                // alert user of error
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Parse Error" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [errorAlert dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
        }];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    //does nothing
}

@end
