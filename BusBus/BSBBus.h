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

@interface BSBBus : NSObject

@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, assign) NSUInteger route;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, strong) MKPointAnnotation *annotation;

@end
