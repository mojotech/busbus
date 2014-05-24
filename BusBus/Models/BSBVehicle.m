//
//  BSBVehicle.m
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import "BSBVehicle.h"

#import <OHMKit/ObjectMapping.h>


@interface BSBTrip : NSObject
@property (nonatomic, copy) NSString *routeID;
@end

@implementation BSBTrip
+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"route_id" : ohm_key(routeID)});
}
@end

@interface BSBVehicle ()
@property (nonatomic, strong) BSBTrip *trip;
@end

@implementation BSBVehicle

+ (void)load
{
    OHMMappable(self);

    OHMValueAdapterBlock coordinateAdapter = ^id(NSDictionary *position) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [position[@"latitude"] doubleValue];
        coordinate.longitude = [position[@"longitude"] doubleValue];
        return [NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)];
    };
    OHMSetAdapter(self, @{ohm_key(position) : coordinateAdapter});
}

- (NSString *)routeID
{
    return self.trip.routeID;
}

@end
