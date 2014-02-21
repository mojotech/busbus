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

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, strong) NSDictionary *busJSON;

@property(readwrite) CLLocationCoordinate2D location;
@property(nonatomic, strong) NSString *lat;
@property(nonatomic, strong) NSString *lng;
@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *route;
@property(nonatomic, strong) NSString *nextStop;

- (id)initWithRoute:(NSString *)bRoute
                lat:(NSString *)bLat
                lng:(NSString *)bLng
           nextStop:(NSString *)bNextStop;

@end
