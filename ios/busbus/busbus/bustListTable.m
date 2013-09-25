//
//  bustListTable.m
//  busbus
//
//  Created by Sam Saccone on 9/23/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "bustListTable.h"

@implementation bustListTable

- (id)init
{
    self = [super init];
    
    NSArray *locations = [[NSArray alloc] initWithObjects:
                          [[CLLocation alloc] initWithLatitude:42.279300689697266 longitude:-71.11894226074219],
                          [[CLLocation alloc] initWithLatitude:42.27154541015625 longitude:-71.17156219482422],
                          [[CLLocation alloc] initWithLatitude:42.25250244140625 longitude:-71.11825561523438],
                          [[CLLocation alloc] initWithLatitude:42.28729248046875 longitude:-71.1271743774414],
                          [[CLLocation alloc] initWithLatitude:42.28920364379883 longitude:-71.12512969970703],
                          [[CLLocation alloc] initWithLatitude:42.28145217895508 longitude:-71.13356018066406],
                          [[CLLocation alloc] initWithLatitude:42.25502395629883 longitude:-71.12413787841797],
                          nil];

                          if(self) {
        NSMutableArray *buses = [[NSMutableArray alloc] init];
        for (int i = 0; i < locations.count; ++i) {
            NSString *name = [NSString stringWithFormat:@"v000%d", i];
            [buses addObject:[[Bus alloc] initWithLocationIdRouteAndStop:[[locations objectAtIndex:i] coordinate] id:name route:@"123" nextStop:@"banks"]];
        }
        
        _busList = buses;
    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.busList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"state cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Bus *bus = [self.busList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = bus.id;
    return cell;
}

@end