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
    return [self initWithLocation:CLLocationCoordinate2DMake(40.2, 21.2) id:@"fake"];
}

- (id)initWithLocation:(CLLocationCoordinate2D)l id:(NSString *)i
{
    self = [super init];
    
    if (self) {
        [self setLocation:l];
        [self setId:i];
    }
    
    return self;
}

- (NSString *)description
{
    NSString *description = [[NSString alloc] initWithFormat:@"lat %f lng %f : %@", location.latitude, location.longitude, id];

    return description;
}
@end
