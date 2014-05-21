//
//  BSBBusStop.h
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BSBBusStop : NSObject

@property (nonatomic, copy) NSString *stopName;
@property (nonatomic, copy) NSNumber *stopID;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
