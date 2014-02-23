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

    cell.backgroundColor = [UIColor clearColor];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = self.busList[indexPath.row][@"address"];
    return cell;
}
@end
