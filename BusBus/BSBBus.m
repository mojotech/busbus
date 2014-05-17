//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BSBBus.h"
#import <OHMKit/ObjectMapping.h>

@interface BSBBus ()
@property (nonatomic, readwrite, strong) MKPointAnnotation *annotation;
@end

@implementation BSBBus

+ (void)load
{
    OHMMappable([BSBBus class]);
    OHMSetMapping([BSBBus class], @{@"nextStop" : NSStringFromSelector(@selector(address))});
    OHMSetMapping([BSBBus class], @{@"route_id" : NSStringFromSelector(@selector(routeID))});
    OHMSetMapping([BSBBus class], @{@"id" : NSStringFromSelector(@selector(busID))});
}

- (void)setVehicle:(BSBVehicle *)vehicle
{
    _vehicle = vehicle;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.vehicle.position;
}

- (MKPointAnnotation *)annotation
{
    if (_annotation == nil) {
        _annotation = [[MKPointAnnotation alloc] init];
        _annotation.coordinate = self.coordinate;
    }
    return _annotation;
}

@end