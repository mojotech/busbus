//
//  BSBBusStop.m
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import "BSBBusStop.h"
#import "BSBBusRoute.h"

#import <OHMKit/ObjectMapping.h>

@interface BSBBusStop ()
@property (nonatomic, copy) NSNumber *stop_lat;
@property (nonatomic, copy) NSNumber *stop_lon;
@end

@implementation BSBBusStop

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"stop_name" : ohm_key(stopName),
                          @"stop_id" : ohm_key(stopID),
                          @"stop_lng" : ohm_key(stop_lon),
    });
    OHMSetArrayClasses(self, @{ohm_key(routes) : [BSBBusRoute class]});
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.stop_lat doubleValue], [self.stop_lon doubleValue]);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Stop::%@ , id:%@", self.stopName, self.stopID];
}

@end
