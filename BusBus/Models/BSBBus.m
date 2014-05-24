//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BSBBus.h"
#import <OHMKit/ObjectMapping.h>
#import "BSBBusStop.h"

@implementation BSBBus

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"stop_sequence" : ohm_key(stopSequence),
                          @"id" : ohm_key(busID)});
}

- (NSString *)nextStopName
{
    NSNumber *stopID = [[self.passage.tripUpdate valueForKeyPath:@"stop_time_update.stop_id"] firstObject];
    NSNumber *stopIndex = [[self.passage.tripUpdate valueForKeyPath:@"stop_time_update.stop_sequence"] firstObject];

    __block BSBBusStop *busStop = nil;

    [self.route.directions enumerateObjectsUsingBlock:^(BSBDirectedRoute *directedRoute, NSUInteger idx, BOOL *stop) {

        NSUInteger testIndex = [stopIndex unsignedIntegerValue] - 1;
        if (testIndex < directedRoute.stops.count) {
            BSBBusStop *testStop = directedRoute.stops[testIndex];

            if ([testStop.stopID integerValue] == [stopID integerValue]) {
                busStop = testStop;
                *stop = YES;
            }
        }

    }];

    return busStop.stopName;
}

- (NSString *)destinationStopName
{
    return nil;
}

- (NSString *)routeID
{
    return self.vehicle.routeID;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.vehicle.position;
}

@end