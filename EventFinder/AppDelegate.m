//
//  AppDelegate.m
//  EventFinder
//
//  Created by Jeremy Dennen on 10/20/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()
@property CLLocationManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([CLLocationManager locationServicesEnabled]) {
        _manager = [[CLLocationManager alloc] init];
        _manager.distanceFilter = 100.0;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.delegate = self;
        if ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0 ) {
            [_manager requestAlwaysAuthorization];
        }
    }
    
    // Power app with Local Datastore
     [Parse enableLocalDatastore];
    
    // Initialize Parse
    [Parse setApplicationId:@"0dYzQuR501xsrN6tIQPHFYHXHIrgODxxxeWsk5iw" clientKey:@"ZILiLNGeHvG2iS5WTPC6e13hlzhVUccRZdQ0ByGH"];
    
    // optionally track stats around application opens
    // [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [_manager stopUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [_manager startUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
