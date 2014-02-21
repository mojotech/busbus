//
//  BusListTable.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <UIKit/UIKit.h>

@interface BusListTable : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *busList;

@end
