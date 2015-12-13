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
        // alert error
    }
    else if ([username length] < 5) {
        // alert error
    }
    else if ([password length] < 8) {
        // alert error
    }
    else {
        // TODO: some sort of loading animation
        
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        
        // additional user settings
        user[@"locationRadius"] = [NSNumber numberWithInt:50];
        user[@"numFutureDays"] = [NSNumber numberWithInt:30];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //TODO: success and redirect
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCalendar"];
                    [self presentViewController:navViewController animated:YES completion:nil];
                });

            }
            else {
                // TODO: display error message
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
            }
        }];
    }
    
}
@end
