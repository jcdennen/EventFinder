//
//  SignUpViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 12/12/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#warning TODO: Alert Errors
- (IBAction)signUpNewUser:(id)sender {
    NSString *email = _emailField.text;
    NSString *username = _usernameField.text;
    NSString *password = _passwordField.text;

    if ([email length] < 8) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Invalid Email" message:@"Make sure you have a valid email and try again" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else if ([username length] < 5) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Invalid Username" message:@"Username must be at least 5 characters long" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else if ([password length] < 8) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Invalid Password" message:@"Password must be at least 8 characters long" preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    else {
        // notify user of progress with loading animation
        UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [loadingIndicator startAnimating];
        
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        
        // setup additional default user settings
        user[@"locationRadius"] = [NSNumber numberWithInt:50];
        user[@"numFutureDays"] = [NSNumber numberWithInt:30];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [loadingIndicator stopAnimating];
            
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCalendar"];
                    [self presentViewController:navViewController animated:YES completion:nil];
                });

            }
            else {
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Parse Error" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [errorAlert dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
        }];
    }
}
@end
