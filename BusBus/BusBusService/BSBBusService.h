//
//  BOManager.h
//  BusBus
//
//  Created by Ryan on 4/2/14.
//
//

@import Foundation;
@import CoreLocation;
@import MapKit;

#import "BusBusViewController.h"
#import "BSBClient.h"
#import "BSBBus.h"

@interface BSBBusService : NSObject

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, strong) NSArray *busStops;
@property (nonatomic, strong) CLLocation *mockLocation;

- (void)updateCurrentBusLocations;

+ (instancetype)sharedManager;

@end
