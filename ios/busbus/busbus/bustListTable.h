//
//  bustListTable.h
//  busbus
//
//  Created by Sam Saccone on 9/23/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface bustListTable : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *busList;


@end
