//
//  SignUpViewController.h
//  EventFinder
//
//  Created by Jeremy Dennen on 12/12/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)signUpNewUser:(id)sender;

@end
