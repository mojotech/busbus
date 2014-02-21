//
//  BusListTable.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusListTable.h"
#import "Bus.h"

@implementation BusListTable

- (id)init
{
    self = [super init];
    
    if(self) {

    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.busList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSDictionary *busTableItem = [self.busList objectAtIndex:indexPath.row];
    NSString *route = [NSString stringWithFormat:@"%@", [busTableItem objectForKey:@"route"]];
    cell.textLabel.text = route;
    return cell;
}
@end
