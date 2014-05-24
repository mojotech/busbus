//
//  BSBRoute.m
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import "BSBBusRoute.h"

#import <OHMKit/ObjectMapping.h>

#import "BSBBusStop.h"


@implementation BSBDirectedRoute

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"direction_id" : ohm_key(directionID),
                          @"direction_name" : ohm_key(directionName),
                          @"stop" : ohm_key(stops),
                          @"stop_ids" : ohm_key(stopIDs)
                          });
    OHMSetArrayClasses(self, @{ohm_key(stops) : [BSBBusStop class]});
}

@end

@implementation BSBBusRoute

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"direction" : ohm_key(directions)});
    OHMSetArrayClasses(self, @{ohm_key(directions) : [BSBDirectedRoute class]});
}

@end
