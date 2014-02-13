//
//  Bus.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Bus : NSObject

- (id)initWithLocationIdRouteAndStop:(CLLocationCoordinate2D)l id:(NSString *)i route:(NSString *)r nextStop:(NSString *)ns;

@property(readwrite) CLLocationCoordinate2D location;
@property(readwrite) NSString *id;
@property(readwrite) NSString *route;
@property(readwrite) NSString *nextStop;


@end
