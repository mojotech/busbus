//
//  Bus.m
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import "Bus.h"

@implementation Bus

- (id)init
{
    return [self initWithLocation:CLLocationCoordinate2DMake(40.2, 21.2) id:@"fake"];
}

- (id)initWithLocation:(CLLocationCoordinate2D)l id:(NSString *)i
{
    self = [super init];
    
    if (self) {
        _location = l;
        _id = i;
    }
    
    return self;
}
@end
