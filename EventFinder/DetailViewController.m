//
//  DetailViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 11/8/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // custom stuff here
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // all attributes are set here
    self.title = self.titleText;
    _descriptionLabel.text = _eventDescription;
    _startTimeLabel.text = [NSString stringWithFormat:@"Starts: %@", _startTime];
    _endTimeLabel.text = [NSString stringWithFormat:@"Ends: %@", _endTime];
    
    // we use an MKpointAnnotation to locate the event's location in a MapView
    MKPointAnnotation *eventAnnotation = [[MKPointAnnotation alloc] init];
    [eventAnnotation setCoordinate:CLLocationCoordinate2DMake([_location latitude], [_location longitude])];
    [eventAnnotation setTitle:self.titleText];
    [_locationView addAnnotation:eventAnnotation];
    
    _hostLabel.text = [NSString stringWithFormat:@"Hosted by: %@", _host];

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

@end
