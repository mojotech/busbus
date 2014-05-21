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
#import "BOClient.h"
#import "BSBBus.h"

@interface BSBBusService : NSObject

@property (nonatomic, strong) NSArray *currentBusses;
@property (nonatomic, strong) NSArray *busStops;
@property (nonatomic, strong) CLLocation *mockLocation;

- (void)updateCurrentBusLocations;
- (void)findCurrentLocation;
+ (instancetype)sharedManager;

@end
