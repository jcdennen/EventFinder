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

- (IBAction)loginUser:(id)sender {
    NSString *username = _usernameField.text;
    NSString *password = _passwordField.text;
    
    if ([username length] < 5) {
        // alert error
    }
    else if ([password length] < 8) {
        // alert error
    }
    else {
        //TODO: possible loading animation?
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            //
            if (user) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *navViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCalendar"];
                    [self presentViewController:navViewController animated:YES completion:nil];
                });
            }
            else {
                //TODO: alert error
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

@end
