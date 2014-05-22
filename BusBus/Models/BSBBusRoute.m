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
    OHMSetMapping(self, @{@"direction_id" : NSStringFromSelector(@selector(directionID)),
                          @"direction_name" : NSStringFromSelector(@selector(directionName)),
                          @"stop" : NSStringFromSelector(@selector(stops)),
                          });
    OHMSetArrayClasses(self, @{NSStringFromSelector(@selector(stops)) : [BSBBusStop class]});
}

@end

@implementation BSBBusRoute

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"direction" : NSStringFromSelector(@selector(directions))});
    OHMSetArrayClasses(self, @{ NSStringFromSelector(@selector(directions)) : [BSBDirectedRoute class] });
}

@end
