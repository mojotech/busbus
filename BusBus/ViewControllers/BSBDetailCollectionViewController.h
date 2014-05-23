//
//  BSBBusCollectionViewController.h
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import <UIKit/UIKit.h>

#import "BSBBus.h"
#import "BSBBusCollectionDelegate.h"
#import "BSBBusDataSource.h"

@interface BSBDetailCollectionViewController : UICollectionViewController
@property (nonatomic, strong) BSBBusDataSource *dataSource;
@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, weak) id<BSBBusCollectionDelegate> delegate;
@end
