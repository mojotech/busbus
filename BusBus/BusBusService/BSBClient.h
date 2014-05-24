//
//  BSBClient.h
//  BusBus
//
//  Created by Ryan on 3/31/14.
//

@import Foundation;
@import CoreLocation;

typedef NS_ENUM(NSUInteger, BSBServiceEntity) {
    BSBServiceEntityBus,
    BSBServiceEntityBusStop,
    BSBServiceEntityAlerts,
};

@interface BSBClient : NSObject

- (void)fetchEntity:(BSBServiceEntity)entity
         completion:(void (^)(NSArray *))completion
            failure:(void (^)(NSError *))failure;

- (void)fetchEntity:(BSBServiceEntity)entity
       nearLocation:(CLLocationCoordinate2D)coordinate
             radius:(CLLocationDistance)distance
         completion:(void (^)(NSArray *))completion
            failure:(void (^)(NSError *))failure;

@end
