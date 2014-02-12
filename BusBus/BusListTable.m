//
//  BusListTable.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusListTable.h"

@implementation BusListTable

- (id)init
{
    self = [super init];
    
//    NSArray *locations = [[NSArray alloc] initWithObjects:
//                          [[CLLocation alloc] initWithLatitude:42.279300689697266 longitude:-71.11894226074219],
//                          [[CLLocation alloc] initWithLatitude:42.27154541015625 longitude:-71.17156219482422],
//                          [[CLLocation alloc] initWithLatitude:42.25250244140625 longitude:-71.11825561523438],
//                          [[CLLocation alloc] initWithLatitude:42.28729248046875 longitude:-71.1271743774414],
//                          [[CLLocation alloc] initWithLatitude:42.28920364379883 longitude:-71.12512969970703],
//                          [[CLLocation alloc] initWithLatitude:42.28145217895508 longitude:-71.13356018066406],
//                          [[CLLocation alloc] initWithLatitude:42.25502395629883 longitude:-71.12413787841797],
//                          nil];
//    
//    if(self) {
//        NSMutableArray *buses = [[NSMutableArray alloc] init];
//        for (int i = 0; i < locations.count; ++i) {
//            NSString *name = [NSString stringWithFormat:@"v000%d", i];
//            [buses addObject:[[Bus alloc] initWithLocationIdRouteAndStop:[[locations objectAtIndex:i] coordinate] id:name route:@"123" nextStop:@"banks"]];
//        }
//        
//        _busList = buses;
//    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"hey");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}


@end
