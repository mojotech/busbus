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
#import <ReactiveCocoa.h>
#import "BusBusViewController.h"
#import "BOClient.h"
#import "Bus.h"

@interface BOManager : NSObject

@property (nonatomic, strong, readwrite) Bus *currentBusses;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) BOClient *client;

- (RACSignal *)updateCurrentBusLocations;
- (void)findCurrentLocation;
+ (instancetype)sharedManager;

@end
