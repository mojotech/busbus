//
//  BSBBusDataSource.m
//  BusBus
//
//  Created by Fabian Canas on 5/22/14.
//
//

#import "BSBBus.h"
#import "BSBBusDataSource.h"
#import "BSBBusPin.h"
#import "BSBBusPresenter.h"

NSString *const BSBBusCellReuseIdentifier = @"BSBBusDetailCell";

@implementation BSBBusDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell<BSBBusPresenter> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BSBBusCellReuseIdentifier
                                                                                            forIndexPath:indexPath];
    BSBBus *bus = [self busAtIndexPath:indexPath];
    cell.bus = bus;

    return cell;
}

- (BSBBus *)busAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = 0;
    if ([indexPath respondsToSelector:@selector(row)]) {
        index = indexPath.row;
    } else if ([indexPath respondsToSelector:@selector(item)]) {
        index = indexPath.item;
    }

    if (index >= self.buses.count) {
        return nil;
    }

    return self.buses[index];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    BSBBus *bus = (BSBBus *) annotation;

    static NSString *busPinIdentifier = @"busPinIdentifier";
    BSBBusPin *pin = (BSBBusPin *) [mapView dequeueReusableAnnotationViewWithIdentifier:busPinIdentifier];
    if (pin == nil ) {
        pin = [[BSBBusPin alloc] initWithAnnotation:annotation
                                    reuseIdentifier:busPinIdentifier];
    }

    NSString *busNumber = bus.routeID;

    pin.pinText = busNumber;
    pin.color = [BSBAppearance colorForBus:bus];

    pin.canShowCallout = NO;
    return pin;
}

@end
