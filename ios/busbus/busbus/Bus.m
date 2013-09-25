//
//  Bus.m
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "Bus.h"

@implementation Bus

@synthesize id;
@synthesize location;

- (id)init
{
    return [self initWithLocationIdRouteAndStop:CLLocationCoordinate2DMake(40.2, 21.2) id:@"fake1" route:@"1002" nextStop:@"banks and park"];
}

- (id)initWithLocationIdRouteAndStop:(CLLocationCoordinate2D)l id:(NSString *)i route:(NSString *)r nextStop:(NSString *)ns
{
    self = [super init];

    if (self) {
        [self setLocation:l];
        [self setId:i];
        [self setRoute:r];
        [self setNextStop:ns];
    }
    
    return self;

}

- (NSString *)description
{
    NSString *description = [[NSString alloc] initWithFormat:@"lat %f lng %f : %@, %@, %@", location.latitude, location.longitude, id, self.route, self.nextStop];

    return description;
}
@end
