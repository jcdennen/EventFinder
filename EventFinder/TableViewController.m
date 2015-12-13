//
//  TableViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 11/8/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"


@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray *eventTitles;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventTitles = [[NSMutableArray alloc] initWithObjects:@"Event 1", @"Event 2", @"Event 3", @"Event 4", nil];
    
    __block PFGeoPoint *currentLocation;
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        //
        if (!error) {
            currentLocation = geoPoint;
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
        
    PFQuery *query = [PFQuery queryWithClassName:@"EventObject"];
    [query whereKey:@"location" nearGeoPoint:currentLocation withinMiles:[[PFUser currentUser][@"locationRadius"] doubleValue]];
    _eventObjects = [[NSMutableArray alloc] initWithArray:[query findObjects]];
    
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
    return [self.eventTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [self.eventTitles objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqual: @"transitionToEvent"]) {
    
        DetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSString *title = [self.eventTitles objectAtIndex:path.row];
        
        detailView.titleText = title;
    }
}

@end
