//
//  BSBBusStop.m
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import "BSBBusStop.h"

#import <OHMKit/ObjectMapping.h>

@interface BSBBusStop ()
@property (nonatomic, copy) NSNumber *stop_lat;
@property (nonatomic, copy) NSNumber *stop_lon;
@end

@implementation BSBBusStop

+ (void)load
{
    OHMMappable(self);
    OHMSetMapping(self, @{@"stop_name" : NSStringFromSelector(@selector(stopName)),
                          @"stop_id" : NSStringFromSelector(@selector(stopID)),
                          @"stop_lng" : NSStringFromSelector(@selector(stop_lon)),
    });
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.stop_lat doubleValue], [self.stop_lon doubleValue]);
}

@end
