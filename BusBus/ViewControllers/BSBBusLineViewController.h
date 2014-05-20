//
//  BSBBusLineViewController.h
//  BusBus
//
//  Created by Fabian Canas on 5/19/14.
//
//

#import <UIKit/UIKit.h>
#import "BSBBusCollectionDelegate.h"

static CGFloat kBSBBusLineGroupHeight = 40.;

@interface BSBBusLineViewController : UICollectionViewController

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, weak) id<BSBBusCollectionDelegate> delegate;

@end
