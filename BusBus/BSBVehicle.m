//
//  BSBVehicle.m
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import "BSBVehicle.h"

#import <OHMKit/ObjectMapping.h>

@implementation BSBVehicle

+ (void)load
{
    OHMMappable([BSBVehicle class]);
    
    OHMValueAdapterBlock coordinateAdapter = ^id(NSDictionary * position) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [position[@"latitude"] doubleValue];
        coordinate.longitude = [position[@"longitude"] doubleValue];
        return [NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)];
    };
    OHMSetAdapter(self, @{NSStringFromSelector(@selector(position)) : coordinateAdapter});
}

- (void)setPosition:(CLLocationCoordinate2D)position
{
    _position = position;
    
}

@end
