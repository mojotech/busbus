//
//  BSBVehicle.h
//  BusBus
//
//  Created by Fabian Canas on 5/16/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BSBVehicle : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D position;
@property (nonatomic, readonly) NSString *routeID;

@end
