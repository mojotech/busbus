//
//  BOClient.h
//  BusBus
//
//  Created by Ryan on 3/31/14.
//
//

@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa.h>

@interface BOClient : NSObject

- (void)busLocationsNearLocation:(CLLocationCoordinate2D)coordinate
                       completion:(void(^)(NSArray *))completion
                          failure:(void(^)(NSError *))failure;

- (void)stopsNearLocation:(CLLocationCoordinate2D)coordinate completion:(void(^)(NSArray *))completion failure:(void(^)(NSError *))failure;

@end
