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

@property(nonatomic, readwrite) CLLocationCoordinate2D location;
@property(nonatomic, copy) NSString *id;
@end
