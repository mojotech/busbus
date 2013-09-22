//
//  Bus.h
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Bus : NSObject

- (id)initWithLocation:(CLLocationCoordinate2D)l id:(NSString *)i;

@property(nonatomic) CLLocationCoordinate2D location;
@property(nonatomic) NSString *id;
@end
