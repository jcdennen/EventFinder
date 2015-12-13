//
//  TableViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 11/8/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "AddEventViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // parse method for grabbing the current location of the user
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            
            _currentLocation = geoPoint;
            
            // A Parse query that grabs all event objects based on their user settings (location radius and number of future days)
            PFQuery *query = [PFQuery queryWithClassName:@"EventObject"];
            [query whereKey:@"location" nearGeoPoint:_currentLocation withinMiles:[[PFUser currentUser][@"locationRadius"] doubleValue]];
            [query whereKey:@"startTime" lessThanOrEqualTo:[NSDate dateWithTimeIntervalSinceNow:([[PFUser currentUser][@"numFutureDays"] integerValue] * 86400)]];
            _eventObjects = [[NSMutableArray alloc] initWithArray:[query findObjects]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            // log error if any
            NSLog(@"Error: %@", error);
        }
    }];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // updates currentLocation
    _currentLocation = [PFGeoPoint geoPointWithLocation:[locations lastObject]];
    
    // A Parse query that grabs all event objects based on their user settings (location radius and number of future days)
    PFQuery *query = [PFQuery queryWithClassName:@"EventObject"];
    [query whereKey:@"location" nearGeoPoint:_currentLocation withinMiles:[[PFUser currentUser][@"locationRadius"] doubleValue]];
    [query whereKey:@"startTime" lessThanOrEqualTo:[NSDate dateWithTimeIntervalSinceNow:([[PFUser currentUser][@"numFutureDays"] integerValue] * 86400)]];
    _eventObjects = [[NSMutableArray alloc] initWithArray:[query findObjects]];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // throw errors accordingly
    switch ([error code]) {
        case kCLErrorDenied:
            NSLog(@"User denied location access");
            break;
        case kCLErrorLocationUnknown:
            NSLog(@"Could not find location");
            break;
        case kCLErrorNetwork:
            NSLog(@"Network Error");
            break;
        default:
            NSLog(@"Unknwon location Error encountered");
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_eventObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [_eventObjects objectAtIndex:indexPath.row][@"title"];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    [super prepareForSegue:segue sender:sender];
    
    //depending on which segue we're using, we setup the next VC's contents accordingly
    if ([segue.identifier isEqual: @"transitionToEvent"]) {
        
        //before we display each event, we set up the contents here
        
        DetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        PFObject *eventObject = [_eventObjects objectAtIndex:path.row];
        NSString *title = eventObject[@"title"];
        NSString *description = eventObject[@"description"];
        NSDate *startTime = eventObject[@"startTime"];
        NSDate *endTime = eventObject[@"endTime"];
        NSString *host = eventObject[@"host" ];
        PFGeoPoint *location = eventObject[@"location"];
        
        detailView.titleText = title;
        detailView.eventDescription = description;
        detailView.startTime = startTime;
        detailView.endTime = endTime;
        detailView.location = location;
        detailView.host = host;
    }
    else if ([segue.identifier isEqual:@"transitionToAddEvent"]) {
        // we simply pass location data to the AddEventViewController so we don't have to grab it there
        AddEventViewController *addView = [segue destinationViewController];
        addView.eventLocation = _currentLocation;
    }
}

@end
