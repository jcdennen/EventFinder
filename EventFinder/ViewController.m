//
//  ViewController.m
//  EventFinder
//
//  Created by Jeremy Dennen on 10/20/15.
//  Copyright © 2015 Jeremy Dennen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSArray *labels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labels = [NSArray arrayWithObjects:@"Event 1", @"Event 2", @"Event 3", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.labels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [self.labels objectAtIndex:indexPath.row];
    return cell;
}

@end
