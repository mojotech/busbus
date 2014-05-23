//
//  BSBBusDataSource.h
//  BusBus
//
//  Created by Fabian Canas on 5/22/14.
//
//

#import <Foundation/Foundation.h>

@import MapKit;

extern NSString *const BSBBusCellReuseIdentifier;

@interface BSBBusDataSource : NSObject<UICollectionViewDataSource, MKMapViewDelegate>

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, copy) NSString *cellReuseIdentifier;

- (BSBBus *)busAtIndexPath:(NSIndexPath *)indexPath;

@end
