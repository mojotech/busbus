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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BusBusViewController.h"
#import "BOClient.h"
#import "BSBBus.h"

@interface BOManager : NSObject

@property (nonatomic, strong) NSArray *currentBusses;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;

- (void)updateCurrentBusLocations;
- (void)findCurrentLocation;
+ (instancetype)sharedManager;

@end
