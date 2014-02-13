//
//  Bus.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "Bus.h"

@implementation Bus

@synthesize location;
@synthesize id;

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
