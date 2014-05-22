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

@property (nonatomic, strong) NSArray *currentBusses;
@property (nonatomic, strong) CLLocation *mockLocation;
@property (nonatomic, strong) NSArray *busStops;

- (void)updateCurrentBusLocations;
- (void)findCurrentLocation;
+ (instancetype)sharedManager;

@end
