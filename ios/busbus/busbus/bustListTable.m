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
    
    if(self) {
        NSMutableArray *buses = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; ++i) {
            NSString *name = [NSString stringWithFormat:@"v000%d", i];
            [buses addObject:[[Bus alloc] initWithLocationIdRouteAndStop:CLLocationCoordinate2DMake(41.523, -71.4531) id:name route:@"123" nextStop:@"banks"]];
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