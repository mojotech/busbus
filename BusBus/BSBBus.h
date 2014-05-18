//
//  Bus.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "BSBVehicle.h"

@interface BSBBus : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *busID;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) BSBVehicle *vehicle;

@property (nonatomic, readonly) NSString *routeID;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
