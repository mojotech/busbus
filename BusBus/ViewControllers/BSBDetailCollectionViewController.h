//
//  BSBBusCollectionViewController.h
//  BusBus
//
//  Created by Fabian Canas on 5/17/14.
//
//

#import <UIKit/UIKit.h>

#import "BSBBus.h"

@protocol BSBBusCollectionDelegate <NSObject>

- (void)collectionViewSelectedBus:(BSBBus *)bus;

@end

@interface BSBDetailCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, weak) id<BSBBusCollectionDelegate> delegate;
@end
