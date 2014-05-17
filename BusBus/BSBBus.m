//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BSBBus.h"
#import <OHMKit/ObjectMapping.h>

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

@end