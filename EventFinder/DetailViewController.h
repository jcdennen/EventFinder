//
//  DetailViewController.h
//  EventFinder
//
//  Created by Jeremy Dennen on 11/8/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSString *host;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *hostLabel;

@end
