//
//  BSBBusStop.h
//  BusBus
//
//  Created by Fabian Canas on 5/18/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BSBBusStop : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *stopName;
@property (nonatomic, copy) NSString *stopID;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSArray *routes;

@end
